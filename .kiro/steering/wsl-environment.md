---
inclusion: always
---

# Entorno de ejecución: WSL (Ubuntu)

Este entorno corre sobre **WSL con Ubuntu (Linux)**.

- Usa siempre comandos y sintaxis de **Ubuntu/Linux** (bash/zsh): `ls`, `rm`, `mkdir -p`, `apt`, rutas con `/`.
- **Nunca** uses comandos de Windows (PowerShell, `cmd`, `dir`, rutas con `\`, `.exe`).
- Rutas absolutas estilo Linux (`/home/pipas/...`), no `C:\`.

Esto evita reintentos y consumo innecesario de tokens.
