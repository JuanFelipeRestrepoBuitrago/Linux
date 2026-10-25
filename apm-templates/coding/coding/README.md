# coding

Base coding-standards APM config from `JuanFelipeRestrepoBuitrago/Linux`: 9 coding
instructions only — no skills, agent, or MCP servers. The shared `../permissions.yaml` is a
permissive Kiro permission set you can copy alongside it.

Works on Linux (bash/zsh), macOS, WSL, and Windows (PowerShell) — install commands below are
given per OS.

For coding + the global config, use a `../coding-global*` variant. For engram, use
`../coding-engram`.

## What it installs

| Kind         | Items                                                                                                                              |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| Instructions | api-design, architecture, code-quality, dependencies, documentation, error-handling, logging, naming-conventions, testing-coverage |

## Prerequisites

### APM CLI

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

Verify: `apm --version`. No other prerequisites — this variant installs instructions only
(no MCP servers, so no `uvx`/tokens needed). The instructions are file-scoped (`applyTo`), so
they compile to Kiro `inclusion: fileMatch` and apply to matching source files.

## Install

This folder's `apm.yml` is ready to use directly.

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

Globally (user scope `~/.apm/` + user-level harness dirs, across projects; not the
workspace `.kiro/`):

```sh
# Linux / macOS / WSL
mkdir -p /tmp/coding-install && cp apm.yml /tmp/coding-install/apm.yml
cd /tmp/coding-install && apm install --global
```

```powershell
# Windows (PowerShell)
New-Item -ItemType Directory -Force "$env:TEMP\coding-install" | Out-Null
Copy-Item apm.yml "$env:TEMP\coding-install\apm.yml"
cd "$env:TEMP\coding-install"; apm install --global
```

## Notes

- `../permissions.yaml` (shared by all variants) is permissive (`'*'` on most capabilities).
  Tighten before using it where it matters.
