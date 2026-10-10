---
name: commit-workflow
description: Reads current git changes, groups them into atomic Conventional Commits, gets approval before each external mutation, executes approved commits, optionally pushes, and optionally creates a pull request following Gitflow.
---

# Commit Workflow

Guides the commit → push → pull request flow using the commits and Gitflow
standards. Treat commits, pushes, and pull-request creation as separate
mutations requiring explicit approval.

## When to use

The user asks to commit, group changes, push, or open a pull request.

## Steps

### 1. Inspect changes

- Run `git status` and `git diff` (staged and unstaged) to see all pending changes.
- Determine the current branch and whether a remote is configured (`git remote -v`).

### 2. Build the commit plan

- Group changes into **atomic commits**: each group holds only related changes sharing a single purpose.
- Split unrelated changes into separate commits, even within the same file if needed.
- Write each message as [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/): `<type>(scope): <description>` in English, imperative mood.
- Present the plan as a numbered list: for each commit show its message and the exact files it will include.

### 3. Get approval for the commit plan

- Show the full plan and **wait for explicit user approval** before executing anything.
- If the user requests changes, adjust the grouping and re-present.

### 4. Execute commits

- For each commit: stage its specific files (`git add <files>`) and commit with its message.
- Never use `git add .`; stage only the files belonging to that commit.
- Verify each commit succeeded before moving to the next.

### 5. Push (only when requested and approved)

- Do not push merely because a remote is configured.
- If pushing is in scope, show the exact remote and branch and **wait for
  explicit approval** before running `git push`.
- Use the configured upstream or an explicitly selected remote; do not assume
  `origin` when inspection shows another remote.
- Never push directly to `main`, `release`, or `development`.

### 6. Pull request (if on a Gitflow work branch)

Following the Gitflow standard, map the branch to its PR target:

- `feature/*` → PR into `development`.
- `bugfix/*` → PR into `release`.
- `hotfix/*` → PR into `main`.

- Propose a PR (title in Conventional Commits style, description with what changed / why / how tested / breaking changes).
- After approval, create the PR using the available version-control MCP. Prefer
  the GitHub MCP for GitHub repositories; if no suitable MCP is available,
  report that limitation instead of inventing a tool or scripting an API.

## Rules

- Atomicity above all: prefer more, smaller commits over one large mixed commit.
- Do not commit secrets; flag files like `.env` or credential files before staging.
- Always get separate explicit approval before committing, pushing, or opening a
  PR. Approval for one mutation does not authorize the others.
