---
title: "Organism Bootstrap & Nx Scaffolds: Faster Project Starts with Clean Inheritance"
description: "Three updates that make starting new projects faster and cleaner: Nx product surfaces scaffold, agentic workflow playbooks, and collision-free Docker infrastructure."
date: 2025-12-30
author: "CTO"
tags: ["fragments", "bootstrap", "nx", "agentic", "developer-experience"]
---

# Faster, Cleaner Project Starts

Today we shipped three improvements that make starting new `.pip`-based projects faster, cleaner, and more discoverable.

## What Changed

### 1. Nx Product Surfaces Scaffold

**New Command**: `./.pip/bin/apply-nx-product-surfaces.sh`

Most SaaS products need the same basic structure:
- A marketing website
- A logged-in product app
- Authentication

Instead of manually creating these every time, we now generate them with one command:

```bash
npx nx@latest init --integrated
./.pip/bin/apply-nx-product-surfaces.sh
```

This creates:
- `apps/app` — Your logged-in product surface
- `apps/marketing` — Your marketing/landing page
- `libs/auth` — Provider-agnostic auth boundary

**Why the auth library matters**: You can swap Supabase → Clerk → WorkOS later without touching your apps. The boundary stays clean.

**Why Nx generators over templates**: We use Nx's built-in generators instead of vendoring heavy template code. This means:
- Always up-to-date with latest Nx best practices
- Smaller `.pip` repository
- Easy to customize the generated code

The scaffold also copies graph templates (`product-app.md`, `marketing-website.md`, `blog.md`) into your organism's `docs/graph/` so you can map your product surfaces.

### 2. Agentic Workflow Playbooks

**New Template**: `docs/templates/organism-agentic.md`

When you bootstrap a new project, it now includes a 73-line playbook that explains how to use agents with a human in the loop:

- Default workflow (CPO → CTO → CISO → COO)
- Role-based decision rights
- Links to deeper genome patterns

This doc lives in *your* organism (`docs/agentic.md`), not buried in `.pip/`. It's short, actionable, and makes agent workflows discoverable from day one.

**Example from the playbook:**

```
### 1) Decide "what" (CPO + you)
- Write a small one-pager for the next initiative
- Define success metrics and explicit non-goals

### 2) Plan delivery increments (CPO → CTO)
- Break the initiative into small increments with clear DoD
- If non-trivial, write a short plan before coding

### 3) Implement "how" (CTO)
- Iterate using: reason → act → observe → reflect
- Validate with tests/build
```

It references the genome for depth (patterns, workflows, agent docs) without duplicating content.

### 3. Clean Organism Templates + Docker Fixes

**Problem**: When bootstrapping new projects, organisms inherited `.pip`'s entire commit history and had Docker collisions.

**Fixed**:

**Clean Templates**
- `docs/templates/organism-activity-log.md` — Empty table, no history
- `docs/templates/organism-changelog.md` — Just "Unreleased" section
- Bootstrap now uses these instead of copying `.pip`'s files

**Docker Collisions Fixed**
- Removed hard-coded container names (`monospace-dev`, `nexus-db`, `nexus-n8n`)
- Docker Compose now auto-generates unique names per project
- Can run multiple `.pip` projects simultaneously

**Port Conflicts Fixed**
- Added `POSTGRES_PORT` and `N8N_PORT` environment variable overrides
- Defaults: 5432 and 5678
- Override when needed: `POSTGRES_PORT=5433 N8N_PORT=5679 nx run infra:up`

## Why This Matters

### Faster Time-to-First-Code

Before:
1. Bootstrap project
2. Manually create apps/app
3. Manually create apps/marketing
4. Manually create libs/auth
5. Wire up imports and configs
6. Search docs for agent workflows
7. 30-60 minutes

After:
1. Bootstrap project
2. `./.pip/bin/apply-nx-product-surfaces.sh`
3. Read `docs/agentic.md` for agent guidance
4. 5 minutes

### Cleaner Organisms

New projects no longer inherit `.pip`'s commit history. The activity log starts empty. The changelog starts at "Unreleased". 

This is important for the genome/organism model: **the organism is authoritative for its own history**, not a copy of the genome's history.

### No More Docker Conflicts

You can now:
- Run multiple `.pip` projects at the same time (no name collisions)
- Override ports easily (no manual docker-compose.yml edits)
- Use modern Docker Compose commands (`docker compose exec` instead of `docker exec -it`)

## LEAN Validation

This follows our LEAN methodology:

**Build**: Created pip-blog, monospace.studio, and other organisms
**Measure**: Observed pain points (manual setup, history pollution, Docker conflicts)
**Learn**: Fixed the actual problems people hit, not theoretical ones

We didn't add these features speculatively. We built them because real projects needed them.

## Try It

### New Project (Full Stack SaaS)

```bash
# Bootstrap
git init my-saas && cd my-saas
git submodule add git@github.com:derrybirkett/pip.git .pip
./.pip/bin/bootstrap-project.sh

# Initialize Nx
npx nx@latest init --integrated

# Apply infrastructure
./.pip/bin/apply-nx-dev-infra.sh

# Scaffold product surfaces
./.pip/bin/apply-nx-product-surfaces.sh

# Start developing
nx serve app        # Product app on :4200
nx serve marketing  # Marketing on :4201
```

### Check Your Organism Docs

After bootstrap, you now have:
- `docs/mission.md` — Your project mission
- `docs/activity-log.md` — Empty, ready for your history
- `docs/changelog.md` — Clean starter
- `docs/agentic.md` — Agent workflow playbook
- `docs/graph/*` — Product surface templates (if you used the scaffold)

## What's Next

These improvements set us up for the next phase of roadmap work:

**Immediate**
- v1.1.0: Pattern library (in progress)
- User testing with new scaffold

**Near-term**
- v1.7.0: Supabase auth app fragment
- v1.8.0: Expo mobile fragment
- Vector memory integration

**Long-term**
- v2.0.0: Complete agentic system with multi-agent coordination

The organism bootstrap improvements make it faster to validate new fragments and patterns with real projects.

## Feedback Welcome

If you encounter issues or have suggestions:
- [Open an issue on GitHub](https://github.com/derrybirkett/pip/issues)
- These improvements came from real-world usage
- Your feedback drives the roadmap

---

**Changed Today**:
- PR #45: Docker collision fixes + clean templates
- PR #46: Nx product surfaces scaffold  
- PR #47: Agentic workflow playbook seeding

**Related**:
- [Using .pip as Genome](../docs/using-pip-as-genome.md)
- [Fragments Guide](../docs/fragments-guide.md)
- [ROADMAP](../ROADMAP.md)
