# claude-angular-toolkit

Personal Claude Code configuration — Angular/TypeScript frontend agents and slash commands.

All agents and commands are scoped to **Angular + TypeScript** frontend development. No backend, no framework-agnostic generics.

---

## Agents

Located in `agents/`. Automatically available to Claude Code as subagents.

| Agent | Description |
|---|---|
| `architect` | Design or review Angular app architecture — component structure, state management, lazy loading, module boundaries |
| `build-error-resolver` | Fix `ng build` / `nx build` / `tsc` errors with minimal diffs — no refactoring |
| `code-reviewer` | Review Angular/TypeScript code for quality, security, and Angular best practices |
| `planner` | Create detailed, phase-by-phase implementation plans for Angular features and refactors |
| `refactor-cleaner` | Remove dead code, unused components/services/pipes, and duplicate constructs |
| `security-reviewer` | Detect XSS, insecure token storage, missing route guards, hardcoded secrets, and vulnerable dependencies |
| `tdd-guide` | Guide TDD Red-Green-Refactor cycle using Angular `TestBed`, Jasmine, and `fakeAsync` |
| `typescript-reviewer` | Deep type-safety and Angular idiom review — `any`, async correctness, template type-checking |

---

## Commands

Located in `commands/`. Type `/` in Claude Code to autocomplete.

| Command | Invokes Agent | When to Use |
|---|---|---|
| `/plan` | `planner` | Before starting any feature or refactor |
| `/architect` | `architect` | Designing component/module structure, state strategy |
| `/review` | `code-reviewer` | After writing or changing any Angular code |
| `/ts-review` | `typescript-reviewer` | Deep type-safety + Angular idiom review |
| `/build-fix` | `build-error-resolver` | When `ng build` / `nx build` / `tsc` fails |
| `/refactor` | `refactor-cleaner` | Cleaning up dead code, unused constructs |
| `/security` | `security-reviewer` | Before releasing, after auth/input changes |
| `/tdd` | `tdd-guide` | Writing new components/services test-first |

---

## Stack

- Angular 17+ (standalone components, signals, `OnPush`)
- TypeScript strict mode
- Nx monorepo
- PrimeNG
- Jasmine / TestBed for unit tests
- Cypress / Playwright for E2E

---

## Setup

Clone into your home directory:

```bash
git clone https://github.com/Diya-Lal/claude-angular-toolkit.git ~/.claude
```

> If you already have a `~/.claude/` directory, clone elsewhere and copy `agents/` and `commands/` into it manually.

---

## What's Excluded

The following are git-ignored as they are runtime/sensitive:

- `cache/`, `backups/`, `debug/`, `session-env/` — machine-specific runtime files
- `history.jsonl` — full conversation history
- `projects/` — per-project memory (may contain sensitive context)
