---
layout: post
title: "Jekyll Blog Migration: Standardizing on Industry Tools"
date: 2025-12-19
author: .pip Framework
categories: infrastructure blogging
---

<!--more-->

## Why Jekyll?

The `.pip` blog has migrated from a custom Markdown setup to Jekyll, the battle-tested static site generator that powers GitHub Pages. This move aligns with our LEAN principles: use proven tools instead of reinventing the wheel.

## What Changed

### Theme & Design
We chose the [Hitchens theme](https://github.com/patdryburgh/hitchens) for its minimalist, typography-focused design. Clean, fast, and focused on content—exactly what a technical blog needs.

### Technical Migration
- **All 6 blog posts** converted to Jekyll format with proper YAML front matter
- **Pagination** configured (10 posts per page) for scalability
- **Custom styling** for centered dividers and branded footer
- **GitHub Pages deployment** with automated builds on push to main

### Build Challenges
The migration involved solving two key technical issues:

1. **SCSS Import Error**: Remote themes don't expose their SCSS partials like gem-based themes. We removed the invalid `@import "hitchens"` and used plain CSS overrides instead.

2. **Dependency Conflicts**: Individual Jekyll gems caused bundler/Thor conflicts in CI. We switched to the `github-pages` gem bundle, which ensures all dependencies are at GitHub Pages-compatible versions.

## What You Get

### For Readers
- **Clean design**: Typography-focused layout that's easy to read
- **Fast loading**: Static site generation means instant page loads
- **RSS feed**: Subscribe and get updates automatically

### For Contributors
- **Standard tooling**: Jekyll is widely adopted with extensive documentation
- **Simple authoring**: Write posts in Markdown with YAML front matter
- **Local preview**: `bundle exec jekyll serve` to test before pushing
- **Automatic deployment**: Push to main → GitHub Actions builds → site updates

## Blog Structure

```
_posts/
├── 2025-12-01-interactive-bootstrap.md
├── 2025-12-09-branch-protection-enforcement.md
├── 2025-12-11-astro-blog-fragment.md
├── 2025-12-17-agentic-design-patterns.md
├── 2025-12-19-agent-workflow-documents.md
└── 2025-12-19-autonomous-review-and-unified-cli.md
```

Each post includes:
- Standard Jekyll front matter (layout, title, date, categories)
- `<!--more-->` separator to control excerpts
- Markdown content with code blocks and formatting

## LEAN Wins

This migration embodies LEAN methodology:
- **Eliminate waste**: Stopped maintaining custom blog infrastructure
- **Use standards**: Jekyll is the industry standard for static blogs
- **Ship quickly**: Migration completed in one day across 9 PRs
- **Iterate based on feedback**: Fixed styling and build issues incrementally

## What's Next

With the blog now on solid infrastructure, we can focus on content:
- Documenting agentic development patterns
- Sharing lessons from agent workflows
- Publishing framework updates and features

The blog lives at **[derrybirkett.github.io/pip](https://derrybirkett.github.io/pip)** — check it out and subscribe via RSS.

---

*This migration was executed by CTO and CMO agents following `.pip` wrap-up procedures: fix build issues → update changelog → write blog post → merge and deploy.*
