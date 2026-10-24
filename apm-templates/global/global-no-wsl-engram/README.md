# global-no-wsl-engram

Curated global APM config from `JuanFelipeRestrepoBuitrago/Linux` **without WSL, with
engram**: the `global-no-wsl` set plus the `engram` and `engram-memory` instructions and the
`engram` MCP server — for native Linux/macOS. 10 instructions, 5 skills, 1 agent, 4 MCP
servers. The shared `../permissions.yaml` is a permissive Kiro permission set you can copy
alongside it.

Variant note: full set + engram, minus WSL. Under WSL use `../global-engram`. Without
engram, use `../global-no-wsl`.

## What it installs

| Kind         | Items                                                                                                                       |
| ------------ | --------------------------------------------------------------------------------------------------------------------------- |
| Instructions | code-language, commits, concise-output, document-loader-mcp, gitflow, ponytail, prefer-mcp, security, engram, engram-memory |
| Skills       | commit-workflow, create-pr, generate-tests, review-diff, setup-graphify                                                     |
| Agent        | study-helper                                                                                                                |
| MCP servers  | `github` (remote http), `document-loader` (stdio), `fetch` (stdio), `engram` (stdio)                                        |

## The engram hook needs a manual copy

The engram **hook** (`engram-save-on-stop.json`) can't travel through a dependency ref —
APM single-file refs cover only instructions/agents/prompts. After `apm install`, copy it in
and re-install:

```sh
mkdir -p .apm/hooks
cp engram-save-on-stop.json .apm/hooks/
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

Both stdio servers launch via `uvx`, which ships with `uv`.

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh
```

See https://docs.astral.sh/uv/getting-started/installation/.

### 3. GitHub token (github)

The `github` server is the remote GitHub Copilot MCP endpoint; needs
`GITHUB_PERSONAL_ACCESS_TOKEN` (see Environment variables).

### 4. Engram CLI (engram)

The `engram` MCP server runs the `engram` command; APM only writes the launch command, it
does not install the binary. Install the Engram CLI first.

- Standalone executable (not a `uvx`/pip package), typically on PATH at `~/.local/bin/`.
- Install per the Engram project's own instructions: `<engram-install-source>`.
- Verify: `engram --version` (this setup was built against 3.x).

Also export `DEFAULT_ENGRAM_PROJECT` (see Environment variables).

### 5. document-loader extras (optional)

`extract_slides_as_images` additionally needs:

- **LibreOffice**: `sudo apt install -y libreoffice`
- **poppler-utils**: `sudo apt install -y poppler-utils`

### 6. Graphify CLI (setup-graphify skill, optional)

PyPI package `graphifyy` (double-y), command `graphify`, Python 3.10+:

```sh
uv tool install graphifyy      # preferred
```

Verify: `graphify --version`.

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

This folder's `apm.yml` is ready to use directly.

### Per project

```sh
cp apm.yml /path/to/project/apm.yml      # optionally also copy ../permissions.yaml
cd /path/to/project
apm install
# then the engram hook manual-copy step above
```

### Globally (user scope)

`--global` installs into APM user scope `~/.apm/` and each runtime's **user-level** harness
dir, applying across projects. It does **not** touch any workspace `.kiro/`.

```sh
cp apm.yml ~/.apm/apm.yml
cd ~/.apm && apm install --global
```

### Install only part of it

```sh
apm install --only apm   # instructions + skills + agent, no MCP servers
apm install --only mcp   # only the 4 MCP servers
```

## Notes

- `disabledTools` on `github` and `engram` has no modeled APM field; it passes through and
  broadcasts to every target in `targets:` (parse-time warning). Kiro honors it.
- Bare `engram` command relies on PATH; ensure the binary's directory (`~/.local/bin/`) is
  on PATH in the harness launch environment.
- `../permissions.yaml` (shared by all variants) is permissive (`'*'` on most capabilities).
  Tighten before using it where it matters.
