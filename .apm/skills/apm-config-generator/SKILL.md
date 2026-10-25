---
name: apm-config-generator
description: Reverse-engineers an existing repository's native AI assistant configuration (Kiro, Claude, Codex, Cursor, Copilot, Gemini, Windsurf, or any apm-supported target) into APM source format, and keeps an existing .apm/ + apm.yml in sync as the native config evolves — converting or reconciling custom steering, rules, skills, hooks, agents, and MCP servers into .apm/ primitives plus apm.yml dependencies, then validating the result round-trips back with apm compile. Use when the user asks to turn a repo's AI config into an apm package/template, migrate .kiro (or .claude/.codex/etc.) to .apm, generate apm.yml from existing tool configuration, or update/sync an existing .apm package after the native config changed.
---

# APM config generator

Convert a repository's _native_ AI-assistant configuration into APM's source format, or keep an existing APM package in sync with it. APM already compiles `.apm/` + `apm.yml` → native tool configs (`apm compile`), and discovers existing packages (`apm init --discover`). The gap this skill fills is the **reverse direction**: native tool config → `.apm/` primitives, which no apm command does — both the first-time conversion and ongoing reconciliation when the native config drifts ahead of `.apm/`.

## When to use

The user asks to turn a repo's AI configuration into an apm package/template, migrate `.kiro` (or `.claude` / `.codex` / `.cursor` / etc.) into `.apm`, generate `apm.yml` from existing tool configuration, or **update/sync an existing `.apm` package** after the native config changed (new or edited steering, skills, hooks, agents, or MCP servers).

## Mode: create vs update

First decide which mode applies, then follow the steps:

