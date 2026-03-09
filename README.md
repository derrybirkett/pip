# .pip — Project Intelligence & Process

**Information architecture and governance framework for AI-assisted development.**

> **For project scaffolding and tooling, see [hatch](https://github.com/derrybirkett/hatch)**

## What is .pip?

`.pip` is a pure information layer that provides the governance foundation for AI-assisted development:

- **Mission & Method** — Strategic framework for consistent decision-making
- **Agent-Based Governance** — Defined roles (CEO, CTO, CPO, CISO, CMO, CRO, COO) with clear responsibilities
- **Agentic Design Patterns** — Formal patterns for ReAct, Planning, Reflection, Tool Use, Multi-Agent Collaboration
- **Process Templates** — Delivery methodology, documentation standards, wrap-up checklists
- **Autonomous Agent System** — AI-powered roadmap implementation with quality metrics
- **Project Graphs** — Information architecture mapping for key surfaces and flows

## v3 Breaking Change: Tooling Extracted

As of v3.0, all executable tooling (fragments, bootstrap scripts, CLI) has been extracted to **[hatch](https://github.com/derrybirkett/hatch)**.

`.pip` is now a **pure information layer** — governance, patterns, and documentation only.

## Directory Structure

```
.pip/
├── README.md                  # This file
├── CONTRIBUTING.md            # How to contribute
├── AGENTS.md                  # Repository guidelines for AI agents
├── fragment-prompt.md         # Universal AI agent entrypoint
├── WARP.md                   # Warp-specific AI agent guidance
├── ROADMAP.md                # Strategic roadmap
├── mission/                   # Why this exists
│   └── mission.md            # Problem, solution, vision, outcomes
├── method/                    # How we deliver
│   └── delivery-method.md    # Discovery → build → ship process
├── graph/                     # Information architecture
│   ├── product-app.md        # Core product flows
│   ├── marketing-website.md  # Marketing site structure
│   └── blog.md               # Blog purpose and strategy
├── ia/                        # Governance structure
│   ├── agent_manifest.yml    # Agent roles summary
│   └── agents/               # Detailed agent documentation
│       ├── ceo/              # Mission & strategy
│       ├── cto/              # Architecture & quality
│       ├── cpo/              # Roadmap & scope
│       ├── ciso/             # Security & risk
│       ├── cmo/              # Marketing & messaging
│       ├── cro/              # Revenue & growth
│       └── coo/              # Operations & delivery
├── patterns/                  # Agentic design patterns
│   └── agent-workflows/      # Formal workflow patterns
└── docs/                      # Living documentation
    ├── activity-log.md       # Historical record
    ├── changelog.md          # Release notes
    ├── glossary.md           # Terms and definitions
    ├── blog/                 # Blog posts
    ├── processes/            # Workflow guides
    ├── policies/             # Governance policies
    └── tools/                # Tool guides
```

## How to Use .pip

`.pip` is designed to be referenced as information architecture, not executed. Use it to:

1. **Define agent roles and responsibilities** — Reference `ia/agents/` for governance structure
2. **Apply agentic design patterns** — Study `patterns/agent-workflows/` for formal patterns
3. **Follow delivery methodology** — Use `method/delivery-method.md` for process guidance
4. **Understand project structure** — Review `graph/` for information architecture

**For executable tooling** (bootstrapping, scaffolding, automation), see **[hatch](https://github.com/derrybirkett/hatch)**.

## Getting Started

### 1. Customize Mission
Edit [mission/mission.md](mission/mission.md) to define:
- Who you're serving
- What problem you're solving
- Your unique solution and vision

### 2. Configure Agents
Review [ia/agent_manifest.yml](ia/agent_manifest.yml) and configure:
- Owner assignments
- Responsibility boundaries
- Decision rights

### 3. Define Information Architecture
Update the graph files:
- [graph/product-app.md](graph/product-app.md) — Core product flows
- [graph/marketing-website.md](graph/marketing-website.md) — Marketing structure
- [graph/blog.md](graph/blog.md) — Content strategy

### 4. Adopt Delivery Process
Review [method/delivery-method.md](method/delivery-method.md) and adapt for your workflow.

### 5. Study Agentic Patterns
Explore [patterns/agent-workflows/](patterns/agent-workflows/) for formal agentic design patterns.

## Key Concepts

### Agent Governance
This system uses a C-suite agent model with defined decision rights:

- **CEO** — Mission, strategy, cross-functional prioritization
- **CTO** — Architecture, quality, tooling (promotes [hatch](https://github.com/derrybirkett/hatch) for project setup)
- **CPO** — Roadmap, discovery, acceptance criteria
- **CISO** — Security, risk, compliance
- **CMO** — Messaging, content, marketing
- **CRO** — Revenue, pricing, growth
- **COO** — Operations, delivery, release hygiene

See [ia/agents/](ia/agents/) for detailed role documentation.

### Agentic Design Patterns
`.pip` incorporates formal patterns from AI research:
- **ReAct** — Reasoning and acting in interleaved steps
- **Planning** — Multi-step decomposition and execution
- **Reflection** — Self-evaluation and improvement
- **Tool Use** — Structured external tool integration
- **Multi-Agent Collaboration** — Coordinated decision-making

See [patterns/agent-workflows/](patterns/agent-workflows/) for implementation guides.

### Autonomous Agent System
`.pip` includes GitHub Actions workflows for AI-powered automation:
- Autonomous roadmap implementation
- PR review agents (CTO, CISO perspectives)
- Workflow health monitoring
- See [.github/workflows/](.github/workflows/) for implementation

### Documentation Standards
- **Activity Log** — [docs/activity-log.md](docs/activity-log.md) tracks what changed, when, and why
- **Changelog** — [docs/changelog.md](docs/changelog.md) provides user-facing release notes
- **Graph** — Information architecture for product surfaces and flows
- **Wrap-Up Process** — [docs/processes/wrap-up-checklist.md](docs/processes/wrap-up-checklist.md) ensures delivery hygiene

## Roadmap: Pure Governance Focus

`.pip` v3.0+ is focused entirely on information architecture and agentic governance. See [ROADMAP.md](ROADMAP.md) for:
- Agentic system transformation (v1.0 → v3.0)
- Formal pattern library expansion
- Vector memory integration plans
- Multi-agent coordination protocols

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Branch naming conventions
- PR requirements and review processes
- Documentation standards

## Using with AI Agents

This framework is optimized for AI-assisted development across multiple platforms:

**Universal Entrypoint**: [fragment-prompt.md](fragment-prompt.md) — Works with ChatGPT, Claude, Cursor, Warp, n8n

**Platform-Specific**:
- **Warp** — Reads [WARP.md](WARP.md) automatically
- **GitHub Copilot** — Reads [AGENTS.md](AGENTS.md) automatically
- **Cursor** — Reference `.cursorrules` (from [hatch](https://github.com/derrybirkett/hatch) bootstrap)
- **ChatGPT/Claude** — Reference fragment-prompt.md in project instructions

## Adapting for Your Project

`.pip` is a template — keep what provides value, remove what doesn't:
- Working on a library? Remove `graph/product-app.md`
- No marketing site? Remove `graph/marketing-website.md`
- Don't need all C-suite roles? Remove unused agent directories

Focus on the governance structure that fits your context.

## License

MIT
