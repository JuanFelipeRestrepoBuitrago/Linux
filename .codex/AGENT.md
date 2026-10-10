# Workspace Agent Instructions

These instructions consolidate the project rules from `.kiro/steering` for use
by Codex. They apply to work in this workspace.

Rules marked **always** apply to every task. Rules marked **when applicable**
apply when the relevant files, code, or workflow is involved. Commit, Gitflow,
and pull-request rules apply when performing those activities.

## Execution environment (always)

This environment runs on **WSL with Ubuntu (Linux)**.

- Always use Ubuntu/Linux commands and syntax (bash/zsh): `ls`, `rm`, `mkdir -p`,
  `apt`, and paths with `/`.
- **Never** use Windows commands (PowerShell, `cmd`, `dir`, paths with `\\`, or
  `.exe`).
- Use Linux-style absolute paths such as `/home/pipas/...`, not `C:\\...`.

## Concise responses (always)

- Do not greet or use courtesy formulas.
- Do not explain anything that was not asked.
- When changing code, return only the diff, not the full file.
- Do not repeat what the user said.
- Do not add code comments that were not requested.

## Security (always)

- **Never** hardcode secrets (tokens, passwords, API keys) in code or versioned
  config.
- Read secrets from environment variables or secret managers.
- Never commit files with credentials (`.env`, keys); add them to `.gitignore`.
- Validate and sanitize all external input; use parameterized queries.
- Do not expose sensitive data in logs or error responses.
- Pin dependency versions and prefer well-known, actively maintained packages.

## Prefer MCP servers over built-in equivalents (always)

When an MCP server covers a capability, use it instead of a built-in tool or
raw shell command.

### Git

- Use the `git` shell command for local Git operations (status, diff, log, add,
  commit, branch, and similar); there is no local Git MCP.
- Prefer the GitHub MCP server for GitHub operations (pull requests, issues,
  reviews, releases) over scripting the GitHub API or using raw shell.
- Fall back to shell only when the GitHub MCP is unavailable or the operation
  has no MCP equivalent.

### Fetch

- Prefer the fetch MCP server for retrieving web content.
- Fall back to built-in web fetch only when the fetch MCP is unavailable.

## Code language (when applicable)

All code and its documentation are written in **English**.

This includes:

- Names of variables, functions, classes, methods, constants, and files.
- Comments and docstrings.
- Log and error messages.
- Technical documentation (README files, specs, docstrings, and config
  comments).

Exception: domain content explicitly written in another language, such as
localized UI text.

## Architecture (when applicable)

Design with **Clean Architecture** and favor **hexagonal architecture** (ports
and adapters).

- Dependencies always point inward: `adapters → use cases → domain`. The domain
  knows nothing about frameworks or infrastructure details.
- The domain holds pure entities and business rules, with no external
  dependencies.
- Use cases orchestrate the domain and define **ports** (interfaces).
- **Adapters** (driving and driven) implement the ports: HTTP, database,
  messaging, and similar concerns.
- Dependency injection resolves implementations from the outside in.
- Isolate frameworks and libraries behind ports so they can be replaced.

## API design — REST (when applicable)

- Model resources as plural nouns: `/users`, `/orders/{id}`.
- Use the correct HTTP verbs: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
- Use appropriate status codes: `200`, `201`, `204`, `400`, `401`, `403`, `404`,
  `409`, `422`, `500`.
- Version the API: `/v1/...`.
- Use a consistent response and error format with structured JSON.
- Support pagination, filtering, and sorting through query parameters.
- Never expose internal details or stack traces in responses.

## Code quality (when applicable)

Apply **SOLID** and **Clean Code** principles.

### SOLID

- **S**: one class has a single responsibility.
- **O**: code is open for extension and closed for modification.
- **L**: subtypes must be substitutable for their base type.
- **I**: use small, specific interfaces rather than monolithic ones.
- **D**: depend on abstractions, not concrete implementations.

### Clean Code

- Use descriptive, expressive names.
- Keep functions short and focused on one thing.
- Avoid duplication (DRY) and unnecessary complexity (KISS, YAGNI).
- Avoid magic numbers; use named constants.
- Handle errors explicitly; do not silence them.

## Naming conventions (when applicable)

- Use English, descriptive names without ambiguous abbreviations.
- Classes and types: `PascalCase`.
- Functions, methods, and variables: `camelCase` (JavaScript/TypeScript/Java)
  or `snake_case` (Python), according to the language.
