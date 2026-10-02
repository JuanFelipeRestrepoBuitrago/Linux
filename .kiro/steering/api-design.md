---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx},.kiro/specs/**/*'
---

# API design standard (REST)

- Resources as plural nouns: `/users`, `/orders/{id}`.
- Use the correct HTTP verbs: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
- Appropriate status codes: `200`, `201`, `204`, `400`, `401`, `403`, `404`, `409`, `422`, `500`.
- Version the API: `/v1/...`.
- Consistent response and error format (structured JSON).
- Pagination, filtering and sorting via query params.
- Never expose internal details or stack traces in responses.
