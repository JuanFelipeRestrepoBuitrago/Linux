---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,html,css,scss,ipynb,json},.kiro/specs/**/*'
---

# Code quality standard

Apply **SOLID** and **Clean Code** principles.

## SOLID

- **S**: one class, a single responsibility.
- **O**: open for extension, closed for modification.
- **L**: subtypes must be substitutable for their base type.
- **I**: small, specific interfaces, not monolithic ones.
- **D**: depend on abstractions, not concrete implementations.

## Clean Code

- Descriptive, expressive names.
- Short functions that do a single thing.
- Avoid duplication (DRY) and unnecessary complexity (KISS, YAGNI).
- No magic numbers; use named constants.
- Handle errors explicitly; do not silence them.
