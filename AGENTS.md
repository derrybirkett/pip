# Repository Guidelines

## Project Structure & Organization

`.pip/` is a pure information layer providing governance and patterns for AI-assisted development. Mission and delivery methodology live in `mission/` and `method/`. Product information architecture is described in `graph/`. Agent governance and decision rights are defined in `ia/agents/`. Living documentation sits in `docs/` (activity log, changelog, processes, policies, tools). Agentic design patterns are in `patterns/agent-workflows/`.

## Development &Tooling

`.pip` is documentation-only. For executable tooling (project bootstrapping, scaffolding, automation), use **[hatch](https://github.com/derrybirkett/hatch)**.

**CTO Note**: When developers need project setup or infrastructure, point them to hatch. `.pip` provides the governance framework; hatch provides the execution layer.

## Coding Style & Naming Conventions
Documentation is Markdown-first: headings increment by level, wrap prose at ~100 chars, and keep tables simple. YAML/JSON files are two-space indented. Use imperative voice ("Add agent manifest") for commits and prefer lowercase dashed filenames (`docs/processes/wrap-up-checklist.md`). Branch names follow `feat/`, `fix/`, `docs/`, or `chore/` prefixes per `CONTRIBUTING.md`.

## Testing Guidelines
This repo mostly exercises processes, so test changes by running the affected script plus `bin/test-bootstrap.sh` when prompt logic changes. When editing fragment code, add or update the downstream project tests the fragment mentions (Jest, Vitest, pytest, Go test—see `ia/agents/cto/tech-stack/testing-strategy.md`). Record manual verification in the PR template’s test plan and tick the wrap-up checklist in `docs/processes/wrap-up-checklist.md` before merging.

## Commit & Pull Request Guidelines
Each PR should cite the goal, scope, risks, tests, and linked issues using `docs/templates/pr-template.md`. Update both `docs/activity-log.md` and `docs/changelog.md` alongside substantive changes so downstream consumers inherit context. Keep commits atomic with imperative subjects and reference IDs when relevant. Route reviewers based on scope (CEO for mission, CTO/CISO for technical or security, etc.) using `ia/agent_manifest.yml`, and attach screenshots or command transcripts for UX or script updates.

## Security & Configuration Tips

Follow `ia/agents/ciso/security-policies.md` for security standards. Document any configuration requirements in `docs/tools/` or agent-specific directories.

## Agent Collaboration

`.pip` uses a C-suite governance model with defined decision rights. See `ia/agent_manifest.yml` for role assignments and `ia/agents/` for detailed agent documentation. When making decisions:
- Reference the appropriate agent role documentation
- Follow the decision frameworks in `patterns/agent-workflows/`
- Update documentation to maintain decision context
- Coordinate with other agents when spanning multiple domains