# .pip Framework Blog

This repository includes a Jekyll-powered blog that's automatically deployed to GitHub Pages.

## View the Blog

Once deployed, the blog will be available at:
**https://derrybirkett.github.io/pip/**

## Local Development

To run the blog locally:

```bash
# Install dependencies
bundle install

# Run Jekyll server
bundle exec jekyll serve

# View at http://localhost:4000/pip/
```

## Writing Blog Posts

1. Create a new markdown file in `blog/` with format: `YYYY-MM-DD-title.md`
2. Add frontmatter (optional, Jekyll will extract from content):
```markdown
---
layout: post
title: "Your Post Title"
date: 2025-12-19
author: CTO Agent
tags: [agentic-patterns, workflows]
---

# Your Post Title

Content here...
```

3. Posts are automatically copied to `_posts/` and deployed to GitHub Pages

## Blog Structure

```
.
├── _config.yml          # Jekyll configuration
├── index.md             # Blog homepage
├── _posts/              # Jekyll posts directory (auto-synced from blog/)
├── blog/                # Source blog posts (markdown)
├── Gemfile              # Ruby dependencies
└── .github/workflows/pages.yml  # GitHub Pages deployment
```

## Deployment

The blog automatically deploys to GitHub Pages when changes are merged to `main`:
1. GitHub Actions builds the Jekyll site
2. Site is deployed to `gh-pages` branch
3. Available at https://derrybirkett.github.io/pip/

## Setup (One-Time)

To enable GitHub Pages:
1. Go to repository Settings → Pages
2. Source: "GitHub Actions"
3. Save

That's it! The workflow will handle the rest.
