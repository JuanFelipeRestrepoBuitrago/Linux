# MCP servers template

`mcps.apm.yml` declares all user-configured MCP servers as self-defined APM
dependencies. APM writes each server's launch command into the harness MCP config;
it does **not** install the programs those commands invoke. Install the prerequisites
for the servers you use, export the required environment variables, then install.

Works on Linux (bash/zsh), macOS, WSL, and Windows (PowerShell) — prerequisite/env commands
below are given per OS. The default `command`/`args` paths in `mcps.apm.yml` use
Linux/macOS-style paths; on Windows adjust them (see office-mcp below).

## Install

```sh
# copy mcps.apm.yml into a project as its apm.yml (or merge its dependencies.mcp block), then:
apm install --only mcp
```

## Servers at a glance

| Server            | Default  | Transport | Needs installed                              |
| ----------------- | -------- | --------- | -------------------------------------------- |
| `docker`          | disabled | stdio     | `uvx` + running Docker daemon                |
| `fetch`           | enabled  | stdio     | `uvx`                                        |
| `github`          | enabled  | http      | nothing to install — a GitHub token          |
| `linkedin`        | disabled | stdio     | `uvx`                                        |
| `document-loader` | enabled  | stdio     | `uvx`                                        |
| `office-mcp`      | enabled  | stdio     | a Python venv at `~/tools/office-mcp/`       |
| `aws-mcp`         | disabled | stdio     | `uvx`                                        |
| `engram`          | enabled  | stdio     | the `engram` binary at `~/.local/bin/engram` |

A disabled server is still written to the config; the harness just doesn't start it.
Enable one by removing its `disabled: true` line.

## Prerequisites

### uv / uvx (docker, fetch, linkedin, document-loader, aws-mcp)

`uvx` ships with `uv`. Install:

```sh
# Linux / macOS / WSL
curl -LsSf https://astral.sh/uv/install.sh | sh
```

```powershell
# Windows (PowerShell)
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

See https://docs.astral.sh/uv/getting-started/installation/. The server packages
(`docker-mcp-server`, `mcp-server-fetch`, `mcp-server-linkedin`,
`awslabs.document-loader-mcp-server`, `mcp-proxy-for-aws`) are fetched by `uvx` on first
run — no separate install.

### Docker (docker server)

Only needed if you enable the `docker` server (and want a daemon for it to talk to).
Primary guide: [`programming_languages/docker_help.md`](../../programming_languages/docker_help.md).
Optional fallback: official Docker Engine docs at https://docs.docker.com/engine/install/.
The `github` server here is remote HTTP and needs **no** Docker.

### office-mcp

The launch command runs `~/tools/office-mcp/.venv/bin/python ~/tools/office-mcp/server.py`
(on Windows, `%USERPROFILE%\tools\office-mcp\.venv\Scripts\python.exe`). Provide that layout:

```sh
# Linux / macOS / WSL
git clone <office-mcp-repo> ~/tools/office-mcp
python3 -m venv ~/tools/office-mcp/.venv
~/tools/office-mcp/.venv/bin/pip install -r ~/tools/office-mcp/requirements.txt
```

```powershell
# Windows (PowerShell)
git clone <office-mcp-repo> "$env:USERPROFILE\tools\office-mcp"
python -m venv "$env:USERPROFILE\tools\office-mcp\.venv"
& "$env:USERPROFILE\tools\office-mcp\.venv\Scripts\pip.exe" install -r "$env:USERPROFILE\tools\office-mcp\requirements.txt"
```

Install it elsewhere, or on Windows? Update the `command`/`args` paths in `mcps.apm.yml`
accordingly (the defaults use Linux/macOS-style paths).

### engram

The launch command runs `~/.local/bin/engram` (on Windows, the `engram` binary must be on
`%PATH%`). Install the Engram CLI so that binary exists on that path.

## Environment variables

APM keeps secrets as `${VAR}` in the config and resolves them at server start, so nothing
sensitive is written to disk. Export these before launching a harness:

| Variable                       | Used by                | Purpose                                                                                     |
| ------------------------------ | ---------------------- | ------------------------------------------------------------------------------------------- |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github`               | Bearer token for the GitHub Copilot MCP endpoint                                            |
| `DEFAULT_ENGRAM_PROJECT`       | `engram`               | project scope passed to `engram --project`                                                  |
| `HOME`                         | `office-mcp`, `engram` | resolves the binary/script paths (set by the shell)                                         |
| `FASTMCP_LOG_LEVEL`            | `document-loader`      | log level for the server. Optional tuning; recommended `ERROR`                              |
| `UV_HTTP_TIMEOUT`              | `linkedin`             | uvx HTTP timeout in seconds. Optional tuning; recommended `300`                             |
| `PYTHONUTF8`                   | `office-mcp`           | Python UTF-8 mode. **Required**; must be `1` or the server breaks on non-ASCII output       |
| `PYTHONIOENCODING`             | `office-mcp`           | Python I/O encoding. **Required**; must be `utf-8` or the server breaks on non-ASCII output |

```sh
# Linux / macOS / WSL
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
export DEFAULT_ENGRAM_PROJECT=my-project
export FASTMCP_LOG_LEVEL=ERROR                # optional; DEBUG/INFO/WARNING/ERROR
export UV_HTTP_TIMEOUT=300                     # optional; only used by the disabled linkedin server
export PYTHONUTF8=1                            # required by office-mcp
export PYTHONIOENCODING=utf-8                  # required by office-mcp
```

```powershell
# Windows (PowerShell) — current session (use setx NAME "value" to persist)
$env:GITHUB_PERSONAL_ACCESS_TOKEN = "ghp_..."
$env:DEFAULT_ENGRAM_PROJECT = "my-project"
$env:FASTMCP_LOG_LEVEL = "ERROR"               # optional
$env:UV_HTTP_TIMEOUT = "300"                    # optional; only used by the disabled linkedin server
$env:PYTHONUTF8 = "1"                           # required by office-mcp
$env:PYTHONIOENCODING = "utf-8"                 # required by office-mcp
```

## Notes

- `disabled` / `disabledTools` have no modeled APM field; they pass through as extra keys
  and broadcast to **every** target in `targets:` (parse-time warning). Kiro honors both;
  other harnesses may ignore them.
- `document-loader`'s source `autoApprove: []` equals the default empty allowlist and has
  no APM equivalent, so it is dropped (no behavior change).
- `powers.mcpServers.power-context7-context7` from the user config is a Kiro _power_, not a
  user MCP server, and is not packaged.
