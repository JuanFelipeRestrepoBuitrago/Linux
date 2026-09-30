---
inclusion: fileMatch
fileMatchPattern: '**/{package.json,requirements.txt,pyproject.toml,pom.xml,build.gradle,go.mod,Cargo.toml,*.csproj}'
---

# Estándar de dependencias

- Fija versiones **exactas o ancladas**; evita rangos abiertos.
- Prefiere paquetes conocidos y activamente mantenidos.
- Revisa nombres sospechosos (typosquatting) antes de añadir una dependencia.
- Justifica cada dependencia nueva; evita añadir librerías para lo que la stdlib resuelve.
- Mantén un lockfile versionado.
- Revisa vulnerabilidades conocidas antes de integrar.
