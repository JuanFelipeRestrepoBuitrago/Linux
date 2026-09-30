---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,ipynb},.kiro/specs/**/*'
---

# Estándar de manejo de errores

- Usa excepciones/errores **tipados y específicos**, no genéricos.
- Nunca silencies errores (no `catch` vacío, no swallow).
- Falla rápido: valida entradas en los límites (adaptadores) y lanza temprano.
- No uses excepciones para flujo de control normal.
- Traduce errores de infraestructura a errores de dominio en la capa adaptadora.
- El manejo/log final ocurre en el **error handler global** (ver estándar de logging), no disperso.
