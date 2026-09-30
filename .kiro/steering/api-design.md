---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx},.kiro/specs/**/*'
---

# Estándar de diseño de APIs (REST)

- Recursos en plural y sustantivos: `/users`, `/orders/{id}`.
- Usa los verbos HTTP correctos: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
- Códigos de estado adecuados: `200`, `201`, `204`, `400`, `401`, `403`, `404`, `409`, `422`, `500`.
- Versiona la API: `/v1/...`.
- Respuestas y errores con formato consistente (JSON estructurado).
- Paginación, filtrado y ordenamiento vía query params.
- Nunca exponer detalles internos ni stack traces en las respuestas.
