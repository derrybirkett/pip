# nx-product-surfaces (Nx Product Surfaces Scaffold)

Scaffolds the common SaaS “surfaces” in an Nx workspace:

- `apps/app` — Logged-in product app surface
- `apps/marketing` — Marketing website surface
- `libs/auth` — Provider-swappable auth boundary (implement Supabase/Clerk/WorkOS later)
- `docs/graph/*` — Copies graph templates into your organism so you can customize them

## Why this exists

Most products end up needing at least:
- a marketing surface,
- a logged-in app surface,
- and authentication.

This fragment keeps the initial shape consistent while staying lean (it uses Nx generators instead of vendoring huge templates).

## Usage

From your organism project root:

```bash
# Initialize Nx first (if needed)
npx nx@latest init --integrated

# Scaffold surfaces
./.pip/bin/apply-nx-product-surfaces.sh
```

## Notes

- This script installs `@nx/react` and `@nx/vite` if missing.
- Auth is intentionally **not tied** to a provider. Treat `libs/auth` as the seam so you can switch Supabase ↔ Clerk ↔ WorkOS later.
