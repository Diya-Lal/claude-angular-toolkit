---
description: Review recent Angular/TypeScript code changes for quality, security, and Angular best practices.
allowed_tools: ["Read", "Grep", "Glob", "Bash"]
---

Invoke the `code-reviewer` agent.

1. Run `git diff --staged` and `git diff` to find all changes. If empty, check `git log --oneline -5`.
2. Review the changed Angular/TypeScript files against the full checklist:
   - Security (XSS, auth, token storage, route guards)
   - Code quality (OnPush, subscription leaks, input mutation, DOM access)
   - Angular patterns (trackBy, toSignal, standalone imports, lifecycle hooks)
   - TypeScript quality (any, non-null assertions, untyped HTTP)
   - Performance (method calls in templates, inline objects, lazy loading)
3. Output findings by severity (CRITICAL → HIGH → MEDIUM → LOW).
4. End with a summary table and a clear Approve / Warning / Block verdict.
