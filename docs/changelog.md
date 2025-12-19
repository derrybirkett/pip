# Changelog

All notable changes to the website/app are documented here.

## Unreleased

## 2025-12-19 — Autonomous Review System & Unified CLI
### Added
- **Autonomous Progress Review & Prioritization System** (`bin/review-and-prioritize.sh`)
  - Automatically analyzes progress from activity log, git commits, and Linear tasks
  - Identifies velocity metrics, blockers, and agent effectiveness patterns
  - Recommends top 5 priorities using weighted scoring framework:
    - Roadmap alignment (40%), Unblocking potential (30%), User value (20%), Effort (10%)
  - Requires manual approval before execution
  - Creates feature branches and tracks decision quality
  - Demonstrates all 5 agentic patterns working together
- **Product Requirements Document** for autonomous review system (`docs/requirements/autonomous-progress-review.md`)
  - User stories and acceptance criteria
  - Prioritization framework with scoring formula
  - Success metrics and validation criteria
- **Unified pip CLI** (`bin/pip`)
  - Single command interface: `pip <command>` instead of `./bin/script.sh`
  - Commands: review, validate, wrap, bootstrap, apply, patterns, pattern, version, help
  - Color-coded output with proper ANSI rendering
  - Smart pattern viewer (uses bat/less/cat)
  - Common workflow examples in help text
- **Pattern validation script** (`bin/validate-patterns.sh`)
  - Tests all 5 patterns exist and have required sections
  - Validates 3,017 lines of documentation
  - Confirms README catalog links

### Fixed
- Color code rendering in pip CLI now displays properly instead of showing escape sequences

## 2025-12-17 — Agentic Design Patterns (Phase 1 v1.1.0)
### Added
- **5 Core Agentic Design Patterns** extracted from 482-page PDF and documented:
  - **ReAct Pattern** - Reason-Act-Observe-Reflect workflow for iterative problem-solving
  - **Planning Pattern** - Task decomposition and sequencing for complex work
  - **Reflection Pattern** - Learning from experience through structured retrospectives
  - **Tool Use Pattern** - Extending agent capabilities with specialized tools
  - **Multi-Agent Collaboration Pattern** - Coordinating specialized agents on large projects
- **Pattern Library Catalog** (README.md) with pattern relationships, selection guide, and usage examples
- Each pattern includes:
  - Overview and purpose
  - When to use guidance with concrete scenarios
  - Step-by-step how-it-works with examples
  - Benefits and limitations
  - Integration with .pip agent roles (CTO, CPO, COO, etc.)
  - Automation opportunities with example scripts
- **3,017 lines of documentation** providing foundation for agentic system transformation

### Changed
- Phase 1 (v1.1.0) Pattern Library & Resources milestone started per ROADMAP.md
- Patterns adapted specifically for .pip framework agent workflows

## 2025-12-11 — Astro Blog Fragment
### Added
- **astro-blog fragment** - Fast, SEO-friendly blog powered by Astro 4 with Tailwind CSS
- Fragment includes:
  - Astro 4 static site generator with lightning-fast performance
  - Tailwind CSS styling with built-in dark mode support
  - TypeScript for type-safe development
  - Content Collections for type-safe markdown handling
  - Auto-generated RSS feed at `/rss.xml`
  - Nx integration with serve/build/preview targets
- **bin/apply-astro-blog.sh** - Apply script with prerequisite checks and automatic symlink setup
- **fragments/astro-blog/README.md** - Comprehensive documentation covering:
  - Quick start guide
  - Writing posts with frontmatter schema
  - Customization options (styling, site URL, analytics)
  - Deployment to Vercel/Netlify/Docker/GitHub Pages
  - Troubleshooting common issues
  - Best practices for writing, SEO, and performance

### Changed
- Updated `docs/fragments-guide.md` with astro-blog section and usage examples
- Added Example 2 (Content Marketing Blog) and Example 4 (Full Stack with Blog) to fragments guide
- Enhanced fragments guide with deployment and customization patterns

