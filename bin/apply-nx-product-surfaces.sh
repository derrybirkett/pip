#!/usr/bin/env bash
set -euo pipefail

PIP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$(pwd)"

echo "🚀 Scaffolding Nx product surfaces (app + marketing + auth boundary)"
echo "   From: $PIP_DIR"
echo "   Into: $TARGET_DIR"
echo

if [ ! -f "$TARGET_DIR/nx.json" ]; then
  echo "❌ Nx workspace not detected (nx.json missing)."
  echo "   Initialize Nx first (example):"
  echo "     npx nx@latest init --integrated"
  exit 1
fi

if [ ! -f "$TARGET_DIR/package.json" ]; then
  echo "❌ package.json missing."
  echo "   Nx init should create it; please run Nx init first."
  exit 1
fi

detect_pm() {
  if [ -f "pnpm-lock.yaml" ]; then
    echo "pnpm"
  elif [ -f "yarn.lock" ]; then
    echo "yarn"
  else
    echo "npm"
  fi
}

PM="$(detect_pm)"

pm_add_dev() {
  case "$PM" in
    pnpm) pnpm add -D "$@" ;;
    yarn) yarn add -D "$@" ;;
    npm) npm install -D "$@" ;;
    *)
      echo "❌ Unsupported package manager: $PM";
      exit 1
      ;;
  esac
}

has_dep() {
  local name="$1"
  node -e "const p=require('./package.json');const d={...(p.dependencies||{}),...(p.devDependencies||{})};process.exit(d[name]?0:1)" "$name" >/dev/null 2>&1
}

ensure_nx_react() {
  if has_dep "@nx/react" && has_dep "@nx/vite"; then
    echo "✅ Nx React tooling already installed (@nx/react, @nx/vite)"
    return
  fi

  echo "📦 Installing Nx React tooling (@nx/react, @nx/vite)..."
  pm_add_dev @nx/react @nx/vite
}

NX_INTERACTIVE=false
export NX_INTERACTIVE

NX_CMD="npx nx"

ensure_nx_react

echo

echo "🧱 Creating apps/app (product app surface)..."
if [ -d "apps/app" ]; then
  echo "⚠️  apps/app already exists, skipping"
else
  $NX_CMD g @nx/react:application apps/app \
    --bundler=vite \
    --linter=eslint \
    --unitTestRunner=vitest \
    --e2eTestRunner=none \
    --routing=false \
    --style=css \
    --port=4200 \
    --skipFormat
  echo "✅ Created apps/app"
fi

echo

echo "🧱 Creating apps/marketing (marketing surface)..."
if [ -d "apps/marketing" ]; then
  echo "⚠️  apps/marketing already exists, skipping"
else
  $NX_CMD g @nx/react:application apps/marketing \
    --bundler=vite \
    --linter=eslint \
    --unitTestRunner=vitest \
    --e2eTestRunner=none \
    --routing=false \
    --style=css \
    --port=4201 \
    --skipFormat
  echo "✅ Created apps/marketing"
fi

echo

echo "🧱 Creating libs/auth (provider-swappable boundary)..."
if [ -d "libs/auth" ]; then
  echo "⚠️  libs/auth already exists, skipping"
else
  $NX_CMD g @nx/js:library libs/auth \
    --bundler=tsc \
    --linter=eslint \
    --unitTestRunner=none \
    --minimal \
    --skipFormat
  echo "✅ Created libs/auth"
fi

echo

echo "📚 Adding organism graph templates under docs/graph/..."
mkdir -p docs/graph

copy_graph() {
  local name="$1"
  local src="$PIP_DIR/graph/$name.md"
  local dst="$TARGET_DIR/docs/graph/$name.md"

  if [ -f "$dst" ]; then
    echo "⚠️  docs/graph/$name.md already exists, skipping"
    return
  fi

  if [ ! -f "$src" ]; then
    echo "⚠️  Missing template: $src (skipping)"
    return
  fi

  cp "$src" "$dst"
  echo "✅ Created docs/graph/$name.md"
}

