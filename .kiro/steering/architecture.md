---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Architecture standard

Design with **Clean Architecture** and favor **hexagonal architecture** (ports & adapters).

## Rules

- Dependencies always point inward: `adapters → use cases → domain`. The domain knows nothing about frameworks or infrastructure details.
- The domain holds pure entities and business rules, with no external dependencies.
- Use cases orchestrate the domain and define **ports** (interfaces).
- **Adapters** (driving/driven) implement the ports: HTTP, DB, messaging, etc.
- Dependency injection resolves implementations from the outside in.
- Isolate frameworks and libraries behind ports so they can be replaced.
