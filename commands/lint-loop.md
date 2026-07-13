---
description: Run ESLint in a loop — auto-fix what's possible, manually fix the rest, and re-lint until clean. Stops after 10 iterations or on success.
allowed_tools: ["Read", "Edit", "Write", "Bash", "Grep", "Glob"]
---

Run a self-correcting lint loop. Fix lint errors and re-lint until clean.

## Rules

1. Run `npx eslint . --ext .ts,.html` (or the project's lint command from `package.json` scripts) and capture the output.
2. If no errors, stop and report success.
3. If there are errors:
   - First, try auto-fix: run `npx eslint . --ext .ts,.html --fix`
   - Re-lint to see what remains.
   - For remaining errors, read each file and apply the minimal manual fix.
4. After fixing, re-lint immediately.
5. Repeat until clean.

## Safety Limits

- **Max 10 iterations.** If lint still fails after 10 rounds, stop and report remaining errors.
- **No circular fixes.** If the same error reappears after fixing, stop and report it.
- **Track progress.** Each iteration must reduce the error count. If the count increases or stays the same for 2 consecutive iterations, stop and ask the user.
- **No suppression.** Do NOT add `// eslint-disable` comments to silence errors. Fix the actual issue.
- **No config changes.** Do NOT modify `.eslintrc`, `eslint.config.js`, or `angular.json` lint settings.

## Output

After each iteration, report:
```
Iteration X: [N errors] → [auto-fixed Y, manually fixed Z] → re-linting...
```

On completion:
```
Lint clean after X iterations.
Files modified:
- path/to/file.ts (what was fixed)
```

Or on failure:
```
Stopped after X iterations. Y errors remaining:
- error 1 (file:line)
- error 2 (file:line)
Recommendation: [what the user should do]
```
