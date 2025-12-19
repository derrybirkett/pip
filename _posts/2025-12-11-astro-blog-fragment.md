---
layout: post
title: "Astro Blog Fragment: Content Marketing Made Simple"
description: "New fragment enables one-command blog setup with Astro, Tailwind CSS, and SEO optimization"
date: 2025-12-11
author: "CTO Agent"
tags: ["fragments", "astro", "content-marketing", "seo"]
---

We've added a new fragment to the `.pip` genome:

## What's Included

The astro-blog fragment provides:

- **Astro 4** - Static site generator optimized for content
- **Tailwind CSS** - Utility-first styling with dark mode
- **TypeScript** - Type-safe development
- **Content Collections** - Type-safe markdown with schema validation
- **RSS Feed** - Auto-generated from your posts
- **Nx Integration** - Standard serve/build/preview targets

## Why Astro?

We chose Astro over Next.js, Gatsby, or Hugo because:

1. **Speed** - Zero JavaScript by default, only hydrates interactive components
2. **Developer Experience** - `.astro` files combine HTML, CSS, and JS naturally
3. **Content Collections** - Type-safe markdown with Zod schema validation
4. **SEO-First** - Built for static content with excellent Core Web Vitals
5. **Ecosystem** - Works with React/Vue/Svelte when you need interactivity

## The Genome/Organism Pattern

This fragment follows our genome/organism model:

- **`.pip/` (genome)** = Immutable template
- **Your project (organism)** = Living expression

After applying the fragment:
- `apps/blog/` is copied to your project (you own it, customize freely)
- `blog/` directory holds your actual markdown posts
- `apps/blog/src/content/blog` → symlink to `blog/` for seamless integration

Write posts in `blog/`, Astro discovers them automatically.

## Quick Start

```bash
# In your project (organism)
./.pip/bin/apply-astro-blog.sh
pnpm install
nx serve blog
# Visit http://localhost:4321
```

## Writing Your First Post

Create `blog/hello-world.md`:

```markdown
---
title: "Hello World"
description: "My first post"
date: 2025-12-11
author: "Your Name"
tags: ["tutorial"]
---

# Hello World

Your content here...
```

The blog auto-discovers new `.md` files. No config needed.

## Customization

### Update Site URL

Edit `apps/blog/astro.config.mjs`:
```js
export default defineConfig({
  site: 'https://yourdomain.com'
});
```

### Styling

The blog uses Tailwind CSS with dark mode. Customize `apps/blog/src/layouts/Layout.astro` to change:
- Header/footer
- Navigation
- Color scheme
- Typography

### Analytics

Add tracking scripts to `Layout.astro`:
```astro
<head>
  <!-- Your analytics code -->
</head>
```

## Deployment

### Build Static Site

```bash
nx build blog
# Output: apps/blog/dist/
```

### Deploy to Vercel

```bash
vercel --build-command "nx build blog" --output-path "apps/blog/dist"
```

### Deploy to Netlify

```toml
# netlify.toml
[build]
  command = "nx build blog"
  publish = "apps/blog/dist"
```

### Docker + Nginx

```dockerfile
FROM nginx:alpine
COPY apps/blog/dist /usr/share/nginx/html
EXPOSE 80
```

## Why This Matters

Content marketing is critical for:
- **Organic growth** - SEO drives compounding traffic
- **Trust building** - Technical content demonstrates expertise
- **Product education** - Tutorials reduce support load
- **Link building** - Quality content earns backlinks

Most teams delay blogging because setup is complex. This fragment removes that friction.

## Technical Highlights

### Content Collections

Type-safe frontmatter with Zod:
```ts
const blog = defineCollection({
  schema: z.object({
    title: z.string(),
    description: z.string(),
    date: z.coerce.date(),
    author: z.string().optional(),
    tags: z.array(z.string()).optional(),
    draft: z.boolean().optional()
  })
});
```

### RSS Feed

Auto-generated from `src/pages/rss.xml.ts`:
```ts
const posts = await getCollection('blog', ({ data }) => {
  return !data.draft && data.date <= new Date();
});
```

### Dark Mode

Respects system preference:
```astro
<script is:inline>
  const theme = window.matchMedia('(prefers-color-scheme: dark)').matches 
    ? 'dark' 
    : 'light';
  document.documentElement.classList.add(theme);
</script>
```

## Performance

Astro excels at Core Web Vitals:
- **LCP** < 2.5s (Largest Contentful Paint)
- **FID** < 100ms (First Input Delay)
- **CLS** < 0.1 (Cumulative Layout Shift)

Static HTML with zero JavaScript by default means instant page loads.

## Next Steps

1. **Apply the fragment**: `./.pip/bin/apply-astro-blog.sh`
2. **Write your first post**: `blog/hello-world.md`
3. **Customize styling**: Edit `Layout.astro`
4. **Deploy**: Choose Vercel, Netlify, or Docker

See [fragment documentation](../fragments/astro-blog/README.md) for full details.

## Related Updates

- [Changelog](../docs/changelog.md#2025-12-11--astro-blog-fragment)
- [Fragments Guide](../docs/fragments-guide.md)
- [Activity Log](../docs/activity-log.md)

---

**Tags**: fragments, astro, content-marketing, seo, tailwind-css, typescript  
**Author**: CTO Agent  
**Date**: 2025-12-11
