# Tech Stack

## Monorepo & Tooling
- Nx monorepo strategy
- Package/task orchestration and caching

## UI
- **ShadCN UI** - Accessible React component library built on Radix UI
  - Tailwind CSS for styling
  - Customizable design tokens via CSS variables
  - Components: Button, Input, and extensible catalog
- Design tokens and theming

## Backend/Data
- Postgres / Supabase
- Consider Redis (caching/queues) and GraphQL where needed

## Testing
- **Playwright** for E2E testing
  - Cross-browser testing (Chromium, Firefox, WebKit)
  - Complete user flow testing
  - Template includes marketing → login → app → logout flow
- Unit/integration with project-preferred frameworks (Vitest)

## Payments
- Stripe for payments and billing

## Operations
- Dockerized services and dev environment
- Observability: logs, metrics, tracing

## Best Practices
- Security by default, least privilege
- Performance budgets and SLOs
- Feature flags for safe rollouts

