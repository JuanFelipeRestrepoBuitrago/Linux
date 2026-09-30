---
inclusion: manual
---

# Estándar de commits

Sigue [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

## Formato

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

- **type**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`.
- **description**: en inglés, imperativo, minúscula, sin punto final.
- **Breaking change**: `!` tras el type/scope o footer `BREAKING CHANGE:`.

## Regla de atomicidad

- Cada commit representa un solo cambio lógico.
- Todos los archivos de un commit deben estar relacionados y compartir el mismo propósito (el mensaje común aplica a todos).
- Si un conjunto de cambios no se puede describir con un único mensaje, divídelo en varios commits.
