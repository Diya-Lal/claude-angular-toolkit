# Claude Code Angular Toolkit — Reference Guide

## Agents

Agents are the specialists that do the actual work. You don't invoke them directly — commands and orchestrators delegate to them.

| Agent | Role |
|---|---|
| `researcher` | Web/docs research, library evaluation, migration paths |
| `planner` | Angular-specific implementation planning |
| `planner-generic` | Stack-agnostic planning fallback |
| `architect` | Component structure, state management, module boundaries |
| `code-reviewer` | Code quality, Angular patterns, best practices |
| `typescript-reviewer` | Type safety, `any` usage, casts, async patterns |
| `security-reviewer` | XSS, auth, token storage, secrets, route guards |
| `accessibility-reviewer` | WCAG 2.2 AA, ARIA, keyboard nav, focus management |
| `performance-reviewer` | Bundle size, CD thrashing, memory leaks, template perf |
| `refactor-cleaner` | Dead code, duplicates, unused dependencies |
| `build-error-resolver` | Fix `ng build` / `tsc` failures with minimal diffs |
| `tdd-guide` | Test-driven development with Angular TestBed |
| `review-orchestrator` | Fans out to 7 review agents in parallel |

---

## Commands

Type `/` in Claude Code to autocomplete these.

| Command | Agent(s) | Purpose |
|---|---|---|
| `/research` | `researcher` | Research before you build — libs, APIs, patterns, migrations |
| `/plan` | `planner` | Create an implementation plan for a feature or refactor |
| `/architect` | `architect` | Design or review app architecture |
| `/review` | `code-reviewer` | Quick code quality review on recent changes |
| `/full-review` | `review-orchestrator` → 7 agents | Comprehensive review across all dimensions (parallel) |
| `/ts-review` | `typescript-reviewer` | Deep TypeScript & type safety review |
| `/security` | `security-reviewer` | Security vulnerability scan |
| `/refactor` | `refactor-cleaner` | Find and remove dead code & duplicates |
| `/build-fix` | `build-error-resolver` | Fix build errors with minimal changes |
| `/tdd` | `tdd-guide` | Write tests first, then implement |
| `/research-claude-repo` | — | Research a Claude-related GitHub repo |

---

## Always-On Skills

These apply automatically while writing code — no command needed.

| Skill | What it Enforces |
|---|---|
| `angular-standards` | OnPush, standalone, signals, trackBy, no method calls in templates |
| `nx-workspace` | Nx targets, affected commands, cache, path aliases |
| `primeng-v21` | Correct PrimeNG 21 imports, removed inputs, theming |
| `mfe-patterns` | Async bootstrap, singleton sharing, shell providers |

---

## /full-review — Multi-Agent Orchestrator

A single command that spins up 7 specialist agents in parallel for a comprehensive review.

| # | Agent | Focus |
|---|---|---|
| 1 | Architecture | Component structure, module boundaries, lazy loading, state management |
| 2 | Code Quality | OnPush, subscriptions, Angular patterns, dead code, missing tests |
| 3 | Security | XSS, auth, token storage, route guards, secrets, npm audit |
| 4 | Accessibility | WCAG 2.2 AA, ARIA, keyboard nav, focus management, form labels |
| 5 | TypeScript | Type safety, `any` usage, casts, untyped HTTP, async handling |
| 6 | Performance | Bundle size, CD thrashing, memory leaks, lazy loading, template perf |
| 7 | Refactoring | Dead code, duplicates, large components, consolidation opportunities |

Results consolidate into a unified report with a final verdict: **APPROVE / WARNING / BLOCK**.

---

## Workflows

### Starting a New Feature

```
/research    →  Investigate libraries, APIs, patterns
/plan        →  Create step-by-step implementation plan
/architect   →  Design component tree, state, routing
                Start coding (always-on skills enforce standards)
/tdd         →  Write tests first for each component/service
```

### During Development

```
/build-fix   →  When ng build or tsc fails
/review      →  Quick check after writing code
/ts-review   →  Deep dive on type safety
```

### Before Merging / Releasing

```
/full-review →  7 parallel agents review everything at once
                Outputs a unified report with APPROVE / WARNING / BLOCK verdict
```

### Maintenance

```
/refactor    →  Clean up dead code and duplicates
/security    →  Scan after dependency updates or auth changes
```

---

## Quick Decision Guide

| Situation | Use |
|---|---|
| "What library should I use for X?" | `/research` |
| "How should I structure this feature?" | `/plan` then `/architect` |
| "Is my code good?" | `/review` |
| "Is it ready to merge?" | `/full-review` |
| "Build is broken" | `/build-fix` |
| "Codebase feels messy" | `/refactor` |
| "Are there security issues?" | `/security` |
| "Are my types correct?" | `/ts-review` |
| "I want to write tests first" | `/tdd` |
