---
description: Fix Angular/TypeScript build errors and type errors with minimal changes. Run when ng build, nx build, or tsc fails.
allowed_tools: ["Read", "Write", "Edit", "Bash", "Grep", "Glob"]
---

Invoke the `build-error-resolver` agent.

1. Run `npx tsc --noEmit --pretty` to collect all type errors.
2. Run `ng build` or `nx build <project>` for Angular-specific compilation errors.
3. If errors persist after a fix, run `npm exec nx reset && rm -rf .angular/cache` to clear stale caches.
4. Fix errors with minimal diffs — no refactoring, no architecture changes, no renaming.
5. Verify `npx tsc --noEmit` exits 0 and `ng build` / `nx build` completes successfully.
6. Report what was fixed and confirm the build is green.
