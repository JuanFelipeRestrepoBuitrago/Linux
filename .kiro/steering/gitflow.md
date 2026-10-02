---
inclusion: manual
---

# Gitflow standard

## Protected branches (not modified directly)

- `main` → production.
- `release` → pre-production.
- `development` → integration.

These branches are **only** reached through pull requests.

## Work branches → PR target

- `feature/<name>` → PR into `development`.
- `bugfix/<name>` → PR into `release`.
- `hotfix/<name>` → PR into `main`.

## Rules

- Never commit or push directly to `main`, `release` or `development`.
- Every change starts in its work branch and is integrated via pull request.
