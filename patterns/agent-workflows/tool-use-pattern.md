# Tool Use Pattern

**Pattern Type**: Agent Workflow  
**Primary Users**: CTO, CISO, COO  
**Purpose**: Choose the safest, fastest tool that can validate or advance the work with minimal
risk.

## Overview

The Tool Use pattern keeps agents from overreaching. Use the least-powerful tool that can answer
the question or make the change, and always verify the result.

## Selection Heuristics

1. Prefer reading before editing.
2. Prefer local context before remote systems.
3. Prefer deterministic checks before judgment calls.
4. Prefer reversible changes before destructive actions.
5. Record what was run and what was learned.

## Common Tool Categories

- Search and code navigation
- Tests, linters, and validators
- Version control inspection
- Deployment and CI diagnostics
- Security scanners and dependency checks

## Related Patterns

- [ReAct Pattern](./react-pattern.md)
- [Planning Pattern](./planning-pattern.md)
- [Reflection Pattern](./reflection-pattern.md)
- [Multi-Agent Collaboration](./multi-agent-collaboration-pattern.md)
