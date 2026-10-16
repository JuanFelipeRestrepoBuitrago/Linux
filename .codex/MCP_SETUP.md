# Codex MCP Servers Setup (Ubuntu / WSL)

Setup guide for the MCP servers declared in [`config.toml`](./config.toml) under
`[mcp_servers.*]`. Target platform: Ubuntu-based systems, including WSL. All
commands use Ubuntu/Linux syntax (`apt`, bash/zsh, `/` paths).

## Table of Contents

- [How Codex reads this config](#how-codex-reads-this-config)
- [Common prerequisites](#common-prerequisites)
  - [1. Node.js (`npx`)](#1-nodejs-npx)
  - [2. uv / uvx (Python tool runner)](#2-uv--uvx-python-tool-runner)
  - [3. Docker](#3-docker)
- [Per-server setup](#per-server-setup)
  - [context7](#context7)
  - [fetch](#fetch)
  - [docker](#docker)
  - [engram](#engram)
  - [github-personal](#github-personal)
  - [linkedin](#linkedin)
  - [document-loader](#document-loader)
  - [office-mcp](#office-mcp)
- [Secrets](#secrets)
- [Verifying and troubleshooting](#verifying-and-troubleshooting)

## How Codex reads this config

- Each server is a TOML table `[mcp_servers.<name>]` with `command`, `args`,
  `enabled`, and optional `startup_timeout_sec` and `disabled_tools`.
- Per-server environment variables go in a nested table
  `[mcp_servers.<name>.env]`.
- `enabled = false` keeps a server defined but not started. Flip it to `true`
  once its prerequisites are installed.
- `disabled_tools` is an allow-trimming list: the named tools are hidden even
  when the server runs. Remove entries as you need those tools.
- Placeholders to replace before enabling a server: `YOUR_PROJECT` (engram),
  `YOUR_GITHUB_TOKEN` (github-personal), `YOUR_FOLDER` (office-mcp).

> Unlike shell env expansion, the token/paths in this file are read literally.
> Keep real secrets out of any committed copy of `config.toml` (see
> [Secrets](#secrets)).

## Common prerequisites

Three runtimes cover every server: `npx` (Node), `uvx` (uv), and `docker`.
office-mcp additionally needs a local Python virtualenv.

### 1. Node.js (`npx`)

Needed by: `context7`. `npx` ships with Node.js; manage Node with `nvm`
(see `../linux_config/programming_languages/nodejs_help.md`).

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# Reload your shell, then:
nvm install --lts
nvm alias default 'lts/*'
node --version && npx --version
```

### 2. uv / uvx (Python tool runner)

Needed by: `fetch`, `docker` (docker-mcp-server), `linkedin`, `document-loader`.
`uvx` is part of `uv` and downloads each server on demand (no `uvx install`).

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
source ~/.zshrc
uv --version && uvx --version
```

If `uvx` is not found, add its directory to PATH:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

### 3. Docker

Needed by: `github-personal` (runs the GitHub MCP server image). Optional for
the `docker` MCP server, which talks to your Docker daemon.
See `../linux_config/programming_languages/docker_help.md` for the full guide.

```bash
sudo apt update && sudo apt install -y \
  apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo groupadd docker 2>/dev/null; sudo usermod -aG docker $USER
# Log out/in (or restart WSL), then:
docker run --rm hello-world
```

## Per-server setup

### context7

Up-to-date library/documentation lookups.

- Runtime: `npx` — install [Node.js](#1-nodejs-npx).
- Credentials: none.
- Status in config: `enabled = true`.

```bash
npx -y @upstash/context7-mcp --help
```

### fetch

Retrieve and convert web content.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- Credentials: none.
- Status in config: `enabled = true`.

```bash
uvx mcp-server-fetch --help
```

### docker

Manage Docker resources through MCP.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- Requires a running Docker daemon — install [Docker](#3-docker).
- Status in config: `enabled = false`, with a `disabled_tools` list of the
  destructive operations. Set `enabled = true` to use it.

```bash
docker info          # daemon reachable
uvx docker-mcp-server --help
```

### engram

Persistent project memory. Commented out in `config.toml`.

- Runtime: a local `engram` binary at `/home/pipas/.local/bin/engram`.
- Confirm the binary and replace `YOUR_PROJECT` with your project identifier,
  then uncomment the whole block.

```bash
command -v engram || ls -l ~/.local/bin/engram
```

### github-personal

GitHub operations via the official GitHub MCP server image.

- Runtime: `docker` — install [Docker](#3-docker). The image
  `ghcr.io/github/github-mcp-server` is pulled on first run.
- Requires a GitHub Personal Access Token. In `config.toml` the token is read
  literally from `[mcp_servers.github-personal.env]` — replace
  `YOUR_GITHUB_TOKEN`. The `-e GITHUB_PERSONAL_ACCESS_TOKEN` arg (no value)
  tells Docker to inherit it from that env table.
- Status in config: `enabled = false`, with a `disabled_tools` list of write
  operations. Set `enabled = true` to use it.

Create a token at <https://github.com/settings/tokens> with only the scopes you
need (e.g. `repo`, `read:org`). Pre-pull the image to confirm access:

```bash
docker pull ghcr.io/github/github-mcp-server
```

### linkedin

LinkedIn MCP server.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- `UV_HTTP_TIMEOUT = "300"` (and `startup_timeout_sec = 300`) tolerate slow
  first-run downloads.
- Check the upstream package for required credentials; add them under
  `[mcp_servers.linkedin.env]` (literal values, keep them out of committed copies).
- Status in config: `enabled = true`.

```bash
UV_HTTP_TIMEOUT=300 uvx mcp-server-linkedin@latest --help
```

### document-loader

AWS Labs document loader MCP server.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- Credentials: none; `FASTMCP_LOG_LEVEL = "ERROR"` just reduces log noise.
- Status in config: `enabled = true`.

```bash
uvx awslabs.document-loader-mcp-server@latest --help
```

### office-mcp

Local Office documents MCP server, run from a Python virtualenv you create.

- Runtime: a project-local Python venv. `config.toml` points at:
  - interpreter: `/home/pipas/tools/office-mcp/.venv/bin/python`
  - server: `/home/pipas/tools/office-mcp/server.py`
- Replace `YOUR_FOLDER` (`OFFICE_MCP_DEFAULT_FOLDER`) with the directory the
  server should read documents from, e.g. `/home/pipas/Documents`.

Set up the venv (Ubuntu needs `python3-venv`):

```bash
sudo apt update && sudo apt install -y python3-venv
mkdir -p ~/tools/office-mcp
# Place the office-mcp project (including server.py) in ~/tools/office-mcp
python3 -m venv ~/tools/office-mcp/.venv
~/tools/office-mcp/.venv/bin/pip install --upgrade pip
~/tools/office-mcp/.venv/bin/pip install -r ~/tools/office-mcp/requirements.txt
```

Confirm the paths referenced in `config.toml` exist:

```bash
ls -l ~/tools/office-mcp/.venv/bin/python ~/tools/office-mcp/server.py
```

## Secrets

`config.toml` reads values literally; there is no shell `${VAR}` expansion for
these fields. Therefore:

- Keep the real `YOUR_GITHUB_TOKEN` (and any LinkedIn credentials) out of any
  committed copy of `config.toml`. If this repo is versioned, gitignore the file
  with real secrets and commit only a sanitized template with placeholders.
- Restrict token scopes to the minimum required.
- After changing a token, restart Codex so the new value is read.

## Verifying and troubleshooting

- `command -v npx uvx docker` — confirm the runtimes are on PATH.
- `uvx`/`npx` download packages on first run; the first start can be slow, which
  is why `linkedin` uses a 300s timeout.
- TOML validity: each `[mcp_servers.<name>]` needs its own header; env tables are
  `[mcp_servers.<name>.env]`. Validate with:

  ```bash
  python3 -c "import tomllib,sys; tomllib.load(open('/home/pipas/Linux/.codex/config.toml','rb')); print('OK')"
  ```

- `docker` / `github-personal`: permission errors usually mean your user is not
  in the `docker` group yet, or you have not logged out and back in.
- `office-mcp`: a "no such file" error means the `.venv/bin/python` or
  `server.py` paths do not exist — recheck the venv setup.
