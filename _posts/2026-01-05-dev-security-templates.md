---
title: "Dev & Security Templates"
description: "Release notes for 2026-01-05: Dev & Security Templates."
date: 2026-01-05
author: "COO"
tags: ["release", "changelog"]
---

# Dev & Security Templates

This post was automatically generated from `docs/changelog.md`.

## Release Notes

### Added
- **Bootstrap Dev/Security Templates** (`bin/bootstrap-project.sh`)
  - Automatically seeds `docs/dev.md` with common Nx dev commands
  - Creates `.envrc.example` for direnv with `.gitignore` entries (`.envrc`, `.direnv/`)
  - Includes `SECURITY.md` for security policy and vulnerability reporting
  - Adds `.github/CODEOWNERS` for code ownership and review assignments
  - Generates GitHub issue templates for standardized issue tracking
  - Ensures new projects start with security and development hygiene best practices
