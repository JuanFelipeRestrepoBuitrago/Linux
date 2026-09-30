---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Estándar de logging

Logging estructurado global. **Prohibido usar `print`**; se emite JSON manejado de forma centralizada.

## Campos del log (JSON)

- `@timestamp`: fecha y hora del evento (ISO 8601 UTC).
- `level`: `TRACE` | `DEBUG` | `INFO` | `WARN` | `ERROR` | `CRITICAL`.
- `message`: mensaje del evento (clave estable, no frase concatenada).
- `service.name`, `service.version`, `service.environment` (`local` | `dev` | `uat` | `prod`).
- `logger`: objeto/clase que emite el log.
- `correlationId`: id único del evento; obligatorio en eventos `ERROR`.

### Solo en eventos ERROR

- `error.type`, `error.message`.
- `stackTrace`: **opcional**, solo cuando se requiera y solo en `dev`/`release`. Debe ir saneado.

## Correlación

- El middleware lee el header `X-Correlation-ID`; si llega, se reutiliza; si no, se genera un UUID estable y se devuelve en la respuesta.

## Reglas

- Las excepciones se loguean en **un único punto global** (error handler); nunca en cada capa.
- Prohibido **log-and-throw**.
- Nunca loguear datos sensibles; si se incluyen, deben ir **enmascarados**.
- Prohibidos mensajes genéricos que impidan buscar/alertar con precisión.
- Prohibido concatenar strings para el mensaje: usa campos estructurados.
- Prohibido serializar objetos completos.
- Prohibido spam en loops de alto volumen sin techo (rate limit).
