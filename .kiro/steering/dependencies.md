---
inclusion: fileMatch
fileMatchPattern: '**/{package.json,requirements.txt,pyproject.toml,pom.xml,build.gradle,go.mod,Cargo.toml,*.csproj}'
---

# Dependencies standard

- Pin **exact or anchored** versions; avoid open ranges.
- Prefer well-known, actively maintained packages.
- Check for suspicious names (typosquatting) before adding a dependency.
- Justify every new dependency; avoid adding libraries for what the stdlib already solves.
- Keep a versioned lockfile.
- Review known vulnerabilities before integrating.