- **Create** — no `.apm/` or `apm.yml` exists yet (or they're empty). Build the package from scratch: run every step.
- **Update/sync** — `.apm/` and/or `apm.yml` already exist. Reconcile them with the current native config instead of overwriting: run steps 1–3, then step 3b (reconcile), then 4–7 applying only the diff.

Detect the mode in step 1 by checking whether `.apm/` and `apm.yml` already hold primitives.

## Reference: APM primitive mapping

`.apm/` holds source primitives; `apm compile` deploys them per target. Map native artifacts to primitives:

| Native artifact                                                                                                                           | APM source                              |
| ----------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------- |
| Steering / rules / instructions (`.kiro/steering/*.md`, `.claude/rules/*`, `.github/instructions/*`, `AGENTS.md`/`CLAUDE.md` rule blocks) | `.apm/instructions/*.instructions.md`   |
| Skills (`.kiro/skills/*/SKILL.md`, `.claude/skills/*`, `.agents/skills/*`)                                                                | `.apm/skills/<name>/SKILL.md`           |
| Hooks (`.kiro/hooks/*.json`)                                                                                                              | `.apm/hooks/*.json`                     |
| Custom agents / subagents (`.kiro/agents`, `.claude/agents`)                                                                              | `.apm/agents/*.agent.md`                |
| MCP servers (`.kiro/settings/mcp.json`, `.mcp.json`, `.claude` mcp config)                                                                | `apm.yml` → `dependencies.mcp:`         |
| Local prompts / commands                                                                                                                  | matching `.apm/` primitive for the type |

Supported `apm compile` / `install` targets (the set a config can come from or go to): agent-skills, agents, antigravity, claude, codex, copilot, copilot-app, copilot-cowork, cursor, gemini, grok-\*, hermes, intellij, kiro, openclaw, opencode, vscode, windsurf.

## Decision: local primitive vs apm.yml dependency

For each artifact decide which bucket it lands in — this is the core judgment of the skill:

- **Local custom** (authored in this repo, no upstream source) → convert to a `.apm/` primitive.
- **Available from the web / a registry** (a public skill, steering pack, plugin collection, or MCP server) → declare it in `apm.yml` as a dependency (git ref or registry entry) instead of vendoring the file, so `apm update` can refresh it. MCP servers always go in `apm.yml`.

When unsure whether an artifact has an upstream source, ask the user or default to treating it as local (safer, no broken ref).

## Steps

### 1. Confirm scope, mode, and source target(s)

- Confirm the working directory is the repo to convert.
- **Determine the mode**: check whether `.apm/` and `apm.yml` already exist and hold primitives. Empty/absent → **create**; populated → **update/sync**. State the detected mode to the user.
- Detect which native configs exist: check for `.kiro/`, `.claude/`, `.codex/`, `.cursor/`, `.github/instructions/`, `.agents/`, `AGENTS.md`, `CLAUDE.md`, MCP config files.
- Ask the user which target(s) to treat as the source if several exist, and which to declare in `apm.yml` `targets:` for output. In update mode, default to the existing `apm.yml` `targets:` unless the user changes them.

### 2. Reuse apm discovery for anything already packaged

Run `apm init --discover` (add `-g` for user scope) to inventory existing _local APM packages_ without writing. Use `apm init --apply` to add those references to `apm.yml`. This handles artifacts already in APM format; the manual conversion below handles everything still in native format.

### 3. Inventory and classify native artifacts

List every steering file, skill, hook, agent, and MCP server found in step 1. For each, record: type, path, and the local-vs-dependency decision from the mapping above. Present this inventory to the user before writing anything.

### 3b. Reconcile (update/sync mode only)

Skip this in create mode. Diff the native inventory from step 3 against what `.apm/` and `apm.yml` already contain, and classify each artifact:

- **New** — present in native config, absent from `.apm/` / `apm.yml` → add it (steps 4–5).
- **Changed** — present in both but the native content differs from the compiled `.apm/` source → update the existing primitive / `apm.yml` entry in place, preserving its path and name.
- **Unchanged** — identical → leave as-is, do not rewrite.
- **Removed from native** — present in `.apm/` / `apm.yml` but gone from the native config → do NOT delete automatically. Flag it and ask the user whether it was intentionally removed (delete the primitive) or is an APM-only addition to keep.

Compare against the _source_ `.apm/` primitive, not the compiled output, so you don't flag normal compile transformations as changes. Present the New / Changed / Unchanged / Removed breakdown to the user and get approval before writing. Apply only the diff — never overwrite unchanged primitives.

### 4. Create / update apm.yml

- If absent, scaffold with `apm init` (or `apm init --target <list> -y`), then edit.
- Set `name`, `version`, `description`, and `targets:` (the list of tools to compile for).
- Add MCP servers under `dependencies.mcp:` — preserve transport, command, args, and `disabledTools` from the native MCP config. Never inline secrets; reference env vars.
- Add any web/registry-sourced steering, skills, or plugins under the appropriate `dependencies:` entries (git ref or registry).

### 5. Convert / update local artifacts into .apm primitives

In update mode, act only on the New and Changed artifacts from step 3b; leave Unchanged ones untouched. For each local artifact, write or update the `.apm/` equivalent per the mapping table:

- Steering/rules → `.apm/instructions/<name>.instructions.md` (preserve inclusion/scoping front-matter semantics).
- Skills → `.apm/skills/<name>/SKILL.md` (keep `name` + `description` front-matter; descriptions drive activation).
- Hooks → `.apm/hooks/*.json`.
- Agents → `.apm/agents/*.agent.md`.
- Keep all content in English; preserve the original intent and any `references/` subfolders.

### 6. Validate the round-trip

Confirm the generated APM source compiles back to the native format it came from:

```bash
apm compile --dry-run --target <source-target>   # preview placement, no writes
apm compile --validate                            # validate primitives without compiling
```

- `--dry-run` shows where each primitive would deploy; verify it matches the original layout.
- Resolve any validation error before declaring done. Optionally run a real `apm compile --target <list>` into a scratch dir (`--root <dir>`) to diff against the original config.

### 7. Report

- Summarize the result: in create mode, which artifacts became `.apm/` primitives, which became `apm.yml` dependencies, and which MCP servers were declared. In update mode, what was added, what was updated, what was left unchanged, and what was flagged as removed.
- Show the final `apm.yml` `targets:` and how to deploy (`apm install`) and re-compile (`apm compile --target <list>`).
- Flag anything you could not classify confidently so the user can decide.

## Rules

- Never vendor a file that has a maintained upstream source — declare it in `apm.yml` so `apm update` keeps it fresh. MCP servers always belong in `apm.yml`.
- Never move secrets into `apm.yml` or `.apm/`; reference environment variables, matching the native MCP config's approach.
- Do not delete the original native config until the user confirms the round-trip (step 6) matches. This skill adds APM source alongside it.
- In update mode, apply only the diff: never overwrite Unchanged primitives, and never auto-delete a primitive missing from the native config — flag it and let the user decide.
- Preserve the semantics of inclusion/scoping metadata (e.g. steering `inclusion` front-matter, skill `description` activation triggers) when converting.
- Present the inventory (step 3) — and in update mode the New/Changed/Unchanged/Removed reconciliation (step 3b) — and get approval before writing primitives or editing `apm.yml`.
