---
description: Scan Angular/TypeScript frontend code for security vulnerabilities — XSS, unsafe token storage, missing route guards, hardcoded secrets, and vulnerable dependencies.
allowed_tools: ["Read", "Write", "Edit", "Bash", "Grep", "Glob"]
---

Invoke the `security-reviewer` agent.

1. Run `npm audit --audit-level=high` for dependency CVEs.
2. Grep for high-risk patterns: `bypassSecurityTrust`, `innerHTML`, `localStorage`, `sessionStorage`, `console.log`, hardcoded API keys.
3. Review high-risk areas: auth service, route guards, HTTP interceptors, forms with passwords/PII, environment files.
4. Check the OWASP frontend checklist: XSS, broken auth, sensitive data exposure, broken access control, security misconfiguration.
5. Flag every finding with file:line, severity (CRITICAL/HIGH/MEDIUM), and a concrete fix.
6. End with a summary table and overall security verdict.

If a CRITICAL vulnerability is found, document it fully and provide a secure code example before anything else.