- Constants: `UPPER_SNAKE_CASE`.
- Prefix booleans with intent: `is`, `has`, `can`, or `should`.
- Keep files and folders consistent with the language and framework convention.
- Avoid generic names such as `data`, `info`, `temp`, or `manager` without
  context.

## Documentation (when applicable)

- Every public API (function, method, or class) has a docstring/JSDoc explaining
  its purpose, parameters, return value, and errors.
- Each module or package has a brief README describing its responsibility and
  how to use it.
- Document the *why*, not the obvious *what*; the code explains the what.
- Keep documentation in sync with code in the same commit as the change.
- Write all documentation in English.

## Error handling (when applicable)

- Use typed and specific exceptions/errors, not generic ones.
- Never silence errors (no empty `catch` and no swallowing).
- Fail fast: validate inputs at boundaries (adapters) and throw early.
- Do not use exceptions for normal control flow.
- Translate infrastructure errors into domain errors in the adapter layer.
- Final handling and logging happen in the global error handler, not scattered
  throughout individual layers.

## Logging (when applicable)

Use global structured logging. **Using `print` is forbidden**; emit JSON handled
centrally.

### JSON log fields

- `@timestamp`: event date and time in ISO 8601 UTC.
- `level`: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, or `CRITICAL`.
- `message`: stable event key, not a concatenated phrase.
- `service.name`, `service.version`, and `service.environment` (`local`, `dev`,
  `uat`, or `prod`).
- `logger`: object or class emitting the log.
- `correlationId`: unique event ID; required on `ERROR` events.

### ERROR events only

- `error.type` and `error.message`.
- `stackTrace`: optional, only when required and only in `dev` or `release`; it
  must be sanitized.

### Logging rules

- Middleware reads `X-Correlation-ID`; reuse it when present. Otherwise generate
  a stable UUID and return it in the response.
- Log exceptions at a single global point (the error handler), never in every
  layer.
- **Log-and-throw** is forbidden.
- Never log sensitive data; mask it if it must be included.
- Avoid generic messages that prevent precise searching or alerting.
- Do not concatenate strings for the message; use structured fields.
- Do not serialize full objects.
- Do not spam high-volume loops without a cap or rate limit.

## Dependencies (when applicable)

- Pin exact or anchored versions; avoid open ranges.
- Prefer well-known, actively maintained packages.
- Check for suspicious names (including typosquatting) before adding a
  dependency.
- Justify every new dependency; do not add a library for something the standard
  library already solves.
- Keep a versioned lockfile.
- Review known vulnerabilities before integrating a dependency.

## Test coverage (when applicable)

Minimum coverage per layer:

- **Domain**: > 90%.
- **Use cases**: >= 85%.
- **Adapters**: >= 70%.
- **Global**: >= 80%.

These are minimums; the recommendation is to keep every layer above 90%.

- Prioritize business-logic tests (domain and use cases).
- Coverage is a floor, not a goal: cover edge cases and error paths, not only
  the happy path.
- Do not integrate code that drops coverage below its layer minimum.

## Gitflow (when committing or creating branches)

### Protected branches

The following branches are not modified directly and are reached only through
pull requests:

- `main` → production.
- `release` → pre-production.
- `development` → integration.

### Work branches and pull-request targets

- `feature/<name>` → pull request into `development`.
- `bugfix/<name>` → pull request into `release`.
- `hotfix/<name>` → pull request into `main`.

### Rules

- Never commit or push directly to `main`, `release`, or `development`.
- Every change starts in a work branch and is integrated through a pull request.

## Commits (when creating commits)

