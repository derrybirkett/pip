# .pip — Tombstone

`.pip` has been retired. Its content has been redistributed across the [bloom](https://github.com/derrybirkett/bloom) system.

## Where Each Piece Went

| Was in pip | Now lives in | Notes |
|---|---|---|
| `mission/mission.md` | [idea](https://github.com/derrybirkett/idea) | As a per-product template |
| `method/delivery-method.md` | [soul](https://github.com/derrybirkett/soul) | Methodology is a soul concern |
| `graph/` (product, marketing, blog IA) | [idea](https://github.com/derrybirkett/idea) | As IA templates |
| `ia/agents/` (CEO, CTO, CISO, ...) | [council](https://github.com/derrybirkett/council) | Council goes deeper, with explicit advisor contracts |
| `patterns/agent-workflows/` | [shulkerbox/library](https://github.com/derrybirkett/shulkerbox) | Reference patterns for operators |
| `fragment-prompt.md` | [shulkerbox/templates](https://github.com/derrybirkett/shulkerbox) | Universal AI entrypoint pattern |
| `WARP.md`, `AGENTS.md`, `.cursorrules` | [shulkerbox/templates](https://github.com/derrybirkett/shulkerbox) | Cross-tool entrypoint patterns |
| `docs/processes/wrap-up-checklist.md` | [shulkerbox/skills/core/wrap-up](https://github.com/derrybirkett/shulkerbox) | Already a skill there |
| `docs/activity-log.md` template | [shulkerbox/skills/productivity/activity-log](https://github.com/derrybirkett/shulkerbox) | Auto-captured by post-commit hook |
| `.github/workflows/` agent automation | [shulkerbox/automation](https://github.com/derrybirkett/shulkerbox) | Or as per-product overlays |

## Why .pip Was Retired

`.pip` tried to own four concerns simultaneously — mission, method, governance, and patterns — and the boundaries kept blurring. Each concern now lives in a single-purpose repo with a clear role. See [bloom/README.md](https://github.com/derrybirkett/bloom) for the new system shape.

The dual `.pip` + `hatch` split (information layer + tooling layer) was an interim attempt to fix the same ambiguity. Bloom replaces it with five focused repos rather than two competing ones.

## What Was Worth Salvaging

- The single canonical AI entrypoint idea (`fragment-prompt.md`) — preserved in shulkerbox.
- The "graph" concept for product surface IA — preserved in idea.
- The discovery → build → ship method — preserved in soul.
- The C-suite advisory model — superseded by council, which goes deeper with explicit advisor contracts, packs, and escalation rules.
- The activity-log + wrap-up + weekly-review loop — preserved and matured in shulkerbox.

## What Was Not Worth Salvaging

- The dual `.pip` + `hatch` split — replaced by clearer five-repo composition.
- The `PIP_MODE` / `.piprc` runtime config — overengineering for a documentation system.
- Top-level `WARP.md` and `AGENTS.md` duplication — single-entrypoint pattern in shulkerbox handles all tools without per-tool files.
- The autonomous roadmap GitHub Actions agents — replaced by council's playbook-driven model and shulkerbox's per-product automation.

## Final Version

`.pip` v3.0.0, released March 2026.

## Recovery

This repository remains accessible at [github.com/derrybirkett/pip](https://github.com/derrybirkett/pip) for archeological reference but receives no further updates. New work happens in the bloom system.
