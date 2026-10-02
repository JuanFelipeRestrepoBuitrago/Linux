---
inclusion: always
---

# Execution environment: WSL (Ubuntu)

This environment runs on **WSL with Ubuntu (Linux)**.

- Always use **Ubuntu/Linux** commands and syntax (bash/zsh): `ls`, `rm`, `mkdir -p`, `apt`, paths with `/`.
- **Never** use Windows commands (PowerShell, `cmd`, `dir`, paths with `\`, `.exe`).
- Linux-style absolute paths (`/home/pipas/...`), not `C:\`.

This avoids retries and unnecessary token consumption.
