---
name: setup-graphify
description: Sets up the Graphify knowledge-graph tool in the current workspace for whichever AI agent is running (Kiro, Claude, Codex, Cursor, Gemini, Copilot, and others Graphify supports). Checks whether the graphify CLI is installed; if not, detects the machine's package manager and gives the exact install command; if installed, detects the host agent, installs the agent's skill/steering into this repo via the matching --platform, builds the graph locally, and gitignores the output. Before installing it fetches the upstream README to catch command changes. Use when the user asks to install, set up, configure, or add Graphify to a project.
---

# Set up Graphify

Configure the [Graphify](https://github.com/Graphify-Labs/graphify) knowledge-graph tool for the current workspace, targeting whichever AI agent is running. Graphify parses code locally with tree-sitter and builds a queryable graph so the assistant queries it instead of grepping.

## When to use

The user asks to install, set up, configure, or add Graphify to the current project/workspace.

## Reference

- Upstream repo: https://github.com/Graphify-Labs/graphify
- PyPI package: `graphifyy` (double-y). CLI command: `graphify`.

## Steps

### 1. Re-check the upstream README for drift

Before running anything, fetch the README and confirm the install command and build flow still match this skill. Commands have changed between versions before.

- Fetch https://raw.githubusercontent.com/Graphify-Labs/graphify/v8/README.md (fall back to the repo page if the raw URL 404s — the default branch may have moved past `v8`).
- Look for the `install --platform` command, the list of supported platforms, the `extract` / `cluster-only` build flow, and the uninstall command.
- If the README disagrees with the commands below, trust the README and tell the user what changed. Always verify the exact platform list and install form against `graphify install --help` before trusting either.

### 2. Check whether the CLI is installed

Run `graphify --version`.

- **If it prints a version** → the CLI is installed. Skip to step 4.
- **If it fails** (command not found) → the CLI is missing. Go to step 3.

### 3. CLI missing — explain how to install for THIS machine

Do NOT silently install. Detect the environment and give the user the exact command, then let them run it (or confirm before you run it).

Detect prerequisites and package manager:

- Python 3.10+ required: `python3 --version`.
- Prefer `uv` if present (`uv --version`), else `pipx` (`pipx --version`), else `pip`.

Recommend, in order of preference:

```bash
uv tool install graphifyy      # preferred: isolated env
pipx install graphifyy         # alternative
pip install graphifyy          # last resort, may need PATH setup
```

Platform hints (detect OS with `uname -s`):

- **Linux (Debian/Ubuntu)**: `sudo apt install python3 pipx` or install uv via `curl -LsSf https://astral.sh/uv/install.sh | sh`.
- **macOS**: `brew install python uv`.
- **Windows**: `winget install astral-sh.uv`.

If `uv`/`pipx`/`python3` are all missing, point the user at the prerequisite installer first. After the user installs the CLI, re-run step 2.

### 4. Confirm there is a workspace to target

Set up writes into the current repo. Confirm the working directory is the intended project root (it should contain the code to map). If unsure, ask the user to confirm the path before writing files.

### 5. Install the agent skill + steering (project-scoped)

First determine which AI agent is running (the one executing this skill) and map it to a Graphify `--platform` value. Graphify supports, among others: `kiro`, `claude`, `codex`, `cursor`, `gemini`, `copilot`, `opencode`, `windsurf`, `agents`. Confirm the current list with `graphify install --help`; if the host agent is ambiguous or unsupported, ask the user which platform to target (`agents` is a generic fallback that deploys to `.agents/`).

From the workspace root, install for the detected platform:

```bash
graphify install --platform <agent> --project   # e.g. --platform kiro | claude | codex | cursor | gemini
```

This writes the skill (+ `references/`) and an always-on query-first steering/rule into that agent's project config dir (for Kiro: `.kiro/skills/graphify/` and `.kiro/steering/graphify.md`; other agents use their own layout). The steering tells the assistant to query the graph before grepping, but only once a graph exists.

- `--strict` (block the first raw file read until a `graphify query` runs) is a Claude Code project-hook feature and needs `--project`; only offer it when targeting `claude`.

### 6. Build the graph

Build locally. Default to offline, zero-cost:

```bash
graphify extract . --code-only      # local tree-sitter, no LLM, nothing leaves the machine
graphify cluster-only . --no-label  # GRAPH_REPORT.md + graph.html, no LLM community naming
```

Decide the flags with the user for larger projects:

- Drop `--code-only` to also index docs/PDFs/images — this needs an LLM backend (API key or local Ollama). Pure code stays free either way.
- Drop `--no-label` to get readable LLM-named communities — costs LLM calls; worth it on big codebases, skip on small ones.
- `graphify hook install` (from the repo) auto-rebuilds the graph on commit/checkout — useful on an active large project.

### 7. Keep generated output out of git

`graphify-out/` is regenerated from source and should not be committed:

```bash
# append to .gitignore if not already present
graphify-out/
```

### 8. Verify and report

- Confirm `graphify-out/graph.json` exists and run one `graphify query "<something about the repo>"` to prove it works.
- Tell the user what was written (naming the targeted platform), how to rebuild (re-run the `graphify extract` / `cluster-only` commands from step 6, or the agent's graphify command if it installed one), and how to remove it (`graphify uninstall --purge`, which auto-detects all installed platforms, then remove the `graphify-out/` line from `.gitignore` by hand — the uninstaller does not touch `.gitignore`).

## Notes

- This skill installs the local CLI/skill integration only. It does NOT set up a Graphify MCP server (separate, needs the `graphifyy[mcp]` extra) or the paid Graphify Cloud service.
- Payoff is modest on small config/doc repos and grows with codebase size.
