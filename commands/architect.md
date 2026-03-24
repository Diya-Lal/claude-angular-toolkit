---
description: Design or review Angular application architecture — component structure, state management, lazy loading, module boundaries, and scalability.
allowed_tools: ["Read", "Grep", "Glob"]
---

Invoke the `architect` agent.

1. Scan the existing Angular project structure: feature folders, shared/core layout, routing config, state management approach.
2. Identify the current patterns: standalone vs NgModule, signals vs RxJS, OnPush usage, lazy loading coverage.
3. For the requested change or review:
   - Propose component/service/module boundaries
   - Recommend state management strategy (signals, NgRx, services)
   - Define lazy loading boundaries
   - Identify shared constructs to extract to `shared/` or `core/`
4. Document each significant decision as a trade-off (pros/cons/alternatives/decision).
5. Flag any Angular anti-patterns found (God components, missing OnPush, subscription leaks, circular dependencies).
6. Output a clear architecture proposal with exact file paths and Angular construct types.
