---
name: create-pr
description: Opens a pull request following the Gitflow and PR standards — determines the correct target branch from the current branch, drafts a compliant description, gets approval, and creates the PR via the configured VCS MCP (GitHub by default).
---

# Create PR

Opens a standards-compliant pull request for the current branch.

## When to use

The user asks to open, create, or draft a pull request (without necessarily recommitting).

## Steps

1. Detect the current branch and ensure it is pushed to the remote (`git push -u origin <branch>` if needed).
2. Map the branch to its target following Gitflow:
   - `feature/*` → `development`
   - `bugfix/*` → `release`
   - `hotfix/*` → `main`
   If the branch does not match, ask the user for the target.
3. Draft the PR:
   - **Title**: Conventional Commits style, < 70 characters.
   - **Description**: what changed / why / how tested / breaking changes (or "None").
4. Show the proposed PR and **wait for approval**.
5. Create the PR via the configured VCS MCP (default GitHub). Return the PR URL.

## Rules

- Never target a protected branch outside the Gitflow mapping without confirmation.
- Never open a PR from a protected branch.
- Keep the PR focused on a single objective.
- Title and description in English.
