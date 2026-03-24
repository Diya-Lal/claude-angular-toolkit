---
description: Write tests first (TDD) for Angular components, services, pipes, guards, or directives. Guides through Red-Green-Refactor with Angular TestBed.
allowed_tools: ["Read", "Write", "Edit", "Bash", "Grep"]
---

Invoke the `tdd-guide` agent.

Follow the Angular TDD Red-Green-Refactor cycle:

1. **RED** — Write a failing spec using Angular `TestBed` that describes the expected behaviour. Run `ng test --watch=false` and confirm it fails.
2. **GREEN** — Write the minimal Angular implementation (component/service/pipe/guard) to make the test pass. Run `ng test --watch=false` and confirm it passes.
3. **REFACTOR** — Improve the implementation (add `OnPush`, use signals, clean up) while keeping tests green.
4. **COVERAGE** — Run `ng test --code-coverage --watch=false` and confirm 80%+ branches, functions, lines, statements.

Always test: happy path, empty/null inputs, error paths (HTTP errors, empty arrays), loading states, and OnPush change detection behaviour.

Mock all external services with `jasmine.createSpyObj` or `provideHttpClientTesting`. Never hit real HTTP in unit tests.
