# coding-global

Coding standards **plus the full global config** (with WSL): the 9 coding instructions on top
of global's 9 instructions, 5 skills, the study-helper agent, and 3 MCP servers. The shared
`../permissions.yaml` is a permissive Kiro permission set you can copy alongside it.

Variant note: full coding + global, **with** `wsl-environment`. On native Linux/macOS use
`../coding-global-no-wsl`. For engram, use `../coding-global-engram`.

## What it installs

| Kind         | Items                                                                                                                              |
| ------------ | ---------------------------------------------------------------------------------------------------------------------------------- |
| Coding       | api-design, architecture, code-quality, dependencies, documentation, error-handling, logging, naming-conventions, testing-coverage |
| Global instr | code-language, commits, concise-output, document-loader-mcp, gitflow, ponytail, prefer-mcp, security, wsl-environment              |
| Skills       | commit-workflow, create-pr, generate-tests, review-diff, setup-graphify                                                            |
| Agent        | study-helper                                                                                                                       |
| MCP servers  | `github` (remote http), `document-loader` (stdio), `fetch` (stdio)                                                                 |

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

See https://docs.astral.sh/uv/getting-started/installation/. Server packages are fetched by
`uvx` on first run.

### 3. GitHub token (github)

The `github` server needs `GITHUB_PERSONAL_ACCESS_TOKEN` (see Environment variables).

### 4. document-loader extras (optional)

`extract_slides_as_images` additionally needs `sudo apt install -y libreoffice poppler-utils`.

### 5. Graphify CLI (setup-graphify skill, optional)

PyPI package `graphifyy` (double-y), command `graphify`, Python 3.10+:
`uv tool install graphifyy`. Verify: `graphify --version`.

## Environment variables

| Variable                       | Used by  | Purpose                                          |
| ------------------------------ | -------- | ------------------------------------------------ |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github` | Bearer token for the GitHub Copilot MCP endpoint |

```sh
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
```

## Install

```sh
cp apm.yml /path/to/project/apm.yml      # optionally also copy ../permissions.yaml
cd /path/to/project
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
