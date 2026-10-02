---
inclusion: always
---

# Security standard

- **Never** hardcode secrets (tokens, passwords, API keys) in code or versioned config.
- Secrets are read from environment variables or secret managers.
- Never commit files with credentials (`.env`, keys); add them to `.gitignore`.
- Validate and sanitize all external input; use parameterized queries.
- Do not expose sensitive data in logs or error responses (see the logging standard).
- Pin dependency versions and prefer well-known, actively maintained packages.
