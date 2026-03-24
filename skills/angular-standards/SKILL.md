---
name: angular-standards
description: Always-on Angular coding standards for Angular 17+ projects. Automatically enforces OnPush, standalone components, signals, trackBy, and subscription hygiene without being asked.
---

# Angular Coding Standards

## When to Activate
Always active when writing or modifying Angular TypeScript or HTML template files.

## Core Standards

### Change Detection
- **Always** use `ChangeDetectionStrategy.OnPush` on every component — no exceptions
- Never use default change detection on new components

```typescript
@Component({
  selector: 'app-foo',
  standalone: true,
  changeDetection: ChangeDetectionStrategy.OnPush,
  ...
})
```

### Standalone Components
- All new components, pipes, and directives must be `standalone: true`
- Never create new NgModules unless migrating legacy code
- Import only what the component directly uses — never `CommonModule`

```typescript
// BAD
imports: [CommonModule]

// GOOD
imports: [NgIf, NgFor, AsyncPipe, DatePipe]

// BETTER (Angular 17+ control flow — no NgIf/NgFor needed)
// Use @if, @for, @switch in templates directly
```

### Signals over RxJS for State
- Use `signal()` for local component state
- Use `computed()` for derived values — never recalculate in template method calls
- Use `toSignal()` to consume observables in components
- Reserve RxJS for async streams (HTTP, WebSocket, complex operators)

```typescript
// BAD: method call in template recalculates every CD cycle
// template: {{ getFullName() }}

// GOOD: computed signal
firstName = signal('');
lastName = signal('');
fullName = computed(() => `${this.firstName()} ${this.lastName()}`);
// template: {{ fullName() }}
```

### Subscription Hygiene
- Never use raw `.subscribe()` without automatic cleanup
- Prefer `toSignal()` — zero boilerplate, auto-cleans
- When you must subscribe: use `takeUntilDestroyed(this.destroyRef)`
- Never use `ngOnDestroy` + Subject pattern for new code

```typescript
// BAD
ngOnInit() {
  this.service.data$.subscribe(d => this.items = d);
}

// GOOD
items = toSignal(this.service.data$, { initialValue: [] });
```

### Template Best Practices
- Always use `track` in `@for` / `trackBy` in `*ngFor`
- Never call methods in templates — use `computed()` or pure pipes
- Never create inline objects/arrays in template bindings

```html
<!-- BAD -->
<li *ngFor="let item of items">
@for (item of items; track $index)
{{ getLabel(item) }}
[config]="{ size: 'large' }"

<!-- GOOD -->
<li *ngFor="let item of items; trackBy: trackById">
@for (item of items; track item.id)
{{ item.label }}
[config]="cardConfig"
```

### Angular 17+ Control Flow
Prefer new control flow syntax over structural directives:
```html
@if (isLoading()) {
  <p-skeleton />
} @else if (items().length === 0) {
  <p>No results</p>
} @else {
  @for (item of items(); track item.id) {
    <app-item [data]="item" />
  }
}
```

### Injection
- Use `inject()` function over constructor injection for new code
- Inject `DestroyRef` for cleanup: `private destroyRef = inject(DestroyRef)`

```typescript
// GOOD
private router = inject(Router);
private destroyRef = inject(DestroyRef);
```

### HTTP
- Always type `HttpClient` calls: `this.http.get<City[]>(url)`
- Always handle errors with `catchError`
- Return `Observable` from services — let components decide when to subscribe

### File Structure
```
feature/
  components/        # Dumb/presentational — no service injection
  containers/        # Smart — inject services, pass data down
  services/
  models/
  feature.routes.ts
  index.ts           # Public API barrel
```

### Naming Conventions
- Selectors: `app-feature-name` (kebab-case)
- Component files: `feature-name.component.ts`
- Service files: `feature-name.service.ts`
- Signal variables: plain camelCase (`items`, `isLoading`)
- Observable variables: suffix with `$` (`items$`)
