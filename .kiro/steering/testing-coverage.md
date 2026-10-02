---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Test coverage standard

**Minimum** coverage per layer:

- **Domain**: > 90%.
- **Use cases**: >= 85%.
- **Adapters**: >= 70%.
- **Global**: >= 80%.

These are minimums. The recommendation is to keep all layers above **90%**.

## Rules

- Prioritize tests of business logic (domain and use cases).
- Coverage is a floor, not a goal: cover edge cases and error paths, not just the happy path.
- Code that drops coverage below its layer minimum is not integrated.
