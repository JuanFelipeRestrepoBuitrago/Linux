---
name: setup-graphify
description: Sets up the Graphify knowledge-graph tool in the current Kiro workspace. Checks whether the graphify CLI is installed; if not, detects the machine's package manager and gives the exact install command; if installed, installs the Kiro skill/steering into this repo, builds the graph locally, and gitignores the output. Before installing it fetches the upstream README to catch command changes. Use when the user asks to install, set up, configure, or add Graphify to a project.
---

# Set up Graphify

Configure the [Graphify](https://github.com/Graphify-Labs/graphify) knowledge-graph tool for the current Kiro workspace. Graphify parses code locally with tree-sitter and builds a queryable graph so the assistant queries it instead of grepping.

## When to use

The user asks to install, set up, configure, or add Graphify to the current project/workspace.

## Reference

- Upstream repo: https://github.com/Graphify-Labs/graphify
- PyPI package: `graphifyy` (double-y). CLI command: `graphify`.

## Steps

### 1. Re-check the upstream README for drift

Before running anything, fetch the README and confirm the Kiro install command and build flow still match this skill. Commands have changed between versions before.

- Fetch https://raw.githubusercontent.com/Graphify-Labs/graphify/v8/README.md (fall back to the repo page if the raw URL 404s — the default branch may have moved past `v8`).
- Look for the Kiro install command, the `extract` / `cluster-only` build flow, and the uninstall command.
- If the README disagrees with the commands below, trust the README and tell the user what changed. Known drift: the README has listed a `graphify kiro install` subcommand that does NOT exist in the shipped CLI — the working form is `graphify install --platform kiro --project`. Verify against `graphify --help` before trusting either.

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

### 5. Install the Kiro skill + steering (project-scoped)

From the workspace root:

```bash
graphify install --platform kiro --project
```

This writes `.kiro/skills/graphify/` (skill + `references/`) and `.kiro/steering/graphify.md` (always-on query-first steering). The steering tells the assistant to query the graph before grepping, but only once a graph exists.

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
- Tell the user what was written, how to rebuild (`/graphify .`), and how to remove it (`graphify uninstall --purge`, then remove the `graphify-out/` line from `.gitignore` by hand — the uninstaller does not touch `.gitignore`).

## Notes

- This skill installs the local CLI/skill integration only. It does NOT set up a Graphify MCP server (separate, needs the `graphifyy[mcp]` extra) or the paid Graphify Cloud service.
- Payoff is modest on small config/doc repos and grows with codebase size.
