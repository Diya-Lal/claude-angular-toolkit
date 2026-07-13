---
description: Run ng test in a loop — fix failing tests and re-run until all pass. Stops after 10 iterations or on success.
allowed_tools: ["Read", "Edit", "Write", "Bash", "Grep", "Glob"]
---

Run a self-correcting test loop. Fix failing tests and re-run until all pass.

## Rules

1. Run `npx ng test --watch=false --browsers=ChromeHeadless` (or the project's test command) and capture the output.
2. If all tests pass, stop and report success.
3. If tests fail:
   - Read the failure output — identify the spec file, test name, and error.
   - Read both the spec file AND the source file under test.
   - Determine if the failure is in the test or the source code:
     - **Test is wrong** (outdated mock, wrong expectation, missing provider) → fix the test.
     - **Source code is wrong** (bug causing test failure) → fix the source code.
   - Apply the minimal fix.
4. After fixing, re-run tests immediately.
5. Repeat until all tests pass.

## Safety Limits

- **Max 10 iterations.** If tests still fail after 10 rounds, stop and report remaining failures.
- **No circular fixes.** If a test starts failing again after being fixed, stop and report the cycle.
- **Track progress.** Each iteration must reduce the failure count. If it increases or stays the same for 2 consecutive iterations, stop and ask the user.
- **No skipping.** Do NOT add `xit`, `xdescribe`, `pending()`, or `.skip` to make tests pass.
- **No deleting tests.** Do NOT remove test cases to reduce failures.
- **Preserve test intent.** If a test expectation looks intentional, fix the source code, not the test. When in doubt, ask the user.

## Output

After each iteration, report:
```
Iteration X: [N failing] → [fix applied to file:line] → re-running...
```

On completion:
```
All tests passing after X iterations.
Files modified:
- path/to/file.ts (what was fixed)
- path/to/file.spec.ts (what was fixed)
```

Or on failure:
```
Stopped after X iterations. Y tests still failing:
- test name (file:line) — reason
Recommendation: [what the user should do]
```
