---
description: Deep TypeScript and Angular type-safety review — type correctness, async patterns, Angular idioms, and template type-checking.
allowed_tools: ["Read", "Grep", "Glob", "Bash"]
---

Invoke the `typescript-reviewer` agent.

1. Establish review scope via `git diff --staged`, `git diff`, or `git show --patch HEAD -- '*.ts' '*.html'`.
2. Run `npm run typecheck` (or `tsc --noEmit -p tsconfig.app.json` / `nx run <project>:type-check`) — stop and report if it fails.
3. Run `eslint . --ext .ts,.html` if available — stop and report if it fails.
4. Review changed files for:
   - Type safety (any, non-null assertions, untyped HttpClient, unsafe casts)
   - Angular idioms (OnPush, subscription leaks, input mutation, lifecycle correctness)
   - Async correctness (unhandled rejections, sequential awaits, missing catchError)
   - Template correctness (trackBy, method calls in templates, inline object literals)
   - Security (XSS, bypassSecurityTrust, hardcoded secrets, token storage)
5. Report findings by severity. End with Approve / Warning / Block verdict.
