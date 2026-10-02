---
inclusion: manual
---

# Commit standard

Follow [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

## Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

- **type**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
- **description**: in English, imperative, lowercase, no trailing period.
- **Breaking change**: `!` after the type/scope or a `BREAKING CHANGE:` footer.

## Atomicity rule

- Each commit represents a single logical change.
- All files in a commit must be related and share the same purpose (the common message applies to all).
- If a set of changes cannot be described with a single message, split it into several commits.
