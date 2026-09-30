---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Estándar de arquitectura

Diseña con **Clean Architecture** y favorece **arquitectura hexagonal** (ports & adapters).

## Reglas

- La dependencia siempre apunta hacia adentro: `adapters → use cases → domain`. El dominio no conoce frameworks ni detalles de infraestructura.
- El dominio contiene entidades y reglas de negocio puras, sin dependencias externas.
- Los casos de uso orquestan el dominio y definen **puertos** (interfaces).
- Los **adaptadores** (driving/driven) implementan los puertos: HTTP, DB, mensajería, etc.
- La inyección de dependencias resuelve las implementaciones desde fuera hacia adentro.
- Aísla frameworks y librerías detrás de puertos para poder sustituirlos.
