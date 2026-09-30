---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Estándar de convenciones de nombres

- Nombres en **inglés**, descriptivos y sin abreviaturas ambiguas.
- Clases/Tipos: `PascalCase`.
- Funciones/métodos/variables: `camelCase` (JS/TS/Java) o `snake_case` (Python), según el idioma.
- Constantes: `UPPER_SNAKE_CASE`.
- Booleanos con prefijo de intención: `is`, `has`, `can`, `should`.
- Archivos y carpetas coherentes con la convención del lenguaje/framework.
- Evita nombres genéricos (`data`, `info`, `temp`, `manager`) sin contexto.
