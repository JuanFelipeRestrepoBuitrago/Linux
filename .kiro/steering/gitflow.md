---
inclusion: manual
---

# Estándar de Gitflow

## Ramas protegidas (no se modifican directamente)

- `main` → producción.
- `release` → preproducción.
- `development` → integración.

A estas ramas **solo** se llega por pull request.

## Ramas de trabajo → destino del PR

- `feature/<nombre>` → PR hacia `development`.
- `bugfix/<nombre>` → PR hacia `release`.
- `hotfix/<nombre>` → PR hacia `main`.

## Reglas

- Nunca hacer commit ni push directo a `main`, `release` o `development`.
- Cada cambio nace en su rama de trabajo y se integra vía pull request.
