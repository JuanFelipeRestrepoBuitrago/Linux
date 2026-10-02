---
inclusion: fileMatch
fileMatchPattern: '**/*.{py,java,js,jsx,ts,tsx,ipynb},.kiro/specs/**/*'
---

# Error handling standard

- Use **typed and specific** exceptions/errors, not generic ones.
- Never silence errors (no empty `catch`, no swallowing).
- Fail fast: validate inputs at the boundaries (adapters) and throw early.
- Do not use exceptions for normal control flow.
- Translate infrastructure errors into domain errors in the adapter layer.
- Final handling/logging happens in the **global error handler** (see the logging standard), not scattered around.
