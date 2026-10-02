---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Naming conventions standard

- Names in **English**, descriptive and without ambiguous abbreviations.
- Classes/Types: `PascalCase`.
- Functions/methods/variables: `camelCase` (JS/TS/Java) or `snake_case` (Python), depending on the language.
- Constants: `UPPER_SNAKE_CASE`.
- Booleans with an intent prefix: `is`, `has`, `can`, `should`.
- Files and folders consistent with the language/framework convention.
- Avoid generic names (`data`, `info`, `temp`, `manager`) without context.
