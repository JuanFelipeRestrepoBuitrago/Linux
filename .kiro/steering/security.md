---
inclusion: always
---

# Estándar de seguridad

- **Nunca** hardcodear secretos (tokens, contraseñas, API keys) en el código o config versionada.
- Los secretos se leen de variables de entorno o gestores de secretos.
- Nunca commitear archivos con credenciales (`.env`, keys); asegúralos en `.gitignore`.
- Valida y sanea toda entrada externa; usa consultas parametrizadas.
- No expongas datos sensibles en logs ni respuestas de error (ver estándar de logging).
- Fija versiones de dependencias y prefiere paquetes mantenidos y conocidos.