Follow [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

### Format

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

- **type**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`,
  `ci`, `chore`, or `revert`.
- **description**: English, imperative, lowercase, with no trailing period.
- **Breaking change**: `!` after the type/scope or a `BREAKING CHANGE:` footer.

### Atomicity

- Each commit represents one logical change.
- All files in a commit must be related and share one purpose; the common
  message must describe all of them.
- If a set of changes cannot be described with one message, split it into
  several commits.

## Pull requests (when creating or reviewing PRs)

Every PR description includes:

- **What changed**: concise summary.
- **Why**: motivation or associated issue.
- **How it was tested**: tests run or verification steps.
- **Breaking changes**: state them explicitly or write `None`.

Rules:

- Use a concise title following Conventional Commits, under 70 characters.
- Keep the PR small and focused on one objective.
- Target the branch required by the Gitflow standard.
- Do not mix large refactors with functional changes in the same PR.

## Engram persistent memory (always, when Engram is available)

Treat Engram as the project's long-term memory and prefer it over asking the
user about project facts. The workspace's configured Engram server defines the
project scope. Do not validate `.engram/config.json` and do not run `engram
init`; scoping is handled by the per-workspace MCP configuration.

### Session start

Once per session, call `mem_context` to load recent session history.

### Before any task

Retrieve relevant memory before acting; do not ask the user or make decisions
blind:

- Before architectural decisions, call `mem_search` for prior decisions.
- Before implementing a feature, call `mem_search` for related context.
- Before asking the user about the project, call `mem_search` first.

Search terms should cover architecture, technical design, coding conventions,
deployment, known bugs, workarounds, pending tasks, and project-specific
patterns.

### Durable facts

Use `mem_pin` for knowledge that must always surface: core architecture,
production deployment procedures, critical system constraints, required
conventions, and key operational knowledge.

### Empty or new project bootstrap

When the project has little or no memory, analyze the repository once and use
`mem_save` to persist a baseline covering the tech stack, architecture,
infrastructure, deployment process, testing strategy, and coding conventions.
Follow the save rules below.

### Token discipline

- Save only durable, non-obvious knowledge. Never save trivial edits, formatting
  changes, temporary experiments, or facts already obvious from the repository.
- Reuse a stable `topic_key` to update evolving topics instead of creating
  duplicates.
- Search before re-deriving anything that may already be stored.

### Required memory saves

Call `mem_save` immediately after:

- A bug fix is completed.
- An architecture or design decision is made.
- A non-obvious codebase discovery is made.
- A configuration change or environment setup is completed.
- A pattern is established (naming, structure, or convention).
- A user preference or constraint is learned.

Use this format:

- **title**: verb plus what, short and searchable (for example, `Fixed N+1
  query in UserList` or `Chose Zustand over Redux`).
- **type**: `bugfix`, `decision`, `architecture`, `discovery`, `pattern`,
  `config`, or `preference`.
- **scope**: `project` (default), `personal`, or `global`.
- **topic_key**: optional but recommended for evolving decisions; use a stable
  key such as `architecture/auth-model`.
- **content**:
  - **What**: one sentence describing what was done.
  - **Why**: motivation (user request, bug, performance, and so on).
  - **Where**: affected files or paths.
  - **Learned**: gotchas, edge cases, or surprises, if any.

Different topics must not overwrite one another. Reuse the same `topic_key` to
update an evolving topic. If unsure about the key, call
`mem_suggest_topic_key` first, then reuse the result. Use `mem_update` when an
exact observation ID must be corrected.

Memory operations are internal bookkeeping. Complete required memory work before
the completed-task reply; if memory work fails or needs follow-up, still send the
answer.

### Memory search requests

When the user asks to recall past work (including "remember", "recall", "what did
we do", or equivalent wording), first call `mem_context`, then call `mem_search`
with relevant keywords if needed. If a match is found, call
`mem_get_observation` for its full, untruncated content.

Also search memory proactively when starting work that may have been done before
or when the user mentions a topic not covered by the current context.

### Session close

Before ending a session or saying "done", "listo", or "that's it":

1. Call `mem_session_summary` with:

   ```text
   ## Goal

   [What we were working on this session]

   ## Instructions

   [User preferences or constraints discovered — skip if none]

   ## Discoveries

   - [Technical findings, gotchas, non-obvious learnings]

   ## Accomplished

   - [Completed items with key details]

   ## Next Steps

   - [What remains to be done — for the next session]

   ## Relevant Files

   - path/to/file — [what it does or what changed]
   ```

2. Call `mem_session_end` with the active session ID and an optional summary of
   the completed work.

### Passive capture

When completing a task or subtask, include a `## Key Learnings:` section at the
end of the response with numbered items. Engram can automatically extract and
save these observations. Alternatively, call `mem_capture_passive(content)` with
text containing a learning section.

### After compaction

If the context is compacted or reset, or `FIRST ACTION REQUIRED` appears:

1. Immediately call `mem_session_summary` with the compacted summary.
2. Then call `mem_context` to recover additional context.
3. Only then continue working.

## End of workspace instructions
