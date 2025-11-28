#!/usr/bin/env bash
set -e

PIP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FRAGMENT_DIR="$PIP_DIR/fragments/nx-dev-infra/files"
TARGET_DIR="$(pwd)"

echo "🚀 Applying nx-dev-infra fragment from $FRAGMENT_DIR to $TARGET_DIR"
echo

# Copy scaffold root files (don't overwrite existing)
if [ -f "$TARGET_DIR/Dockerfile.dev" ]; then
  echo "⚠️  Dockerfile.dev already exists, skipping"
else
  cp "$FRAGMENT_DIR/Dockerfile.dev" "$TARGET_DIR/Dockerfile.dev"
  echo "✅ Created Dockerfile.dev"
fi

if [ -f "$TARGET_DIR/docker-compose.yml" ]; then
  echo "⚠️  docker-compose.yml already exists, skipping"
else
  cp "$FRAGMENT_DIR/docker-compose.yml" "$TARGET_DIR/docker-compose.yml"
  echo "✅ Created docker-compose.yml"
fi

# Create the Nx tools/infra folder structure
mkdir -p "$TARGET_DIR/tools/infra"

# Copy project.json into the project
if [ -f "$TARGET_DIR/tools/infra/project.json" ]; then
  echo "⚠️  tools/infra/project.json already exists, skipping"
else
  cp "$FRAGMENT_DIR/tools/infra/project.json" "$TARGET_DIR/tools/infra/project.json"
  echo "✅ Created tools/infra/project.json"
fi

echo
echo "✨ Nx + Docker dev scaffold applied successfully!"
echo
echo "Next steps:"
echo "  1. Run: nx run infra:up"
echo "  2. Then: docker exec -it monospace-dev bash"
echo "  3. Inside container: pnpm install, nx serve web, etc."
echo
echo "Services:"
echo "  • PostgreSQL: localhost:5432 (nexus/nexus)"
echo "  • n8n: http://localhost:5678"
echo
