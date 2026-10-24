# coding-global-no-wsl-engram

Coding standards **plus the global config and engram, without WSL**: the 9 coding
instructions on top of global-no-wsl-engram (global instructions minus WSL, engram +
engram-memory, 5 skills, study-helper agent, 4 MCP servers) — for native Linux/macOS. The
shared `../permissions.yaml` is a permissive Kiro permission set you can copy alongside it.

Variant note: coding + global + engram, **minus** `wsl-environment`. Under WSL use
`../coding-global-engram`. Without engram, use `../coding-global-no-wsl`.

## What it installs

| Kind         | Items                                                                                                                 |
| ------------ | --------------------------------------------------------------------------------------------------------------------- |
| Coding       | api-design, architecture, code-quality, dependencies, documentation, error-handling, logging, naming-conventions, testing-coverage |
| Global instr | code-language, commits, concise-output, document-loader-mcp, gitflow, ponytail, prefer-mcp, security, engram, engram-memory |
| Skills       | commit-workflow, create-pr, generate-tests, review-diff, setup-graphify                                               |
| Agent        | study-helper                                                                                                          |
| MCP servers  | `github` (remote http), `document-loader` (stdio), `fetch` (stdio), `engram` (stdio)                                  |

## The engram hook needs a manual copy

The engram **hook** (`engram-save-on-stop.json`) can't travel through a dependency ref — APM
single-file refs cover only instructions/agents/prompts. After `apm install`, copy it in and
re-install:

```sh
mkdir -p .apm/hooks
cp /path/to/Linux/.apm/hooks/engram-save-on-stop.json .apm/hooks/
apm install
```

(Or pull the whole package instead — see `../../full.apm.yml` — which includes the hook.)

## Prerequisites

### 1. APM CLI

```sh
curl -sSL https://aka.ms/apm-unix | sh
```

Verify: `apm --version`.

### 2. uv / uvx (document-loader, fetch)

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

See https://docs.astral.sh/uv/getting-started/installation/.

### 3. GitHub token (github)

The `github` server needs `GITHUB_PERSONAL_ACCESS_TOKEN` (see Environment variables).

### 4. Engram CLI (engram)

The `engram` MCP server runs the `engram` command; APM only writes the launch command, it
does not install the binary.

- Standalone executable (not a `uvx`/pip package), typically on PATH at `~/.local/bin/`.
- Install per the Engram project's own instructions: `<engram-install-source>`.
- Verify: `engram --version` (this setup was built against 3.x).

Also export `DEFAULT_ENGRAM_PROJECT` (see Environment variables).

### 5. document-loader extras (optional)

`extract_slides_as_images` additionally needs `sudo apt install -y libreoffice poppler-utils`.

### 6. Graphify CLI (setup-graphify skill, optional)

PyPI package `graphifyy` (double-y), command `graphify`, Python 3.10+:
`uv tool install graphifyy`. Verify: `graphify --version`.

## Environment variables

| Variable                       | Used by  | Purpose                                          |
| ------------------------------ | -------- | ------------------------------------------------ |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github` | Bearer token for the GitHub Copilot MCP endpoint |
| `DEFAULT_ENGRAM_PROJECT`       | `engram` | project scope passed to `engram --project`       |

```sh
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
export DEFAULT_ENGRAM_PROJECT=my-project
```

## Install

```sh
cp apm.yml /path/to/project/apm.yml      # optionally also copy ../permissions.yaml
cd /path/to/project
apm install
# then the engram hook manual-copy step above
```

Globally (user scope, across projects; not the workspace `.kiro/`):

```sh
mkdir -p /tmp/coding-install && cp apm.yml /tmp/coding-install/apm.yml
cd /tmp/coding-install && apm install --global
```

Install only part of it: `apm install --only apm` (instructions + skills + agent) or
`apm install --only mcp` (the 4 MCP servers).

## Notes

- Bare `engram` command relies on PATH; ensure `~/.local/bin/` is on PATH in the harness
  launch environment.
- `disabledTools` on `github` and `engram` has no modeled APM field; it passes through and
  broadcasts to every target in `targets:` (parse-time warning). Kiro honors it.
- `../permissions.yaml` (shared by all variants) is permissive (`'*'`). Tighten where it
  matters.
