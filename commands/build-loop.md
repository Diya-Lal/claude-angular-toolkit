---
description: Run ng build / nx build in a loop — fix errors and rebuild until the build is green. Stops after 10 iterations or on success.
allowed_tools: ["Read", "Edit", "Write", "Bash", "Grep", "Glob"]
---

Run a self-correcting build loop. Fix errors and rebuild until the build succeeds.

## Rules

1. Run `ng build` (or `nx build` if Nx workspace) and capture the output.
2. If the build succeeds, stop and report success.
3. If the build fails, read the error output carefully:
   - Identify the file, line number, and error message.
   - Read the file to understand the context.
   - Apply the minimal fix — do NOT refactor, do NOT improve surrounding code.
4. After fixing, rebuild immediately.
5. Repeat until the build is green.

## Safety Limits

- **Max 10 iterations.** If the build still fails after 10 rounds, stop and report the remaining errors to the user.
- **No circular fixes.** If you fix an error and it reappears in the next iteration, stop and report it — do not keep toggling the same fix.
- **Track progress.** Each iteration must reduce the error count. If the error count increases or stays the same for 2 consecutive iterations, stop and ask the user for guidance.
- **No destructive changes.** Do not delete files, remove features, or comment out code to make the build pass.

## Output

After each iteration, report:
```
Iteration X: [N errors] → [fix applied] → rebuilding...
```

On completion:
```
Build green after X iterations.
Files modified:
- path/to/file.ts (what was fixed)
```

Or on failure:
```
Stopped after X iterations. Y errors remaining:
- error 1
- error 2
Recommendation: [what the user should do]
```
