---
inclusion: always
---

# Engram usage policy (project long-term memory)

Complements the Memory Protocol in `engram.md`. Treat Engram as the project's
long-term memory: prefer it over asking the user about project facts.

## Session start (mandatory, once)

1. Read `<workspace-root>/.engram/config.json`. If it exists and has
   `project_name`, that value is the project scope — use it.
2. If it does NOT exist, fall back to `engram init` (see Project scoping below):
   ask the user for a name, run `engram init <name>`, which creates the config.
   Do NOT use `mem_current_project` — it resolves scope from the process cwd,
   which in this environment can point at Kiro's install dir instead of the
   workspace and silently resolve the wrong project (e.g. `kiro`).
3. `mem_context` — load recent session history.

Once the name is known from the config, pass `project: <name>` EXPLICITLY on
every `mem_save` / `mem_search` / `mem_session_summary` call for the rest of the
session.

## Before any task (mandatory)

Retrieve before acting. Do not ask the user or make decisions blind:

- Before architectural decisions → `mem_search` prior decisions.
- Before implementing a feature → `mem_search` related context.
- Before asking the user about the project → `mem_search` first.

Search terms to cover: architecture, technical design, coding conventions,
deployment, known bugs, workarounds, pending tasks, project-specific patterns.

## Pin durable facts

`mem_pin` knowledge that must always surface: core architecture, production
deployment procedures, critical system constraints, required conventions, key
operational knowledge.

## Project scoping (mandatory before writing)

Resolve the scope with exactly two cases — never use `mem_current_project`:

1. `<workspace-root>/.engram/config.json` exists with `project_name` → that is
   the project. Use it and proceed. Do NOT ask the user, do NOT run
   `engram init` — the project is already configured.
2. No `.engram/config.json` → you MUST ask the user for a project name before
   writing anything. The name is the user's choice and must never be guessed,
   auto-derived from the cwd, or assumed. Only after the user provides the name:
    1. Run `engram init <name>` in the repo root, which creates
       `.engram/config.json` and pins the scope.
    2. Then run the empty-project bootstrap below.

`engram init` is the ONLY fallback when the config is absent. Never run it when
`.engram/config.json` already names a project — doing so risks clobbering or
duplicating the scope.

Never set a single global scope for all repos: each repo gets its own
`engram init`. Use `mem_list_projects` to scope a read to another project when
needed.

## Empty / new project bootstrap

Right after `engram init` on a new project (or when a known project has little
or no memory), analyze the repository once and persist a baseline with
`mem_save`: tech stack, architecture, infrastructure, deployment process,
testing strategy, coding conventions. Follow the save rules in `engram.md`.

## Token discipline

- Save only durable, non-obvious knowledge (see `engram.md`). Never save
  trivial edits, formatting changes, temporary experiments, or facts already
  obvious from the repo.
- Reuse a stable `topic_key` to update evolving topics instead of creating
  duplicates.
- Search before re-deriving anything that may already be stored.
