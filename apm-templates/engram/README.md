# engram

Engram persistent memory, standalone: the `engram` and `engram-memory` instructions and the
`engram` MCP server. No coding standards, global config, skills, or agent.

## What it installs

| Kind         | Items                       |
| ------------ | --------------------------- |
| Instructions | engram, engram-memory       |
| MCP servers  | `engram` (stdio)            |

## The engram hook needs a manual copy

The engram **hook** (`engram-save-on-stop.json`) can't travel through a dependency ref — APM
single-file refs cover only instructions/agents/prompts. After `apm install`, copy it in and
re-install:

```sh
mkdir -p .apm/hooks
cp /path/to/Linux/.apm/hooks/engram-save-on-stop.json .apm/hooks/
apm install
```

## Prerequisites

### 1. APM CLI

```sh
curl -sSL https://aka.ms/apm-unix | sh
```

Verify: `apm --version`.

### 2. Engram CLI

The `engram` MCP server runs the `engram` command; APM only writes the launch command, it
does not install the binary.

- Standalone executable (not a `uvx`/pip package), typically on PATH at `~/.local/bin/`.
- Install per the Engram project's own instructions: `<engram-install-source>`.
- Verify: `engram --version` (this setup was built against 3.x).

Also export `DEFAULT_ENGRAM_PROJECT` (see Environment variables).

## Environment variables

| Variable                 | Used by  | Purpose                                    |
| ------------------------ | -------- | ------------------------------------------ |
| `DEFAULT_ENGRAM_PROJECT` | `engram` | project scope passed to `engram --project` |

```sh
export DEFAULT_ENGRAM_PROJECT=my-project
```

## Install

```sh
cp apm.yml /path/to/project/apm.yml
cd /path/to/project
apm install
# then the engram hook manual-copy step above
```

## Notes

- Bare `engram` command relies on PATH; ensure the binary's directory (`~/.local/bin/`) is on
  PATH in the harness launch environment.
- `disabledTools` on `engram` has no modeled APM field; it passes through and broadcasts to
  every target in `targets:` (parse-time warning). Kiro honors it.
