# Technical Stack & Conventions

## Repository Type

Pure documentation repository - Markdown files only, no application code.

## Tech Stack (for projects using .pip)

### Monorepo & Tooling
- Nx monorepo strategy
- Package/task orchestration and caching

### UI
- ShadCN UI components
- Design tokens and theming

### Backend/Data
- Postgres / Supabase
- Redis (caching/queues) where needed
- GraphQL where appropriate

### Testing
- Playwright for E2E testing (preferred)
- Unit/integration tests: 80%+ coverage for business logic

### Payments
- Stripe for payments and billing

### Operations
- Dockerized services and dev environment
- direnv for environment variable management
- Observability: logs, metrics, tracing

## Common Commands

### Environment Setup
```bash
# Install direnv
brew install direnv

# Copy example env file
cp .envrc.example .envrc

# Edit with your secrets
vim .envrc

# Allow direnv to load
direnv allow
```

### Using Fragments
```bash
# Add .pip as submodule
git submodule add git@github.com:derrybirkett/pip.git .pip

# Apply infrastructure fragment
./.pip/bin/apply-nx-dev-infra.sh

# Start development environment
nx run infra:up
docker exec -it monospace-dev bash
```

### Git Workflow
```bash
# Start new work
git checkout main && git pull origin main
git checkout -b feat/your-feature

# Complete work
git add .
git commit -m "feat: description"
git push origin feat/your-feature
# Create PR, get approval, merge
```

### Release Process
```bash
# Update changelog
vim docs/changelog.md

# Commit and tag
git add docs/changelog.md
git commit -m "chore: prepare vX.Y.Z release"
git push origin main
git tag -a vX.Y.Z -m "Release description"
git push --tags
```

## Best Practices

- Security by default, least privilege
- Performance budgets and SLOs
- Feature flags for safe rollouts
- Never commit secrets - use environment variables
- All changes via feature branches (never commit directly to main)
