---
name: generate-tests
description: Writes tests to meet the project's per-layer coverage minimums (domain 90%, use cases 85%, adapters 70%, global 80%), covering happy paths, edge cases and error paths using the project's existing test framework.
---

# Generate Tests

Creates tests that satisfy the coverage standard.

## When to use

The user asks to write tests, increase coverage, or add tests for a module/feature.

## Steps

1. Detect the test framework and layout already used in the project (do not introduce a new one unless none exists).
2. Identify the layer of the code under test to know its coverage target:
   - Domain > 90%, Use cases >= 85%, Adapters >= 70%, Global >= 80%.
3. Write tests covering:
   - The happy path.
   - Edge and boundary cases.
   - Error and failure paths.
4. Prefer testing behavior and business rules over implementation details.
5. Run the test suite and coverage report; iterate until the layer minimum is met.

## Rules

- Tests must be deterministic and isolated (no real network/DB unless it's an integration test by design).
- Mock external dependencies at the ports/adapters boundary.
- Test names and descriptions in English.
- Coverage is a floor, not the goal: assert meaningful behavior, not just line execution.
