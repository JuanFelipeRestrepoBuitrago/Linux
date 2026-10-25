# coding-global-no-wsl

Coding standards **plus the global config without WSL**: the 9 coding instructions on top of
global-no-wsl's 8 instructions, 5 skills, the study-helper agent, and 3 MCP servers — for
native Linux, macOS, or Windows. The shared `../permissions.yaml` is a permissive Kiro
permission set you can copy alongside it.

Works on Linux (bash/zsh), macOS, and Windows (PowerShell) — install/env commands below are
given per OS.

Variant note: full coding + global, **minus** `wsl-environment`. Under WSL use
`../coding-global`. For engram, use `../coding-global-no-wsl-engram`.

## What it installs

| Kind         | Items                                                                                                                              |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| Coding       | api-design, architecture, code-quality, dependencies, documentation, error-handling, logging, naming-conventions, testing-coverage |
| Global instr | code-language, commits, concise-output, document-loader-mcp, gitflow, ponytail, prefer-mcp, security                               |
| Skills       | commit-workflow, create-pr, generate-tests, review-diff, setup-graphify                                                            |
| Agent        | study-helper                                                                                                                       |
| MCP servers  | `github` (remote http), `document-loader` (stdio), `fetch` (stdio)                                                                 |

## Prerequisites

### 1. APM CLI

```sh
# macOS (Homebrew)
brew install apm
# Linux / macOS / WSL (no Homebrew)
curl -sSL https://aka.ms/apm-unix | sh
```

```powershell
# Windows (PowerShell)
irm https://aka.ms/apm-windows | iex
```

Verify: `apm --version`.

### 2. uv / uvx (document-loader, fetch)

```sh
# Linux / macOS / WSL
curl -LsSf https://astral.sh/uv/install.sh | sh
```

```powershell
# Windows (PowerShell)
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
```

See https://docs.astral.sh/uv/getting-started/installation/. Server packages are fetched by
`uvx` on first run.

### 3. GitHub token (github)

The `github` server needs `GITHUB_PERSONAL_ACCESS_TOKEN` (see Environment variables).

### 4. document-loader extras (optional)

`extract_slides_as_images` additionally needs LibreOffice + poppler-utils:
`sudo apt install -y libreoffice poppler-utils` (Debian/Ubuntu/WSL),
`brew install --cask libreoffice && brew install poppler` (macOS), or
`winget install TheDocumentFoundation.LibreOffice` + `choco install poppler` (Windows).

### 5. Graphify CLI (setup-graphify skill, optional)

PyPI package `graphifyy` (double-y), command `graphify`, Python 3.10+:
`uv tool install graphifyy`. Verify: `graphify --version`.

## Environment variables

| Variable                       | Used by           | Purpose                                                                         |
| ------------------------------ | ----------------- | ------------------------------------------------------------------------------- |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github`          | Bearer token for the GitHub Copilot MCP endpoint                                |
| `FASTMCP_LOG_LEVEL`            | `document-loader` | Log level for the document-loader server. Optional tuning; recommended `ERROR`. |

```sh
# Linux / macOS / WSL
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
export FASTMCP_LOG_LEVEL=ERROR                # optional; DEBUG/INFO/WARNING/ERROR
```

```powershell
# Windows (PowerShell) — current session
$env:GITHUB_PERSONAL_ACCESS_TOKEN = "ghp_..."
$env:FASTMCP_LOG_LEVEL = "ERROR"
# persist across sessions: setx GITHUB_PERSONAL_ACCESS_TOKEN "ghp_..."
```

## Install

```sh
# Linux / macOS / WSL
cp apm.yml /path/to/project/apm.yml      # optionally also copy ../permissions.yaml
cd /path/to/project
apm install
```

```powershell
# Windows (PowerShell)
Copy-Item apm.yml C:\path\to\project\apm.yml
cd C:\path\to\project
apm install
```

Globally (user scope, across projects; not the workspace `.kiro/`):

```sh
cp apm.yml ~/.apm/apm.yml
cd ~/.apm && apm install --global
```

Install only part of it: `apm install --only apm` (instructions + skills + agent) or
`apm install --only mcp` (the 3 MCP servers).

## Notes

- `disabledTools` on `github` has no modeled APM field; it passes through and broadcasts to
  every target in `targets:` (parse-time warning). Kiro honors it.
- Instructions are a mix of always-on and file-scoped (`applyTo` → `inclusion: fileMatch`).
- `../permissions.yaml` (shared by all variants) is permissive (`'*'`). Tighten where it
  matters.
