# engram

Engram persistent memory, standalone: the `engram` and `engram-memory` instructions and the
`engram` MCP server. No coding standards, global config, skills, or agent.

Works on Linux (bash/zsh), macOS, WSL, and Windows (PowerShell) — install/env commands below
are given per OS.

## What it installs

| Kind         | Items                 |
| ------------ | --------------------- |
| Instructions | engram, engram-memory |
| MCP servers  | `engram` (stdio)      |

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

### 2. Engram CLI

The `engram` MCP server runs the `engram` command; APM only writes the launch command, it
does not install the binary.

- Standalone executable (not a `uvx`/pip package), on PATH — typically `~/.local/bin/` on
  Linux/macOS/WSL, or a directory on `%PATH%` (e.g. `%USERPROFILE%\.local\bin`) on Windows.
- Install per the Engram project's own instructions: `<engram-install-source>`.
- Verify: `engram --version` (this setup was built against 3.x).

Also export `DEFAULT_ENGRAM_PROJECT` (see Environment variables).

## Environment variables

| Variable                 | Used by  | Purpose                                    |
| ------------------------ | -------- | ------------------------------------------ |
| `DEFAULT_ENGRAM_PROJECT` | `engram` | project scope passed to `engram --project` |

```sh
# Linux / macOS / WSL
export DEFAULT_ENGRAM_PROJECT=my-project
```

```powershell
# Windows (PowerShell) — current session (persist with: setx DEFAULT_ENGRAM_PROJECT "my-project")
$env:DEFAULT_ENGRAM_PROJECT = "my-project"
```

## Install

```sh
# Linux / macOS / WSL
cp apm.yml /path/to/project/apm.yml
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

## Notes

- Bare `engram` command relies on PATH; ensure the binary's directory (`~/.local/bin/` on
  Linux/macOS/WSL, or the matching dir on Windows `%PATH%`) is on PATH in the harness launch
  environment.
- `disabledTools` on `engram` has no modeled APM field; it passes through and broadcasts to
  every target in `targets:` (parse-time warning). Kiro honors it.
