---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Estándar de calidad de código

Aplica principios **SOLID** y **Clean Code**.

## SOLID

- **S**: una clase, una única responsabilidad.
- **O**: abierto a extensión, cerrado a modificación.
- **L**: los subtipos deben ser sustituibles por su tipo base.
- **I**: interfaces pequeñas y específicas, no monolíticas.
- **D**: depende de abstracciones, no de implementaciones concretas.

## Clean Code

- Nombres descriptivos y expresivos.
- Funciones cortas que hacen una sola cosa.
- Evita duplicación (DRY) y complejidad innecesaria (KISS, YAGNI).
- Sin números mágicos; usa constantes con nombre.
- Maneja errores explícitamente; no los silencies.
