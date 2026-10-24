# MCP servers template

`mcps.apm.yml` declares all user-configured MCP servers as self-defined APM
dependencies. APM writes each server's launch command into the harness MCP config;
it does **not** install the programs those commands invoke. Install the prerequisites
for the servers you use, export the required environment variables, then install.

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
curl -LsSf https://astral.sh/uv/install.sh | sh
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

The launch command runs `~/tools/office-mcp/.venv/bin/python ~/tools/office-mcp/server.py`.
Provide that layout:

```sh
git clone <office-mcp-repo> ~/tools/office-mcp
python3 -m venv ~/tools/office-mcp/.venv
~/tools/office-mcp/.venv/bin/pip install -r ~/tools/office-mcp/requirements.txt
```

Install it elsewhere? Update the `command`/`args` paths in `mcps.apm.yml`.

### engram

The launch command runs `~/.local/bin/engram`. Install the Engram CLI so that binary
exists on that path.

## Environment variables

APM keeps secrets as `${VAR}` in the config and resolves them at server start, so nothing
sensitive is written to disk. Export these before launching a harness:

| Variable                       | Used by                | Purpose                                             |
| ------------------------------ | ---------------------- | --------------------------------------------------- |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github`               | Bearer token for the GitHub Copilot MCP endpoint    |
| `DEFAULT_ENGRAM_PROJECT`       | `engram`               | project scope passed to `engram --project`          |
| `HOME`                         | `office-mcp`, `engram` | resolves the binary/script paths (set by the shell) |

```sh
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
export DEFAULT_ENGRAM_PROJECT=my-project
```

## Notes

- `disabled` / `disabledTools` have no modeled APM field; they pass through as extra keys
  and broadcast to **every** target in `targets:` (parse-time warning). Kiro honors both;
  other harnesses may ignore them.
- `document-loader`'s source `autoApprove: []` equals the default empty allowlist and has
  no APM equivalent, so it is dropped (no behavior change).
- `powers.mcpServers.power-context7-context7` from the user config is a Kiro _power_, not a
  user MCP server, and is not packaged.
