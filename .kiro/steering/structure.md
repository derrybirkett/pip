# Project Structure

## Directory Organization

```
.pip/
├── mission/                   # Project purpose and vision
│   └── mission.md
├── method/                    # Delivery process
│   └── delivery-method.md
├── graph/                     # Product surface maps
│   ├── product-app.md
│   ├── marketing-website.md
│   └── blog.md
├── ia/                        # Information architecture
│   ├── agent_manifest.yml     # All agents summary
│   └── agents/                # Per-agent documentation
│       ├── ceo/
│       ├── cto/
│       ├── cpo/
│       ├── ciso/
│       ├── cmo/
│       └── cro/
├── fragments/                 # Reusable project scaffolds
│   └── nx-dev-infra/
│       ├── README.md
│       └── files/
├── bin/                       # Apply scripts for fragments
│   └── apply-nx-dev-infra.sh
└── docs/                      # Living documentation
    ├── activity-log.md        # Historical record (REQUIRED)
    ├── changelog.md           # User-facing release notes
    ├── fragments-guide.md
    ├── glossary.md
    ├── agents/                # Agent-specific docs
    ├── blog/                  # Blog posts
    ├── processes/             # Workflow guides
    ├── policies/              # Governance
    ├── templates/             # Reusable templates
    └── tools/                 # Tool guides
```

## Key Files

### Critical Documentation
- `docs/activity-log.md` - MUST be updated before merging to main
- `docs/changelog.md` - Update for user-facing changes
- `docs/processes/wrap-up-checklist.md` - Pre-merge checklist

### Entry Points
- `README.md` - Framework overview and getting started
- `INDEX.md` - Quick reference to all documentation
- `WARP.md` - Warp-specific AI agent guidance
- `fragment-prompt.md` - Universal AI agent entrypoint
- `CONTRIBUTING.md` - Branch naming, PR requirements, standards

### Configuration
- `.envrc.example` - Environment variable template
- `.envrc` - Actual secrets (gitignored)
- `ia/agent_manifest.yml` - Agent roles and owners

## Agent Documentation Structure

Each agent has:
- `role.md` - Scope, decision rights, interfaces
- `responsibilities.md` - Detailed responsibilities
- Additional docs as needed (e.g., CTO has tech-stack/ subdirectory)

## Fragments Structure

Each fragment contains:
- `README.md` - Documentation and usage
- `files/` - Files to copy into projects
- Apply script in `bin/apply-<fragment-name>.sh`

## Conventions

- All documentation in Markdown
- Keep docs concise and actionable
- Reference related docs with relative paths
- Use YAML for structured data (agent_manifest.yml)
- Shell scripts in `bin/` for automation
