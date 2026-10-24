# Global config template

`global.apm.yml` pulls a curated global setup from
`JuanFelipeRestrepoBuitrago/Linux`: 9 core instructions, 5 workflow skills, and 3 MCP
servers (`github`, `document-loader`, `fetch`). `permissions.yaml` in this folder is a
permissive Kiro permission set you can copy alongside it.

This guide lists every prerequisite so the install works end to end.

## What it installs

| Kind         | Items                                                                                                                 |
| ------------ | --------------------------------------------------------------------------------------------------------------------- |
| Instructions | code-language, commits, concise-output, document-loader-mcp, gitflow, ponytail, prefer-mcp, security, wsl-environment |
| Skills       | commit-workflow, create-pr, generate-tests, review-diff, setup-graphify                                               |
| MCP servers  | `github` (remote http), `document-loader` (stdio), `fetch` (stdio)                                                    |

## Prerequisites

### 1. APM CLI

Needed to run the install itself.

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
needs a bearer token (see Environment variables).

### 4. document-loader extras (optional)

`read_document` and `read_image` work with just `uvx`. The `extract_slides_as_images`
capability additionally needs:

- **LibreOffice** — for PPTX/PPT rendering: `sudo apt install -y libreoffice`
- **poppler-utils** — for PDF rendering: `sudo apt install -y poppler-utils`

Skip this if you don't extract slides/pages as images.

### 5. Graphify CLI (setup-graphify skill)

The `setup-graphify` skill configures the [Graphify](https://github.com/Graphify-Labs/graphify)
knowledge-graph tool, but it does **not** bundle the CLI — the skill only runs once the
`graphify` CLI is on PATH. Install it before using the skill.

Requires Python 3.10+ (`python3 --version`). The PyPI package is `graphifyy` (double-y);
the command it installs is `graphify`. Pick one, in order of preference:

```sh
uv tool install graphifyy      # preferred: isolated env (uv installed in step 2)
pipx install graphifyy         # alternative
pip install graphifyy          # last resort, may need PATH setup
```

Verify: `graphify --version`. Once installed, invoke the skill in a workspace and it handles
the rest (`graphify install --platform kiro --project`, then `graphify extract` / `cluster-only`
to build the graph). Skip this if you won't use the Graphify skill.

## Environment variables

APM keeps secrets as `${VAR}` and resolves them at server start, so nothing sensitive is
written to the generated config.

| Variable                       | Used by  | Purpose                                          |
| ------------------------------ | -------- | ------------------------------------------------ |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | `github` | Bearer token for the GitHub Copilot MCP endpoint |

```sh
export GITHUB_PERSONAL_ACCESS_TOKEN=ghp_...   # or pull from a secret manager
```

## Install

Global (user scope `~/.apm/`, applies across projects):

```sh
apm install --global
```

Or per project — drop `global.apm.yml` in as `apm.yml` (and optionally copy
`permissions.yaml` into the harness config), then:

```sh
apm install
```

Install only part of it:

```sh
apm install --only apm   # instructions + skills, no MCP servers
apm install --only mcp   # only the 3 MCP servers
```

## Notes

- `disabledTools` on `github` has no modeled APM field; it passes through as an extra key
  and broadcasts to every target in `targets:` (parse-time warning). Kiro honors it; other
  harnesses may ignore it.
- `code-language` and `document-loader-mcp` are file-scoped (`applyTo`), so they compile to
  Kiro `inclusion: fileMatch`; the rest are always-on.
- `permissions.yaml` is permissive (`'*'` on most capabilities). Tighten it before using it
  somewhere that matters.
