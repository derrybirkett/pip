# Organism Registry

Inventory of projects that use pip as their genome (`.pip` submodule). Only actual pip organisms belong here — independent projects that don't consume pip are out of scope.

**Owner**: COO

## Why

Without a registry, agents have no way to answer:
- Which projects use pip as a submodule?
- Which fragments have been applied where?
- What's stale, what's active, what needs attention?
- When pip ships a new fragment, which organisms need upgrading?

The registry enables organism-level visibility, health monitoring, and upgrade coordination.

## Schema

Each organism entry in `organisms.yml` has these fields:

- **name** — Unique project identifier
- **path** — Local filesystem path (`~` expands to `$HOME`)
- **repo** — Remote repository URL (empty string if none)
- **type** — Classification: `saas`, `blog`, `design-system`, `tool`, `experiment`, `infra`
- **status** — Lifecycle stage: `active`, `experimental`, `archived`, `stub`
- **pip_submodule** — Whether `.pip` is embedded as a git submodule
- **fragments_applied** — List of pip fragments applied to this organism
- **last_activity** — ISO date of last known meaningful change
- **notes** — Free-text context for agents

## CLI Usage

```bash
# List all organisms
pip registry list

# Health check across all organisms
pip registry status

# Sync last_activity dates from git
pip registry sync
```

## Adding a New Organism

1. Add an entry to `registry/organisms.yml` following the schema above
2. Or use the interactive command: `pip registry add <name>`
3. Commit and push the registry update

## For Agents

When working on any organism, agents should:
1. Read the registry to understand the portfolio context
2. Check if the organism has pip as a submodule
3. Note which fragments have been applied
4. Update `last_activity` after significant work via `pip registry sync`

When working on pip itself, agents should:
1. Check if registry changes are needed (new fragment = update affected organisms)
2. Run `pip registry status` to identify organisms that may need attention
3. Use registry data to inform cross-project decisions
