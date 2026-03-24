---
name: primeng-v21
description: Always-on PrimeNG v21 correct API usage for Angular 21 projects. Prevents use of removed inputs, deprecated modules, and wrong import paths.
---

# PrimeNG v21 Patterns

## When to Activate
Always active when writing Angular code that imports or uses PrimeNG components.

## Critical Breaking Changes from Earlier Versions

### Import Standalone Components, NOT Modules
PrimeNG v17+ uses standalone components. The `*Module` pattern is removed or deprecated.

```typescript
// BAD — module pattern (removed in v21)
import { AutoCompleteModule } from 'primeng/autocomplete';
import { ButtonModule } from 'primeng/button';
import { TableModule } from 'primeng/table';

// GOOD — standalone component imports
import { AutoComplete, AutoCompleteCompleteEvent } from 'primeng/autocomplete';
import { Button } from 'primeng/button';
import { Table } from 'primeng/table';
```

### AutoComplete — Removed and Changed Inputs
```html
<!-- BAD: [field] was removed in v21 -->
<p-autocomplete [field]="'city'" />

<!-- BAD: [loading] is internal, not a public @Input -->
<p-autocomplete [loading]="isLoading" />

<!-- GOOD -->
<p-autocomplete
  optionLabel="city"
  [suggestions]="suggestions"
  (completeMethod)="onSearch($event)"
  [(ngModel)]="selectedCity"
/>
```

```typescript
// GOOD: correct event type
import { AutoComplete, AutoCompleteCompleteEvent } from 'primeng/autocomplete';

onSearch(event: AutoCompleteCompleteEvent) {
  this.suggestions = this.filter(event.query);
}
```

### Theming — @primeuix/themes Required
PrimeNG v21 uses the new design token system. Always configure via `providePrimeNG`:

```typescript
// app.config.ts
import { providePrimeNG } from 'primeng/config';
import Aura from '@primeuix/themes/aura';

export const appConfig: ApplicationConfig = {
  providers: [
    providePrimeNG({
      theme: { preset: Aura },
      ripple: true
    })
  ]
};
```

- Never use `primeng/resources/themes/` CSS file imports (old theming system)
- `@primeuix/themes` must be in root `package.json`

### MFE: providePrimeNG Must Be in Shell
In a Module Federation setup, `providePrimeNG` in a remote's `app.config.ts` has no effect when the remote is loaded by the shell. The shell's root injector is used.

```typescript
// apps/shell/src/app/app.config.ts — MUST have this
providers: [
  provideHttpClient(withFetch()),
  providePrimeNG({ ripple: true }),
  ...
]
```

### DecimalPipe / Number Pipe
The `| number` pipe requires explicit import in standalone components:
```typescript
import { DecimalPipe } from '@angular/common';

@Component({
  imports: [DecimalPipe, ...]
})
```

### Common Component Import Paths (v21)
| Component | Import Path |
|---|---|
| AutoComplete | `primeng/autocomplete` |
| Button | `primeng/button` |
| Table | `primeng/table` |
| InputText | `primeng/inputtext` |
| Dialog | `primeng/dialog` |
| Toast | `primeng/toast` |
| Card | `primeng/card` |
| Skeleton | `primeng/skeleton` |
| ProgressSpinner | `primeng/progressspinner` |
| Tag | `primeng/tag` |
| Chip | `primeng/chip` |
| Divider | `primeng/divider` |
| PrimeNG config | `primeng/config` |

### Version Compatibility
- PrimeNG 21.x requires Angular `~21.2.0` exactly
- All `@angular/*` packages must be `~21.2.0` — mismatched minor versions (e.g. `~21.1.0`) cause webpack build failures
- `@primeuix/themes` must be listed in root `package.json` for Nx MFE shared config