## 2025-12-09 — Branch Protection & Strategic Roadmap
### Added
- **Git hooks system** - Pre-commit hook blocks direct commits to main branch locally
- **hooks/install-hooks.sh** - One-command installation script for git hooks
- **hooks/README.md** - Documentation for hook system and bypassing in emergencies
- **docs/github-branch-protection.md** - Complete guide for configuring GitHub branch protection
- **ROADMAP.md** - Strategic plan to transform .pip into complete agentic development system (v0.4.0 → v1.0.0)
- **resources/agentic-design-patterns/** - Added 482-page Agentic Design Patterns PDF as reference
- **GitHub branch protection rules** - Configured via API: enforce admins, require PRs, linear history, block force pushes

### Changed
- Updated README.md with git hooks installation as step 0 in Getting Started
- README.md now includes roadmap section highlighting 7-phase transformation plan

### Security
- Branch protection prevents unauthorized changes to main branch
- Hooks provide local enforcement before push to GitHub

## 2025-12-04 — Command Ownership & Wrap Automation
### Added
- `AGENTS.md` contributor guide with command ownership/usage sections so downstream agents know how to work in this repo.
- `bin/wrap-up.sh` script + COO role docs to automate the wrap-up checklist, commit, tag, and push process triggered by “ok wrap up”.

### Changed
- Updated `README.md`, `INDEX.md`, `WARP.md`, and `fragment-prompt.md` to include the COO role and agent-tool mappings.
- `ia/agent_manifest.yml` now lists owning agents and tools for transparency (CTO for bootstrap scripts, COO for wrap-up automation).
- `docs/processes/wrap-up-checklist.md` now explicitly references COO ownership and the wrap-up script.

## 2025-12-01 — Interactive Bootstrap Feature
### Added
- **bootstrap-project.sh** - Interactive wizard that captures user stories and generates personalized project documentation
- Script asks 6 questions (project name, users, problem, solution, differentiator, project type) and generates:
  - `docs/mission.md` with mission statement from user story
  - Customized `README.md` with project description
  - `docs/activity-log.md` and `docs/changelog.md` templates
- Colored CLI interface for better user experience
- Input sanitization to prevent control characters in generated files

### Changed
- Updated README.md with "Quick Setup (Recommended)" section highlighting interactive bootstrap
- Bootstrap wizard now first step in project setup flow

## 2025-12-01 — Fragment Compatibility Fixes
### Fixed
- **nx-dev-infra fragment** now compatible with Nx 22+ (updated executor from `@nx/workspace:run-commands` to `nx:run-commands`)
- Removed obsolete `version` attribute from docker-compose.yml (eliminates warning)
- Added `.nxignore` template to prevent "duplicate projects" error when using `.pip` as submodule
- Apply script now checks Docker is running before attempting to start containers
- Apply script now verifies Nx workspace is initialized before applying fragment

### Changed
- Enhanced apply script with prerequisite checks and better error messages
- Updated fragment README with Quick Start section and comprehensive troubleshooting
- Documented all common setup errors with solutions

## 2025-12-01 — Genome/Organism Model Integration
### Changed
- Integrated genome/organism model explanation into WARP.md for Warp AI agents
- Integrated genome/organism model explanation into fragment-prompt.md for all AI platforms
- Added genome model context to fragments-guide.md
- Clarified dual usage pattern: working ON `.pip` repository vs using `.pip` AS immutable template
- Improved AI agent understanding of when to modify files vs treat them as templates

## 2025-11-28 — Universal AI Agent Entrypoint
### Added
- **fragment-prompt.md** - Universal AI agent entrypoint file that works across ChatGPT, Claude, Cursor, Warp, and n8n
- Platform-specific integration examples for all major AI tools
- Comprehensive agent behavior guidelines, decision boundaries, and quick reference
- Blog post documenting the universal entrypoint feature

### Changed
- Updated README.md with AI agent guidance and platform-specific instructions
- Updated README.md directory tree to reflect actual repository structure
- Strengthened git branching rules in WARP.md with explicit "Never Work Directly on Main" section

## 2025-11-28 — Fragments System: Project Bootstrapping
### Added
- **Fragments system** - Reusable project scaffolds for consistent infrastructure
- **nx-dev-infra fragment** - Containerized Nx development environment with Docker, Postgres, and n8n
- **apply-nx-dev-infra.sh script** - One-command bootstrapping for new projects
- **Fragments guide** - Comprehensive documentation for using and creating fragments
- Expanded `.pip` mission to include scaffolding alongside documentation framework

### Changed
- Updated README.md, WARP.md, and mission.md to reflect fragments capability
- Reorganized as both documentation AND executable infrastructure patterns

## 2025-11-28 — Documentation & Security Improvements
### Added
- WARP.md file providing comprehensive guidance for AI agents working in the repository
- .envrc.example template for secure environment variable management with direnv
- Environment setup instructions in README.md

### Security
- Removed exposed Atlassian token from .envrc, replaced with secure template approach

## YYYY-MM-DD — Release Name
### Added
- <new features>

### Changed
- <updates/improvements>

### Fixed
- <bug fixes>

### Security
- <notable security changes>
