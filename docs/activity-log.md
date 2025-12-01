# Activity Log

Log new agent activity for each commit: who did what and why.

| Date (UTC) | Agent | Commit/PR | What changed | Why (rationale) | Links |
| --- | --- | --- | --- | --- | --- |
| 2025-11-28 | CTO | 7271b83 | Added fragments system with nx-dev-infra scaffold | Enable one-command bootstrapping of new projects with consistent infrastructure (Nx, Docker, Postgres, n8n) | fragments/, bin/apply-nx-dev-infra.sh, docs/fragments-guide.md |
| 2025-11-28 | CTO | 89c7889 | Added WARP.md, .envrc.example, updated README.md with environment setup | Provide AI agents with repository guidance; secure token management via direnv | WARP.md, .envrc.example |
| 2025-11-28 | CTO | PR #4 | Updated README directory structure; strengthened git branching rules in WARP.md | Sync documentation with actual repo structure after recent PRs; prevent AI agents from working directly on main | README.md, WARP.md |
| 2025-11-28 | CTO | PR #5 | Added fragment-prompt.md universal AI agent entrypoint | Enable ChatGPT, Claude, Cursor, n8n to use .pip framework; provide single source of truth for agent behavior across all AI platforms | fragment-prompt.md, README.md |
| 2025-12-01 | CTO | PR #6 | Integrated genome/organism model into WARP.md, fragment-prompt.md, fragments-guide.md | Ensure AI agents across all platforms understand .pip immutability and dual usage patterns; prevent accidental modification of template files | WARP.md, fragment-prompt.md, docs/fragments-guide.md |
| 2025-12-01 | CTO | PR #7 | Fixed nx-dev-infra fragment Nx 22+ compatibility issues | Real-world testing revealed blocking issues: obsolete executor, duplicate projects, missing prereq checks; fixed all issues to enable smooth fragment application | fragments/nx-dev-infra/, bin/apply-nx-dev-infra.sh |
| 2025-12-01 | CTO | PR #8 | Added interactive bootstrap script for project setup | Enable users to generate personalized mission.md and README.md from user stories; fixed readline control character issues by using printf+read and stripping control characters | bin/bootstrap-project.sh, README.md |
| YYYY-MM-DD | <agent> | <hash or #PR> | <summary> | <decision/assumption> | <issue/docs> |

Guidance:
- One row per meaningful change merged to `main`.
- Reference related issue, doc, or decision.
- Keep rationale concise and actionable for future readers.

