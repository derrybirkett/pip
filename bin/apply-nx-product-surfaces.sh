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

echo "✨ Product surfaces scaffold complete!"
echo

echo "Next steps:"
echo "  1) (Optional) Apply infra: ./.pip/bin/apply-nx-dev-infra.sh"
echo "  2) Start app: nx serve app"
echo "  3) Start marketing: nx serve marketing"
echo "  4) Choose auth provider later by implementing an adapter behind libs/auth"
echo ""
