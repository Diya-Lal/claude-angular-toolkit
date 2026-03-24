---
name: nx-workspace
description: Always-on Nx monorepo patterns for Angular projects. Automatically applies correct Nx project structure, targets, affected commands, and cache configuration.
---

# Nx Workspace Patterns

## When to Activate
Always active when working in an Nx monorepo — any file under `apps/`, `libs/`, or `project.json` / `nx.json` changes.

## Core Concepts

### Project Structure
```
apps/
  shell/              # Host app (MFE shell or standalone)
  feature-a/          # Remote app or standalone app
libs/
  shared/
    ui/               # Shared Angular components
    data-access/      # Shared services, models
    util/             # Pure utility functions
```

### project.json Targets
Each app/lib has a `project.json` — always use named targets, never raw CLI commands:

```json
{
  "targets": {
    "build": {
      "executor": "@angular-devkit/build-angular:application",
      "options": { ... }
    },
    "serve": {
      "executor": "@angular-devkit/build-angular:dev-server",
      "configurations": {
        "development": { "buildTarget": "app:build:development" },
        "production": { "buildTarget": "app:build:production" }
      }
    },
    "test": {
      "executor": "@nx/jest:jest"
    },
    "lint": {
      "executor": "@nx/eslint:lint"
    }
  }
}
```

### Key Commands
```bash
# Run targets
nx serve <project>
nx build <project>
nx test <project>
nx lint <project>

# Run only affected projects (CI — fast)
nx affected -t build
nx affected -t test
nx affected -t lint

# Visualize dependency graph
nx graph

# Reset cache (use when phantom errors appear)
npm exec nx reset

# Generate new app/lib
nx g @nx/angular:app my-app
nx g @nx/angular:lib my-lib

# List all projects
nx show projects
```

### Nx Cache
- Nx caches build, test, and lint outputs by default
- **Always run `npm exec nx reset`** when you see errors that don't match source code
- Cache lives in `.nx/cache/` and `.angular/cache/` — both safe to delete
- Never commit `.nx/` or `.angular/` directories

### tsconfig Path Aliases
Nx auto-generates path aliases in `tsconfig.base.json` for libraries:
```json
{
  "paths": {
    "@myorg/shared-ui": ["libs/shared/ui/src/index.ts"],
    "destinations/Routes": ["apps/destinations/src/entry.routes.ts"]
  }
}
```
- Always import libs via path alias, never via relative `../../libs/...`
- After generating a new lib, verify its alias appears in `tsconfig.base.json`

### Module Resolution
- Root `tsconfig.base.json` must have `"moduleResolution": "bundler"` for PrimeNG and modern package exports
- Individual app `tsconfig.json` files should extend base and can override

### dependsOn in project.json
- Use `dependsOn` only when a target genuinely requires another to complete first
- **Avoid circular `dependsOn`** — e.g. two remotes both depending on shell:serve creates a lock conflict
- For MFE: start apps independently, don't use `dependsOn: ["shell:serve"]` on remotes

### Affected Commands in CI
```bash
# Only build/test what changed since main
nx affected -t build --base=main --head=HEAD
nx affected -t test --base=main --head=HEAD
```

### Adding a New App
```bash
nx g @nx/angular:app apps/my-app --standalone --routing
```
Then verify:
- `apps/my-app/project.json` created
- Path alias added to `tsconfig.base.json` if needed
- Root `package.json` lists Angular packages (required for MFE shared singleton config)
