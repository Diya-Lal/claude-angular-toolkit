---
description: Run a comprehensive multi-agent review covering architecture, code quality, security, accessibility, TypeScript, performance, and refactoring in parallel.
allowed_tools: ["Agent", "Read", "Bash", "Glob", "Grep"]
---

Invoke the `review-orchestrator` agent.

1. Determine review scope — check `git diff`, staged changes, or recent commits.
2. Spin up 7 specialist agents **in parallel** using the Agent tool:
   - **Architecture** — component structure, module boundaries, lazy loading, state management
   - **Code Quality** — OnPush, subscriptions, Angular patterns, dead code, missing tests
   - **Security** — XSS, auth, token storage, route guards, secrets, npm audit
   - **Accessibility** — WCAG 2.2 AA, ARIA, keyboard nav, focus management, form labels
   - **TypeScript** — type safety, `any` usage, casts, untyped HTTP, async handling
   - **Performance** — bundle size, CD thrashing, memory leaks, lazy loading, template perf
   - **Refactoring** — dead code, duplicates, large components, consolidation opportunities
3. Consolidate all agent results into a unified report.
4. End with an overall summary table and a final verdict: APPROVE / WARNING / BLOCK.
