---
name: commit-workflow
description: Reads current git changes, groups them into atomic Conventional Commits, gets user approval for the plan, executes commits, pushes when a remote exists, and proposes/creates a pull request following Gitflow when on a feature/bugfix/hotfix branch.
---

# Commit Workflow

Automates the commit → push → pull request flow using the commits and gitflow standards.

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

### 3. Get approval

- Show the full plan and **wait for explicit user approval** before executing anything.
- If the user requests changes, adjust the grouping and re-present.

### 4. Execute commits

- For each commit: stage its specific files (`git add <files>`) and commit with its message.
- Never use `git add .`; stage only the files belonging to that commit.
- Verify each commit succeeded before moving to the next.

### 5. Push (if remote exists)

- If a remote is configured, push the branch (`git push -u origin <branch>`).
- Never push directly to `main`, `release`, or `development`.

### 6. Pull request (if on a Gitflow work branch)

Following the Gitflow standard, map the branch to its PR target:

- `feature/*` → PR into `development`.
- `bugfix/*` → PR into `release`.
- `hotfix/*` → PR into `main`.

- Propose a PR (title in Conventional Commits style, description with what changed / why / how tested / breaking changes).
- After approval, create the PR using the configured version-control MCP (GitHub, Azure DevOps, or Bitbucket). Default to GitHub if available.

## Rules

- Atomicity above all: prefer more, smaller commits over one large mixed commit.
- Do not commit secrets; flag files like `.env` or credential files before staging.
- Always get approval before committing, pushing, or opening a PR.