copy_graph "product-app"
copy_graph "marketing-website"
copy_graph "blog"

echo
echo "📦 Installing Tailwind CSS and ShadCN dependencies..."
pm_add_dev tailwindcss postcss autoprefixer @radix-ui/react-slot class-variance-authority clsx tailwind-merge
echo "✅ Installed Tailwind and ShadCN dependencies"

echo
echo "📦 Installing Playwright for E2E testing..."
pm_add_dev @playwright/test
echo "✅ Installed Playwright"

echo
echo "🎨 Applying app templates (ShadCN UI, auth, integrations, widgets)..."
mkdir -p apps/app/src/auth
mkdir -p apps/app/src/components/ui
mkdir -p apps/app/src/integrations
mkdir -p apps/app/src/widgets
mkdir -p apps/app/src/lib

# Copy App.tsx and styling
cp "$PIP_DIR/resources/nx-product-surfaces/App.tsx" apps/app/src/app/app.tsx
cp "$PIP_DIR/resources/nx-product-surfaces/app.css" apps/app/src/app/app.css

# Copy auth templates
cp "$PIP_DIR/resources/nx-product-surfaces/auth/auth-session.tsx" apps/app/src/auth/auth-session.tsx
cp "$PIP_DIR/resources/nx-product-surfaces/auth/auth-adapter.tsx" apps/app/src/auth/auth-adapter.tsx

# Copy ShadCN UI components
cp "$PIP_DIR/resources/nx-product-surfaces/components/ui/button.tsx" apps/app/src/components/ui/button.tsx
cp "$PIP_DIR/resources/nx-product-surfaces/components/ui/input.tsx" apps/app/src/components/ui/input.tsx

# Copy integrations
cp "$PIP_DIR/resources/nx-product-surfaces/integrations/integration-settings.ts" apps/app/src/integrations/integration-settings.ts
cp "$PIP_DIR/resources/nx-product-surfaces/integrations/use-integration-settings.ts" apps/app/src/integrations/use-integration-settings.ts

# Copy widgets
cp "$PIP_DIR/resources/nx-product-surfaces/widgets/repos-widget.tsx" apps/app/src/widgets/repos-widget.tsx

# Copy utilities
cp "$PIP_DIR/resources/nx-product-surfaces/lib/utils.ts" apps/app/src/lib/utils.ts

echo "✅ Applied all templates"

echo
echo "⚙️  Configuring Tailwind CSS..."
cat > tailwind.config.js <<'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./apps/*/src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
      },
      colors: {
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
      },
    },
  },
  plugins: [],
}
EOF
echo "✅ Created tailwind.config.js"

echo
echo "⚙️  Configuring path aliases (@/)..."
if [ -f "tsconfig.base.json" ]; then
  # Update tsconfig.base.json to add path alias
  node -e "
    const fs = require('fs');
    const tsconfig = JSON.parse(fs.readFileSync('tsconfig.base.json', 'utf8'));
    if (!tsconfig.compilerOptions.paths) tsconfig.compilerOptions.paths = {};
    tsconfig.compilerOptions.paths['@/*'] = ['apps/app/src/*'];
    fs.writeFileSync('tsconfig.base.json', JSON.stringify(tsconfig, null, 2));
  "
  echo "✅ Updated tsconfig.base.json with @/* path alias"
else
  echo "⚠️  tsconfig.base.json not found, skipping path alias config"
fi

echo

echo "✨ Product surfaces scaffold complete!"
echo

echo "Next steps:"
echo "  1) Initialize Playwright: npx playwright install"
echo "  2) (Optional) Apply infra: ./.pip/bin/apply-nx-dev-infra.sh"
echo "  3) Start app: nx serve app"
echo "  4) Start marketing: nx serve marketing"
echo "  5) Run E2E tests: npx playwright test"
echo "  6) Choose auth provider by implementing an adapter behind libs/auth"
echo ""
