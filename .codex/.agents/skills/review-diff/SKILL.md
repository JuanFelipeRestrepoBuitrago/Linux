---
name: review-diff
description: Reviews the current git diff (or a given PR diff) against the project's standards — SOLID, Clean Code, architecture, security, logging, naming, error handling and test coverage — and returns a structured, actionable review.
---

# Review Diff

Performs a structured code review of a diff against the project standards.

## When to use

The user asks to review changes, review a diff, or review a pull request before merging.

## Steps

1. Get the diff:
   - Local: `git diff` (unstaged), `git diff --staged`, or `git diff <base>...<head>`.
   - PR: read the PR diff via the configured VCS MCP.
2. Review each change against the standards below.
3. Return findings grouped by severity: **Blocker**, **Major**, **Minor**, **Nit**. For each finding give file, line/area, the issue, and a concrete fix.
4. End with a short verdict: approve, approve with comments, or request changes.

## Review checklist

- **Architecture**: dependencies point inward (adapters → use cases → domain); no framework leakage into domain.
- **SOLID / Clean Code**: single responsibility, small functions, no duplication, no magic numbers, expressive names.
- **Naming**: English, descriptive, per-language conventions.
- **Error handling**: typed errors, no swallowed exceptions, no log-and-throw; single global handler.
- **Logging**: structured JSON, no `print`, required fields present, no sensitive data, no full-object serialization.
- **Security**: no hardcoded secrets, input validated, parameterized queries.
- **Tests**: coverage meets per-layer minimums (domain 90, use cases 85, adapters 70, global 80); edge and error paths covered.
- **Documentation**: public APIs documented; docs updated with the change.

## Rules

- Be specific and actionable; avoid vague comments.
- Do not rewrite unrelated code; focus on the diff.
- Comments and suggestions in English.
