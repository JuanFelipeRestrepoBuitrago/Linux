# global

Curated global APM config from `JuanFelipeRestrepoBuitrago/Linux`: 9 core instructions
(including `wsl-environment`), 5 workflow skills, 1 agent, and 3 MCP servers.
The shared `../permissions.yaml` is a permissive Kiro permission set you can copy alongside it.

Variant note: this is the full set **with** the `wsl-environment` instruction. On native
Linux/macOS use `../global-no-wsl` instead. For engram, use `../global-engram`.

## What it installs

| Kind         | Items                                                                                                                 |
| ------------ | --------------------------------------------------------------------------------------------------------------------- |
| Instructions | code-language, commits, concise-output, document-loader-mcp, gitflow, ponytail, prefer-mcp, security, wsl-environment |
| Skills       | commit-workflow, create-pr, generate-tests, review-diff, setup-graphify                                               |
| Agent        | study-helper                                                                                                          |
| MCP servers  | `github` (remote http), `document-loader` (stdio), `fetch` (stdio)                                                    |

## Prerequisites

### 1. APM CLI

```sh
curl -sSL https://aka.ms/apm-unix | sh
```

Verify: `apm --version`.

### 2. uv / uvx (document-loader, fetch)

Both stdio servers launch via `uvx`, which ships with `uv`.

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

See https://docs.astral.sh/uv/getting-started/installation/. The server packages
(`awslabs.document-loader-mcp-server`, `mcp-server-fetch`) are fetched by `uvx` on first
run — no separate install.

### 3. GitHub token (github)

The `github` server is the remote GitHub Copilot MCP endpoint; nothing to install, but it
needs `GITHUB_PERSONAL_ACCESS_TOKEN` (see Environment variables).

### 4. document-loader extras (optional)

`read_document` and `read_image` work with just `uvx`. The `extract_slides_as_images`
capability additionally needs:

- **LibreOffice** — for PPTX/PPT rendering: `sudo apt install -y libreoffice`
- **poppler-utils** — for PDF rendering: `sudo apt install -y poppler-utils`

Skip this if you don't extract slides/pages as images.

### 5. Graphify CLI (setup-graphify skill, optional)

The `setup-graphify` skill configures [Graphify](https://github.com/Graphify-Labs/graphify)
but does **not** bundle the CLI. Requires Python 3.10+. PyPI package `graphifyy` (double-y),
command `graphify`:

```sh
uv tool install graphifyy      # preferred
pipx install graphifyy         # alternative
pip install graphifyy          # last resort
```

Verify: `graphify --version`. Skip if you won't use the Graphify skill.

## Environment variables

| Variable                       | Used by  | Purpose                                          |
| ------------------------------ | -------- | ------------------------------------------------ |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github` | Bearer token for the GitHub Copilot MCP endpoint |

```sh
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
```

## Install

This folder's `apm.yml` is ready to use directly.

### Per project

```sh
cp apm.yml /path/to/project/apm.yml      # optionally also copy ../permissions.yaml
cd /path/to/project
apm install
```

### Globally (user scope)

`--global` installs into APM user scope `~/.apm/` and each runtime's **user-level** harness
dir (e.g. `~/.kiro/steering/`), applying across projects. It does **not** touch any
workspace `.kiro/`.

```sh
cp apm.yml ~/.apm/apm.yml
cd ~/.apm && apm install --global
```

### Install only part of it

```sh
apm install --only apm   # instructions + skills + agent, no MCP servers
apm install --only mcp   # only the 3 MCP servers
```

## Notes

- `disabledTools` on `github` has no modeled APM field; it passes through and broadcasts to
  every target in `targets:` (parse-time warning). Kiro honors it; others may ignore it.
- `code-language` and `document-loader-mcp` are file-scoped (`applyTo` → `inclusion:
fileMatch`); the rest are always-on.
- `../permissions.yaml` (shared by all variants) is permissive (`'*'` on most capabilities).
  Tighten before using it where it matters.
