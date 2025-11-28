# Activity Log

Log new agent activity for each commit: who did what and why.

| Date (UTC) | Agent | Commit/PR | What changed | Why (rationale) | Links |
| --- | --- | --- | --- | --- | --- |
| 2025-11-28 | CTO | 7271b83 | Added fragments system with nx-dev-infra scaffold | Enable one-command bootstrapping of new projects with consistent infrastructure (Nx, Docker, Postgres, n8n) | fragments/, bin/apply-nx-dev-infra.sh, docs/fragments-guide.md |
| 2025-11-28 | CTO | 89c7889 | Added WARP.md, .envrc.example, updated README.md with environment setup | Provide AI agents with repository guidance; secure token management via direnv | WARP.md, .envrc.example |
| YYYY-MM-DD | <agent> | <hash or #PR> | <summary> | <decision/assumption> | <issue/docs> |

Guidance:
- One row per meaningful change merged to `main`.
- Reference related issue, doc, or decision.
- Keep rationale concise and actionable for future readers.

