---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Logging standard

Global structured logging. **Using `print` is forbidden**; emit JSON handled centrally.

## Log fields (JSON)

- `@timestamp`: event date and time (ISO 8601 UTC).
- `level`: `TRACE` | `DEBUG` | `INFO` | `WARN` | `ERROR` | `CRITICAL`.
- `message`: event message (stable key, not a concatenated phrase).
- `service.name`, `service.version`, `service.environment` (`local` | `dev` | `uat` | `prod`).
- `logger`: object/class emitting the log.
- `correlationId`: unique event id; required on `ERROR` events.

### ERROR events only

- `error.type`, `error.message`.
- `stackTrace`: **optional**, only when required and only in `dev`/`release`. Must be sanitized.

## Correlation

- The middleware reads the `X-Correlation-ID` header; if present, it is reused; if not, a stable UUID is generated and returned in the response.

## Rules

- Exceptions are logged at **a single global point** (error handler); never in every layer.
- **Log-and-throw** is forbidden.
- Never log sensitive data; if included, it must be **masked**.
- Generic messages that prevent precise searching/alerting are forbidden.
- Concatenating strings for the message is forbidden: use structured fields.
- Serializing full objects is forbidden.
- Spamming in high-volume loops without a cap (rate limit) is forbidden.
