# .pip Index

Quick reference to all .pip documentation.

## Core Documents

### Mission & Method
- [Mission](./mission/mission.md) — Why this project exists, what problem it solves
- [Delivery Method](./method/delivery-method.md) — How we build and ship

### Contributing
- [Contributing Guide](./CONTRIBUTING.md) — How to contribute
- [Repository Guidelines](./AGENTS.md) — Agent-ready conventions and workflows
- [PR Template](./docs/templates/pr-template.md) — Pull request template
- [Wrap-Up Checklist](./docs/processes/wrap-up-checklist.md) — Pre-merge checklist

## Agent Roles

### Agent Manifest
- [Agent Manifest](./ia/agent_manifest.yml) — Overview of all agents

### Individual Agents

#### CEO
- [Role](./ia/agents/ceo/role.md)
- [Responsibilities](./ia/agents/ceo/responsibilities.md)

#### CTO
- [Role](./ia/agents/cto/role.md)
- [Responsibilities](./ia/agents/cto/responsibilities.md)
- Tech Stack:
  - [Tech Stack Overview](./ia/agents/cto/tech-stack/tech-stack.md)
  - [Git Practices](./ia/agents/cto/tech-stack/git-practices.md)
  - [Testing Strategy](./ia/agents/cto/tech-stack/testing-strategy.md)
  - [Dummy Data Strategy](./ia/agents/cto/tech-stack/dummy-data-strategy.md)

#### CPO
- [Role](./ia/agents/cpo/role.md)
- [Responsibilities](./ia/agents/cpo/responsibilities.md)
- [Initiative One-Pager](./ia/agents/cpo/initiative-one-pager.md)
- [Product Ops Playbook](./ia/agents/cpo/product-ops-playbook.md)

#### CISO
- [Role](./ia/agents/ciso/role.md)
- [Responsibilities](./ia/agents/ciso/responsibilities.md)
- [Security Policies](./ia/agents/ciso/security-policies.md)

#### CMO
- [Role](./ia/agents/cmo/role.md)
- [Responsibilities](./ia/agents/cmo/responsibilities.md)
- [Marketing Strategy](./ia/agents/cmo/marketing-strategy.md)

#### CRO
- [Role](./ia/agents/cro/role.md)
- [Responsibilities](./ia/agents/cro/responsibilities.md)
- [Revenue Strategy](./ia/agents/cro/revenue-strategy.md)

#### COO
- [Role](./ia/agents/coo/role.md)
- [Responsibilities](./ia/agents/coo/responsibilities.md)

## Product Graphs

- [Product App](./graph/product-app.md) — Core product flows and features
- [Marketing Website](./graph/marketing-website.md) — Marketing site structure
- [Blog](./graph/blog.md) — Content strategy

## Documentation

### Getting Started
- **[Using .pip as Genome](./docs/using-pip-as-genome.md)** — How to use .pip as immutable template
- [Adapting for Your Project](./docs/adapting-for-your-project.md) — Customization guide by project type

### Living Docs
- [Activity Log](./docs/activity-log.md) — Historical record of changes
- [Changelog](./docs/changelog.md) — User-facing release notes

### Processes
- [Wrap-Up Checklist](./docs/processes/wrap-up-checklist.md)

### Templates
- [PR Template](./docs/templates/pr-template.md)

### Tools
- [MCP Overview](./docs/tools/mcp-overview.md)

## Quick Start for New Projects

When starting a new project with this template:

1. **Customize Mission** (`mission/mission.md`)
   - Define your target users
   - Articulate the problem you're solving
   - Describe your solution and vision

2. **Configure Agents** (`ia/agent_manifest.yml`)
   - Assign owners to agent roles
   - Update responsibility boundaries if needed
   - Remove unused agent roles

3. **Define Product** (files in `graph/`)
   - Map out your product flows
   - Define marketing site structure (if applicable)
   - Plan content strategy (if applicable)

4. **Adapt Method** (`method/delivery-method.md`)
   - Customize delivery approach for your context
   - Define your Definition of Done

5. **Remove What You Don't Need**
   - Library project? Remove marketing graph
   - No blog? Remove blog graph
   - Fewer roles? Remove unused agent directories

## Glossary

- **Graph**: The interconnected surfaces you're building (product, marketing, blog)
- **Agent**: A role with defined decision rights and responsibilities (CEO, CTO, CPO, etc.)
- **Wrap-Up**: Process of documenting, merging, and communicating completed work
- **Activity Log**: Historical record of what changed and why
- **Changelog**: User-facing release notes
- **.pip**: Project Intelligence & Process — this framework
