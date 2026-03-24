# Claude Code — Global Configuration

This is a personal Claude Code setup scoped to **Angular + TypeScript frontend development**.
All agents, commands, and skills are Angular-specific. Do not apply backend, Node.js, or framework-agnostic patterns unless explicitly asked.

---

## Stack

- **Framework**: Angular 21.2.x (standalone components, signals, `OnPush`)
- **Monorepo**: Nx 22.5.4
- **UI Library**: PrimeNG 21.1.3 (standalone imports, `@primeuix/themes`)
- **Module Federation**: Webpack (`@nx/angular:module-federation-*`)
- **Language**: TypeScript strict mode
- **Package Manager**: npm
- **Testing**: Jasmine + Angular TestBed (unit), Cypress / Playwright (E2E)

---

## Agents

Located in `~/.claude/agents/`. Use these proactively — delegate to the right specialist instead of doing everything inline.

| Agent | When to Invoke |
|---|---|
| `architect` | Planning component/module structure, state management decisions, lazy loading strategy |
| `build-error-resolver` | `ng build` / `nx build` / `tsc` fails — fix with minimal diffs, no refactoring |
| `code-reviewer` | After writing or modifying any Angular/TypeScript code |
| `planner` | Before starting any feature, refactor, or architectural change |
| `refactor-cleaner` | Removing dead code, unused constructs, duplicate components |
| `security-reviewer` | Before releases, after auth/input/routing changes, after dependency updates |
| `tdd-guide` | Writing new components, services, pipes, or guards — always test-first |
| `typescript-reviewer` | Deep type-safety and Angular idiom review on any TS/HTML changes |

---

## Commands

Type `/` in Claude Code to autocomplete. Each command delegates to its agent.

| Command | Agent | Purpose |
|---|---|---|
| `/plan` | `planner` | Implementation plan for a feature or refactor |
| `/architect` | `architect` | Architecture design or review |
| `/review` | `code-reviewer` | Code quality, security, Angular best practices |
| `/ts-review` | `typescript-reviewer` | Type safety + Angular idiom deep review |
| `/build-fix` | `build-error-resolver` | Fix build/type errors |
| `/refactor` | `refactor-cleaner` | Dead code and duplicate cleanup |
| `/security` | `security-reviewer` | Security vulnerability scan |
| `/tdd` | `tdd-guide` | Test-driven development workflow |

---

## Skills

Always-on — applied automatically while writing code without being asked.

| Skill | What it Enforces |
|---|---|
| `angular-standards` | `OnPush` everywhere, standalone, signals, `toSignal()`, `trackBy`, no method calls in templates |
| `nx-workspace` | Nx targets, affected commands, cache reset, path aliases, `dependsOn` rules |
| `primeng-v21` | Correct PrimeNG 21 imports, removed inputs, theming setup, MFE provider placement |
| `mfe-patterns` | Async bootstrap, singleton sharing, shell providers, cross-framework loading via script tag |

---

## Core Coding Rules

These apply to all code written in any project:

1. **Always `OnPush`** — every new component gets `ChangeDetectionStrategy.OnPush`
2. **Always standalone** — no new NgModules; import only what the component uses
3. **Signals for state** — `signal()`, `computed()`, `toSignal()` over RxJS BehaviorSubjects for local/shared state
4. **No subscription leaks** — `toSignal()` first, `takeUntilDestroyed()` when manual subscribe is needed
5. **No method calls in templates** — use `computed()` or pure pipes instead
6. **Typed HTTP** — always `this.http.get<MyType>(url)`, never untyped
7. **trackBy / track always** — on every `*ngFor` / `@for` with dynamic data
8. **Lazy load all feature routes** — `loadComponent` / `loadChildren` on every feature route
9. **No `any`** — use `unknown` and narrow, or define the type
10. **No `rm -rf`, no force push, no `--no-verify`** — guarded by permissions in `settings.json`

---

## Permissions

Defined in `settings.json`. The following are permanently blocked — Claude will not execute these without manual override:

- `git push --force`, `git reset --hard`, `git branch -D`, `git checkout -- *`, `git clean -f`
- `npm publish`, `ng deploy`, `nx deploy`
- `rm -rf`
- Overwriting `angular.json`, `tsconfig*.json`, `package.json`
- Overwriting files in `~/.claude/agents/` or `~/.claude/commands/`

---

## MFE-Specific Rules

When working in a Module Federation workspace:

- All apps (shell + remotes) must use async bootstrap (`main.ts` → `import('./bootstrap')`)
- Shell `app.config.ts` must provide `provideHttpClient(withFetch())` and `providePrimeNG()`
- Angular packages must be listed in **root** `package.json` for singleton sharing
- Never add `dependsOn: ["shell:serve"]` to remote serve targets
- Cross-framework remotes (React): load via script tag, do NOT register in `module-federation.config.ts`
- Run `npm exec nx reset && rm -rf .angular/cache` when phantom errors appear after correct fixes

---

## Repo

This config is versioned at: `https://github.com/Diya-Lal/claude-angular-toolkit`
