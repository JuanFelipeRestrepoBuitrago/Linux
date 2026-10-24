---
description: Engram usage policy - treat it as the project's long-term memory, retrieve before acting, pin durable facts.
---
# Engram usage policy (project long-term memory)
Complements the Memory Protocol in `engram.md`. Treat Engram as the project's
long-term memory: prefer it over asking the user about project facts.
Each workspace defines its own Engram server in `.kiro/settings/mcp.json`, so
the project scope is already configured. Do NOT validate `.engram/config.json`
and do NOT run `engram init` — scoping is handled by the per-workspace MCP
config.
## Session start (mandatory, once)
`mem_context` — load recent session history.
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
## Empty / new project bootstrap
When a project has little or no memory, analyze the repository once and persist
a baseline with `mem_save`: tech stack, architecture, infrastructure, deployment
process, testing strategy, coding conventions. Follow the save rules in
`engram.md`.
## Token discipline
- Save only durable, non-obvious knowledge (see `engram.md`). Never save
  trivial edits, formatting changes, temporary experiments, or facts already
  obvious from the repo.
- Reuse a stable `topic_key` to update evolving topics instead of creating
  duplicates.
- Search before re-deriving anything that may already be stored.
