# coding-global-engram

Coding standards **plus the full global config and engram** (with WSL): the 9 coding
instructions on top of global-engram (global instructions incl. WSL, engram + engram-memory,
5 skills, study-helper agent, 4 MCP servers). The shared `../permissions.yaml` is a permissive
Kiro permission set you can copy alongside it.

Works on Linux (bash/zsh), macOS, WSL, and Windows (PowerShell) — install/env commands below
are given per OS.

Variant note: the biggest variant — coding + global + engram, **with** `wsl-environment`.
Outside WSL (native Linux, macOS, Windows) use `../coding-global-no-wsl-engram`. Without
engram, use `../coding-global`.

## What it installs

| Kind         | Items                                                                                                                                        |
| ------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| Coding       | api-design, architecture, code-quality, dependencies, documentation, error-handling, logging, naming-conventions, testing-coverage           |
| Global instr | code-language, commits, concise-output, document-loader-mcp, gitflow, ponytail, prefer-mcp, security, wsl-environment, engram, engram-memory |
| Skills       | commit-workflow, create-pr, generate-tests, review-diff, setup-graphify                                                                      |
| Agent        | study-helper                                                                                                                                 |
| MCP servers  | `github` (remote http), `document-loader` (stdio), `fetch` (stdio), `engram` (stdio)                                                         |

## The engram hook needs a manual copy

The engram **hook** (`engram-save-on-stop.json`) can't travel through a dependency ref — APM
single-file refs cover only instructions/agents/prompts. After `apm install`, copy it in and
re-install:

```sh
# Linux / macOS / WSL
mkdir -p .apm/hooks
cp engram-save-on-stop.json .apm/hooks/
apm install
```

```powershell
# Windows (PowerShell)
New-Item -ItemType Directory -Force .apm\hooks | Out-Null
Copy-Item engram-save-on-stop.json .apm\hooks\
apm install
```

(Or pull the whole package instead — see `../../full.apm.yml` — which includes the hook.)

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

See https://docs.astral.sh/uv/getting-started/installation/.

### 3. GitHub token (github)

The `github` server needs `GITHUB_PERSONAL_ACCESS_TOKEN` (see Environment variables).

### 4. Engram CLI (engram)

The `engram` MCP server runs the `engram` command; APM only writes the launch command, it
does not install the binary.

- Standalone executable (not a `uvx`/pip package), on PATH — typically `~/.local/bin/` on
  Linux/macOS/WSL, or a directory on `%PATH%` (e.g. `%USERPROFILE%\.local\bin`) on Windows.
- Install per the Engram project's own instructions: `<engram-install-source>`.
- Verify: `engram --version` (this setup was built against 3.x).

Also export `DEFAULT_ENGRAM_PROJECT` (see Environment variables).

### 5. document-loader extras (optional)

`extract_slides_as_images` additionally needs LibreOffice + poppler-utils:
`sudo apt install -y libreoffice poppler-utils` (Debian/Ubuntu/WSL),
`brew install --cask libreoffice && brew install poppler` (macOS), or
`winget install TheDocumentFoundation.LibreOffice` + `choco install poppler` (Windows).

### 6. Graphify CLI (setup-graphify skill, optional)

PyPI package `graphifyy` (double-y), command `graphify`, Python 3.10+:
`uv tool install graphifyy`. Verify: `graphify --version`.

## Environment variables

| Variable                       | Used by           | Purpose                                                                         |
| ------------------------------ | ----------------- | ------------------------------------------------------------------------------- |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github`          | Bearer token for the GitHub Copilot MCP endpoint                                |
| `DEFAULT_ENGRAM_PROJECT`       | `engram`          | project scope passed to `engram --project`                                      |
| `FASTMCP_LOG_LEVEL`            | `document-loader` | Log level for the document-loader server. Optional tuning; recommended `ERROR`. |

```sh
# Linux / macOS / WSL
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
export DEFAULT_ENGRAM_PROJECT=my-project
export FASTMCP_LOG_LEVEL=ERROR                # optional; DEBUG/INFO/WARNING/ERROR
```

```powershell
# Windows (PowerShell) — current session
$env:GITHUB_PERSONAL_ACCESS_TOKEN = "ghp_..."
$env:DEFAULT_ENGRAM_PROJECT = "my-project"
$env:FASTMCP_LOG_LEVEL = "ERROR"
# persist across sessions with setx, e.g. setx DEFAULT_ENGRAM_PROJECT "my-project"
```

## Install

```sh
# Linux / macOS / WSL
cp apm.yml /path/to/project/apm.yml      # optionally also copy ../permissions.yaml
cd /path/to/project
apm install
# then the engram hook manual-copy step above
```

```powershell
# Windows (PowerShell)
Copy-Item apm.yml C:\path\to\project\apm.yml
cd C:\path\to\project
apm install
# then the engram hook manual-copy step above
```

Globally (user scope, across projects; not the workspace `.kiro/`):

```sh
cp apm.yml ~/.apm/apm.yml
cd ~/.apm && apm install --global
```

Install only part of it: `apm install --only apm` (instructions + skills + agent) or
`apm install --only mcp` (the 4 MCP servers).

## Notes

- Bare `engram` command relies on PATH; ensure the binary's directory (`~/.local/bin/` on
  Linux/macOS/WSL, or the matching dir on Windows `%PATH%`) is on PATH in the harness launch
  environment.
- `disabledTools` on `github` and `engram` has no modeled APM field; it passes through and
  broadcasts to every target in `targets:` (parse-time warning). Kiro honors it.
- `../permissions.yaml` (shared by all variants) is permissive (`'*'`). Tighten where it
  matters.
