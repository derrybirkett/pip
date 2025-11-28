# Contributing

Thanks for helping improve this project. This guide explains how to propose edits.

## Branch Naming
- `feat/<short-desc>` for features
- `fix/<short-desc>` for bug fixes
- `docs/<area>` for documentation
- `chore/<task>` for maintenance

## Pull Requests
- Use the PR template: describe goal, scope, screenshots, test plan, risks
- Link issues and related docs (e.g., `.pip/docs/...`)
- Update `./.pip/docs/changelog.md` and `./.pip/docs/activity-log.md`

## Review & Approvals
- Small, focused PRs are easier to review
- Required approvals depend on scope:
  - Product scope: CPO
  - Technical/infra: CTO (+ CISO for security-impacting)
  - Messaging/marketing: CMO
  - Pricing/packaging: CRO
  - Cross-functional/mission: CEO

## Standards
- Code: follow project linters/formatters; add tests where relevant (see [testing strategy](./ia/agents/cto/tech-stack/testing-strategy.md))
- Security: follow [security policies](./ia/agents/ciso/security-policies.md); never commit secrets
- Docs: prefer concise Markdown; include context and links
- Commits: small, atomic; imperative subject; reference issues

## Automation
- PRs can be routed to the right agent via `./ia/agent_manifest.yml`
- CI checks: lint, test, security scans must pass

