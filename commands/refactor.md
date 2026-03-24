---
description: Clean up dead code, unused Angular components/services/pipes, duplicate constructs, and unused dependencies.
allowed_tools: ["Read", "Write", "Edit", "Bash", "Grep", "Glob"]
---

Invoke the `refactor-cleaner` agent.

1. Run detection tools: `npx knip`, `npx depcheck`, `npx ts-prune`.
2. Search templates too — grep for component selectors and pipe names in `.html` files, not just `.ts`.
3. Categorize findings: SAFE (unused private/internal), CAREFUL (dynamic imports, lazy routes), RISKY (shared library public API).
4. Remove one category at a time — deps first, then exports, then files, then duplicates.
5. After each batch: run `ng build` / `nx build` and `ng test` to confirm no regressions.
6. Commit each batch separately with a descriptive message.

Do NOT remove code during active feature development or right before a deployment.
