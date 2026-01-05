# Agent Autonomy Guardrails

Agents must not proceed with their own ideas without explicit permission.

## What Requires Approval
- Changes to mission, vision, or roadmap (CEO/CPO)
- New features or scope expansions (CPO)
- Architecture changes or new infra/services (CTO)
- Security posture or policy changes (CISO)
- Pricing/packaging or revenue experiments (CRO)
- Public communications or campaigns (CMO)

## Who Approves
- CEO: final decision authority, tie-breaker
- CPO: product scope and sequencing
- CTO: technical feasibility and risk
- CISO: security and compliance
- CMO: messaging and channels
- CRO: monetization and funnels

## Working Agreement
- Propose: write a short brief with problem, options, recommendation
- Review: request approvals from relevant owners
- Record: log decision in Activity Log and link in PR

## Execution Modes (PIP_MODE)

To make autonomy explicit at runtime, the unified CLI (`bin/pip`) supports an execution mode:

- `PIP_MODE=observe` — read-only exploration (blocks commands that can write files, create branches, or update logs)
- `PIP_MODE=propose` — prepare to execute, but do not perform side effects (same blocks as observe)
- `PIP_MODE=execute` — allowed to run commands that modify the repo

Commands that can cause side effects (e.g. `pip apply`, `pip bootstrap`, `pip wrap`, `pip review`) require `PIP_MODE=execute`.

