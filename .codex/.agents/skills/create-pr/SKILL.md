---
name: create-pr
description: Drafts and, after explicit approval, opens a pull request following the Gitflow and PR standards; determines the correct target branch, prepares a compliant description, and uses an available VCS MCP.
---

# Create PR

Opens a standards-compliant pull request for the current branch.

## When to use

The user asks to open, create, or draft a pull request (without necessarily recommitting).

## Steps

1. Detect the current branch and inspect its upstream and configured remotes. If
   the branch is not pushed, include the exact push command as a proposed
   prerequisite; do not run it before approval.
2. Map the branch to its target following Gitflow:
   - `feature/*` → `development`
   - `bugfix/*` → `release`
   - `hotfix/*` → `main`
   If the branch does not match, ask the user for the target.
3. Draft the PR:
   - **Title**: Conventional Commits style, < 70 characters.
   - **Description**: what changed / why / how tested / breaking changes (or "None").
4. Show the proposed push (if needed) and PR, and **wait for explicit approval**
   before either mutation. Approval to draft does not authorize pushing or
   creating the PR.
5. After approval, push only when needed, then create the PR via the available
   VCS MCP. Prefer the GitHub MCP for GitHub repositories. If no suitable MCP is
   available, report the limitation and provide the prepared PR content instead
   of inventing a tool or scripting an API. Return the PR URL when created.

## Rules

- Never target a protected branch outside the Gitflow mapping without confirmation.
- Never open a PR from a protected branch.
- Keep the PR focused on a single objective.
- Title and description in English.
