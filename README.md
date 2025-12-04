# .pip — Project Intelligence & Process

This directory contains the operational system for your project: mission, methods, agents, and documentation.

## What is .pip?

`.pip` is a lightweight framework for AI-assisted development that provides:
- **Clear mission and method** for consistent decision-making
- **Agent-based governance** with defined roles and responsibilities
- **Process templates** for delivery, documentation, and collaboration
- **Project graphs** mapping key surfaces and flows
- **Reusable fragments** for bootstrapping new projects with consistent infrastructure

## Directory Structure

```
.pip/
├── README.md                  # This file
├── CONTRIBUTING.md            # How to contribute and collaborate
├── fragment-prompt.md         # Universal AI agent entrypoint
├── WARP.md                   # Warp-specific AI agent guidance
├── INDEX.md                  # Quick reference to all documentation
├── mission/                   # Why this project exists
│   └── mission.md            # Problem, solution, vision, outcomes
├── method/                    # How we deliver
│   └── delivery-method.md    # Discovery → build → ship process
├── graph/                     # What we're building
│   ├── product-app.md        # Core product flows
│   ├── marketing-website.md  # Marketing site structure
│   └── blog.md               # Blog purpose and strategy
├── ia/                        # Information architecture
│   ├── agent_manifest.yml    # Agent roles summary
│   └── agents/               # Detailed agent documentation
│       ├── ceo/
│       ├── cto/
│       ├── cpo/
│       ├── ciso/
│       ├── cmo/
│       └── cro/
├── fragments/                 # Reusable project scaffolds
│   └── nx-dev-infra/         # Nx + Docker + Postgres + n8n
│       ├── README.md         # Fragment documentation
│       └── files/            # Files to copy into projects
├── bin/                       # Apply scripts for fragments
│   ├── bootstrap-project.sh  # Interactive project setup
│   └── apply-nx-dev-infra.sh # Script to apply nx-dev-infra
└── docs/                      # Living documentation
    ├── activity-log.md       # Historical record of changes
    ├── changelog.md          # User-facing release notes
    ├── fragments-guide.md    # How to use fragments system
    ├── glossary.md           # Terms and definitions
    ├── blog/                 # Blog posts and content
    ├── processes/            # Workflow guides
    ├── policies/             # Governance and compliance
    ├── templates/            # Reusable templates
    └── tools/                # Tool guides and integrations
```

## The Genome/Organism Model

**Important:** Think of `.pip` as **DNA/genome** — an immutable template that provides instructions.

Your project is the **organism** that expresses those instructions:
- **`.pip/` (Genome)** = Immutable template (DO NOT MODIFY)
- **`docs/` in your project** = Your actual documentation (modify freely)

### Quick Setup (Recommended)

**Interactive Bootstrap** - Answer a few questions and get personalized documentation:

```bash
# In your new project
git init
git submodule add https://github.com/derrybirkett/pip.git .pip

# Run interactive bootstrap
./.pip/bin/bootstrap-project.sh
```

The script will ask about your project and generate:
- Mission statement based on your user story
- README with your project description  
- Activity log and changelog templates
- All customized for your specific project

### Manual Setup (Advanced)

If you prefer to set up manually:

```bash
# Add .pip as submodule
git submodule add https://github.com/derrybirkett/pip.git .pip

# Bootstrap your documentation
mkdir -p docs
cp .pip/docs/activity-log.md docs/
cp .pip/docs/changelog.md docs/
cp .pip/mission/mission.md docs/mission.md

# Edit these files for YOUR project
```

**See [Using .pip as Genome](./docs/using-pip-as-genome.md) for detailed guidance.**

## Getting Started

### 0. Environment Setup
This repository uses [direnv](https://direnv.net/) for environment variable management:
```bash
# Install direnv (if not already installed)
brew install direnv  # macOS

# Copy the example env file
cp .envrc.example .envrc

# Add your secrets to .envrc (it's gitignored)
vim .envrc

# Allow direnv to load the environment
direnv allow
```

### 1. Customize Mission
Edit `mission/mission.md` to define:
- Who you're serving
- What problem you're solving
- Your unique solution and vision

### 2. Configure Agents
Review `ia/agent_manifest.yml` and update:
- Owner assignments
- Responsibility boundaries
- Documentation paths

### 3. Define Your Product
Update the graph files:
- `graph/product-app.md` — Core product flows
- `graph/marketing-website.md` — Marketing structure
- `graph/blog.md` — Content strategy

### 4. Set Up Processes
Customize `method/delivery-method.md` for your delivery approach.

### 5. Use Fragments (Optional)
Bootstrap new projects with reusable infrastructure scaffolds:
```bash
# In your new project
git submodule add git@github.com:derrybirkett/pip.git .pip
./.pip/bin/apply-nx-dev-infra.sh
```

See [Fragments Guide](./docs/fragments-guide.md) for more.

## Key Concepts

### Agents
This system uses a C-suite agent model:
- **CEO**: Mission, strategy, cross-functional decisions
- **CTO**: Technical architecture and delivery
- **CPO**: Product roadmap and outcomes
- **CISO**: Security, risk, compliance
- **CMO**: Messaging, content, marketing
- **CRO**: Revenue, pricing, growth

Each agent has defined decision rights and interfaces.

### Activity Log
`docs/activity-log.md` tracks what changed, when, and why. Update it before merging to main.

### Changelog
`docs/changelog.md` is user-facing release notes. Update it as part of your wrap-up process.

### Graph
"Graph" refers to the interconnected surfaces you're building (product, marketing, blog). Each graph file maps key flows and requirements.

### Fragments
Fragments are reusable project scaffolds (Docker configs, Nx setups, etc.) that you can inject into new projects for consistent infrastructure.

## Contributing

See `CONTRIBUTING.md` for:
- Branch naming conventions
- PR requirements and approvals
- Code standards and automation

## Using with AI Agents

This structure is optimized for AI-assisted development across multiple AI platforms:

**Quick Start**: Point your AI agent to `fragment-prompt.md` — a universal entrypoint file that works with:
- ChatGPT Projects
- Claude Projects
- Cursor Composer
- Warp Agent Mode
- n8n workflows

### How It Works
1. AI agents can reference role docs to understand decision authority
2. Templates provide consistent formats for discovery and delivery
3. Activity logs help agents understand project history
4. Process docs guide agents through workflows

### Platform-Specific Guidance
- **Warp**: Automatically reads `WARP.md`
- **ChatGPT/Claude/Cursor**: Reference `fragment-prompt.md` in project instructions
- **n8n**: Add "Read File" node pointing to `fragment-prompt.md`

## Adapting for Your Project

This is a template. Remove what you don't need:
- Working on a library, not a product? Remove `graph/product-app.md`
- No marketing site? Remove `graph/marketing-website.md`
- Don't need all C-suite roles? Remove unused agent directories

Keep what provides value for your specific context.
