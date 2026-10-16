# MCP Servers Setup (Ubuntu / WSL)

This guide explains how to set up every MCP server declared in
`.kiro/settings/mcp.json.example` on an Ubuntu-based system (including WSL).

All commands use Ubuntu/Linux syntax (`apt`, bash/zsh, `/` paths).

> This file lives at the workspace root because writing into
> `.kiro/settings/` is blocked by a permissions rule. Move it there manually if
> you want it alongside the config:
> `mv MCP_SETUP.md .kiro/settings/README.md`

## Table of Contents

- [How Kiro loads this config](#how-kiro-loads-this-config)
- [Common prerequisites](#common-prerequisites)
    - [1. Node.js (`npx`)](#1-nodejs-npx)
    - [2. uv / uvx (Python tool runner)](#2-uv--uvx-python-tool-runner)
    - [3. Docker](#3-docker)
- [Enabling the config](#enabling-the-config)
- [Per-server setup](#per-server-setup)
    - [context7](#context7)
    - [docker](#docker)
    - [engram](#engram)
    - [fetch](#fetch)
    - [github-personal](#github-personal)
    - [linkedin](#linkedin)
    - [document-loader](#document-loader)
    - [office-mcp](#office-mcp)
- [Secrets and environment variables](#secrets-and-environment-variables)
- [Verifying and troubleshooting](#verifying-and-troubleshooting)

## How Kiro loads this config

- Workspace config lives at `.kiro/settings/mcp.json`.
- A user-level config can also exist at `~/.kiro/settings/mcp.json`.
- Configs merge with precedence: user < workspace. A server defined at the
  workspace level overrides the same server defined at user level.
- `"disabled": true` keeps a server defined but not started. Flip it to
  `false` once its prerequisites are installed.
- After editing `mcp.json`, reconnect servers from the MCP Server view in the
  Kiro panel, or search the command palette for `MCP`.

> Never commit real tokens or passwords. Note that Kiro does NOT reliably expand
> `${VAR}` in `mcp.json`; put secrets literally in your gitignored global config
> (see [Secrets and environment variables](#secrets-and-environment-variables)).

## Common prerequisites

The servers use four runtimes: `npx` (Node), `uvx` (uv), `docker`, and a local
Python virtualenv. Install the ones you need.

### 1. Node.js (`npx`)

Needed by: `context7`.

`npx` ships with Node.js. The recommended way to manage Node on this setup is
`nvm` (see `linux_config/programming_languages/nodejs_help.md`).

```bash
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
```

Add nvm to your shell (`~/.zshrc`), then reload:

```bash
echo '# NodeJS Package Manager' >> ~/.zshrc && \
echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"' >> ~/.zshrc && \
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.zshrc && \
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc
source ~/.zshrc
```

Install and set a default Node LTS:

```bash
nvm install --lts
nvm alias default 'lts/*'
node --version && npx --version
```

### 2. uv / uvx (Python tool runner)

Needed by: `docker` (docker-mcp-server), `fetch`, `linkedin`, `document-loader`.

`uvx` is part of `uv`, a fast Python package/tool runner. It downloads and runs
each server on demand (there is no `uvx install`).

```bash
# Install uv (installs uvx too)
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Reload your shell so `~/.local/bin` is on PATH, then verify:

```bash
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

See `linux_config/programming_languages/docker_help.md` for the full guide.
Quick path for Ubuntu:

```bash
# Dependencies
sudo apt update && sudo apt install -y \
  apt-transport-https ca-certificates curl software-properties-common

# Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
  sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg

# Stable repository
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Engine
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# Run docker without sudo
sudo groupadd docker 2>/dev/null; sudo usermod -aG docker $USER
```

Log out and back in (or restart WSL) so the group change takes effect, then:

```bash
docker run --rm hello-world
```

## Enabling the config

If `mcp.json` does not exist yet, create it from the example:

```bash
cp /home/pipas/Linux/.kiro/settings/mcp.json.example \
   /home/pipas/Linux/.kiro/settings/mcp.json
```

Then edit `mcp.json`:

- Remove the JSON comments (lines starting with `//`), since strict JSON does
  not allow them. The `engram` block is commented out in the example; uncomment
  and adapt it if you want it.
- Replace the placeholders `$YOUR_USER` and `$YOUR_FOLDER` (see
  [office-mcp](#office-mcp)).
- Flip `"disabled": true` to `false` for the servers you want active.

## Per-server setup

### context7

Up-to-date library/documentation lookups.

- Runtime: `npx` (Node) — install [Node.js](#1-nodejs-npx).
- No credentials required.
- Status in example: enabled.

Smoke test:

```bash
npx -y @upstash/context7-mcp --help
```

### docker

Manage Docker resources (containers, images, compose, etc.) through MCP.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- Requires a working Docker daemon — install [Docker](#3-docker).
- Status in example: **disabled**, with a large `disabledTools` list that
  limits the exposed surface. Enable by setting `"disabled": false`, and remove
  tools from `disabledTools` only as you need them.

Smoke test:

```bash
docker info          # daemon reachable
uvx docker-mcp-server --help
```

### engram

Persistent project memory. Commented out in the example.

- Runtime: a local `engram` binary at `/home/pipas/.local/bin/engram`.
- Install engram (adjust to the tool's own instructions), then confirm the
  binary path matches your config:

```bash
command -v engram || ls -l ~/.local/bin/engram
```

- In the config, replace `YOUR_PROJECT` in
  `"args": ["mcp", "--tools=agent", "--project", "YOUR_PROJECT"]` with your
  project identifier.
- Uncomment the whole `engram` block and ensure surrounding JSON stays valid
  (commas between entries, no `//` comments).

### fetch

Retrieve and convert web content for the model.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- No credentials required.
- Status in example: enabled.

Smoke test:

```bash
uvx mcp-server-fetch --help
```

### github-personal

GitHub operations (issues, PRs, repos) via the official GitHub MCP server image.

- Runtime: `docker` — install [Docker](#3-docker). The image
  `ghcr.io/github/github-mcp-server` is pulled automatically on first run.
- Requires a GitHub Personal Access Token. **Important:** Kiro does NOT reliably
  substitute `${VAR}` in `mcp.json`, and the Kiro app is not launched from an
  interactive shell, so it does not read `~/.zshrc` — an exported env var never
  reaches the server process. See
  [Secrets](#secrets-and-environment-variables) for the working approach.
- Status in example: **disabled**, with a `disabledTools` list. Enable by
  setting `"disabled": false`.

Create a token at <https://github.com/settings/tokens> (fine-grained or
classic). Grant only the scopes you need (e.g. `repo`, `read:org`).

Put the token **literally** in your global `~/.kiro/settings/mcp.json` (which is
outside the repo and not published), not as `${GITHUB_PERSONAL_ACCESS_TOKEN}`:

```json
"github-personal": {
    "command": "docker",
    "args": ["run", "-i", "--rm", "-e", "GITHUB_PERSONAL_ACCESS_TOKEN=ghp_xxx", "ghcr.io/github/github-mcp-server", "stdio"],
    "env": { "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_xxx" },
    "disabled": false
}
```

Keep the repo's `.kiro/settings/mcp.json` out of version control (gitignored)
and only commit `mcp.json.example` with the placeholder.

Pre-pull the image to confirm access:

```bash
docker pull ghcr.io/github/github-mcp-server
```

### linkedin

LinkedIn MCP server.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- The example sets `UV_HTTP_TIMEOUT=300` to tolerate slow first-run downloads.
- Check the upstream package for any required credentials and add them under
  `env` (do not hardcode secrets).
- Status in example: enabled (no `disabled` key).

Smoke test:

```bash
UV_HTTP_TIMEOUT=300 uvx mcp-server-linkedin@latest --help
```

### document-loader

AWS Labs document loader MCP server.

- Runtime: `uvx` — install [uv/uvx](#2-uv--uvx-python-tool-runner).
- No credentials required; `FASTMCP_LOG_LEVEL=ERROR` just reduces log noise.
- Status in example: enabled.

Smoke test:

```bash
uvx awslabs.document-loader-mcp-server@latest --help
```

### office-mcp

Local Office documents MCP server, run from a Python virtualenv you create.

- Runtime: a project-local Python venv. The example points at:
    - interpreter: `/home/$YOUR_USER/tools/office-mcp/.venv/bin/python`
    - server: `/home/$YOUR_USER/tools/office-mcp/server.py`
- Replace `$YOUR_USER` with your username (here `pipas`) and `$YOUR_FOLDER`
  (the `OFFICE_MCP_DEFAULT_FOLDER`) with the directory the server should read
  documents from.

Set up the venv (Ubuntu needs `python3-venv`):

```bash
sudo apt update && sudo apt install -y python3-venv
mkdir -p ~/tools/office-mcp
# Place the office-mcp project (including server.py) in ~/tools/office-mcp
python3 -m venv ~/tools/office-mcp/.venv
~/tools/office-mcp/.venv/bin/pip install --upgrade pip
# Install the server's dependencies, e.g.:
~/tools/office-mcp/.venv/bin/pip install -r ~/tools/office-mcp/requirements.txt
```

Confirm the interpreter and server exist, then update the paths in `mcp.json`:

```bash
ls -l ~/tools/office-mcp/.venv/bin/python ~/tools/office-mcp/server.py
```

Example resolved config fragment:

```json
"office-mcp": {
    "command": "/home/pipas/tools/office-mcp/.venv/bin/python",
    "args": ["/home/pipas/tools/office-mcp/server.py"],
    "env": {
        "PYTHONUTF8": "1",
        "PYTHONIOENCODING": "utf-8",
        "OFFICE_MCP_DEFAULT_FOLDER": "/home/pipas/Documents"
    },
    "disabled": false
}
```

## Secrets and environment variables

**Kiro does NOT reliably expand `${VAR}` in `mcp.json`.** The Kiro app is not
launched from an interactive shell, so it does not source `~/.zshrc`; an
`export GITHUB_PERSONAL_ACCESS_TOKEN=...` there never reaches the server
process. For `github-personal` run via Docker with `-e GITHUB_PERSONAL_ACCESS_TOKEN`
(no value), Docker inherits from Kiro's empty environment and auth fails.
(Tracked upstream: kirodotdev/Kiro #5060, #5988, #9116.)

Working approach:

- Put the real token **literally** in the **global** config
  `~/.kiro/settings/mcp.json`. That file lives outside the repo and is not
  published, so the secret is not committed.
- Do **not** version the repo's real `.kiro/settings/mcp.json`. Add it to
  `.gitignore` and commit only `mcp.json.example` with a placeholder.
- After editing the token, reconnect the server from the MCP Server view (or
  restart Kiro) so the new value is picked up.

Tips:

- Keep secrets out of version control; `.env` and key files should be in
  `.gitignore`.

## Verifying and troubleshooting

- `command -v npx uvx docker` — confirm the runtimes are on PATH.
- Reconnect servers from the MCP Server view after editing `mcp.json`.
- `uvx`/`npx` download packages on first run; the first start can be slow.
- Strict JSON: remove `//` comments and trailing commas, or the file fails to
  parse. Validate with:

    ```bash
    python3 -m json.tool /home/pipas/Linux/.kiro/settings/mcp.json > /dev/null && echo OK
    ```

- `docker` MCP / `github-personal`: if you get permission errors, confirm your
  user is in the `docker` group and that you logged out and back in.
- `office-mcp`: a "no such file" error almost always means the `.venv/bin/python`
  or `server.py` paths in `mcp.json` are wrong.
