---
name: mfe-patterns
description: Always-on Module Federation patterns for Angular + Nx MFE projects. Prevents the most common MFE runtime errors — async bootstrap, singleton sharing, circular dependsOn, and cross-framework loading.
---

# Module Federation Patterns (Angular + Nx)

## When to Activate
Always active when working in an Nx workspace with multiple apps using Webpack Module Federation (`@nx/angular:module-federation-*` executors or `module-federation.config.ts` files).

## Critical Rules

### 1. Async Bootstrap — All Apps
Every app (shell AND remotes) must use async bootstrap to allow Module Federation to resolve shared singletons before Angular starts.

```typescript
// main.ts — CORRECT pattern for all apps
import('./bootstrap').catch(err => console.error(err));

// bootstrap.ts
import { bootstrapApplication } from '@angular/platform-browser';
import { appConfig } from './app/app.config';
import { AppComponent } from './app/app.component';

bootstrapApplication(AppComponent, appConfig).catch(err => console.error(err));
```

**Never** bootstrap directly in `main.ts` — causes `Uncaught Error: Invalid loadShareSync` at runtime.

### 2. Angular Packages Must Be in Root package.json
Nx reads the **root** `package.json` to configure the MFE `shared` singleton map. If Angular packages are missing from root, each app bundles its own Angular → separate injection contexts → `NG0203` errors at runtime.

Root `package.json` must list:
```json
{
  "dependencies": {
    "@angular/core": "~21.2.0",
    "@angular/common": "~21.2.0",
    "@angular/router": "~21.2.0",
    "@angular/forms": "~21.2.0",
    "@angular/platform-browser": "~21.2.0",
    "@angular/compiler": "~21.2.0",
    "rxjs": "~7.x.x",
    "primeng": "~21.x.x",
    "@primeuix/themes": "~x.x.x",
    "tslib": "^x.x.x"
  }
}
```

Warning sign: `"Could not find a version for @angular/core in root package.json... will not be shared."`

### 3. Shell Must Provide All Root-Level Services
In MFE, the shell's root injector is shared across all remotes. Services marked `providedIn: 'root'` in a remote resolve from the **shell's** injector.

Shell `app.config.ts` must provide:
```typescript
providers: [
  provideHttpClient(withFetch()),   // required for remote HTTP services
  provideRouter(appRoutes),
  providePrimeNG({ ripple: true }), // required for PrimeNG in remotes
]
```

### 4. exposes Paths Must Use resolve()
In `module-federation.config.ts`, always use `resolve(__dirname, ...)` for exposed paths:

```typescript
// BAD
exposes: { './Routes': './src/entry.routes.ts' }

// GOOD
import { resolve } from 'path';
exposes: { './Routes': resolve(__dirname, 'src/entry.routes.ts') }
```

### 5. No circular dependsOn
Never add `dependsOn: ["shell:serve"]` to remote `project.json` serve targets. Starting a remote will start the shell, then starting the shell again creates a process lock conflict.

**Correct serve order** (independent, no dependsOn):
```bash
nx serve homepage    # port 4201
nx serve destinations # port 4202
nx serve shell       # port 4200 — start last
```

### 6. Shell tsconfig Must Use moduleResolution: bundler
Without this, PrimeNG and `@angular/common/http` imports fail in shell TypeScript compilation even though packages are installed.

```json
// apps/shell/tsconfig.json
{
  "compilerOptions": {
    "moduleResolution": "bundler",
    "module": "preserve"
  }
}
```

### 7. Cross-Framework (Angular Shell → React Remote)
Standard Webpack MFE loading fails at the CommonJS/ESM boundary when the shell uses `@module-federation/enhanced`.

**Working approach — script tag injection** (do not use MF remote config for cross-framework):
```typescript
// In Angular component
private loadReactRemote(el: HTMLElement) {
  const script = document.createElement('script');
  script.src = 'http://localhost:4204/remoteEntry.js';
  script.onload = () => {
    window['activities'].get('./mount').then((factory: any) => {
      const { mount } = factory();
      this.unmount = mount(el, city, lat, lon);
    });
  };
  document.head.appendChild(script);
}
```

**Do NOT** register cross-framework remotes in `module-federation.config.ts` — any MF loading will fail at the CommonJS/ESM boundary.

### 8. Stale Cache = Phantom Errors
After fixing source files, always clear caches if errors persist:
```bash
npm exec nx reset
rm -rf .angular/cache
```

Old Nx cache artifacts replay old errors even after files are fixed.

### 9. tsconfig Path Aliases for Remote Routes
Remote route entry points must be mapped in root `tsconfig.base.json`:
```json
{
  "paths": {
    "destinations/Routes": ["apps/destinations/src/entry.routes.ts"],
    "food/Routes": ["apps/food/src/entry.routes.ts"]
  }
}
```
Shell webpack compiles remote component code via these aliases — any import in a remote component (e.g. `primeng/autocomplete`) must be resolvable in the shell's TypeScript context.

## Port Conventions
| App | Remote Name | Port |
|---|---|---|
| shell | — | 4200 |
| homepage | homepage | 4201 |
| destinations | destinations | 4202 |
| food | food | 4203 |
| activities (React) | activities | 4204 |
