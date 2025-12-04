#!/usr/bin/env bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PIP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET_DIR="$(pwd)"

echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    .pip Project Bootstrap Wizard 🚀          ║${NC}"
echo -e "${BLUE}╔═══════════════════════════════════════════════╗${NC}"
echo
echo -e "${YELLOW}This wizard will help you set up .pip for your project${NC}"
echo

# Function to ask yes/no questions
ask_yes_no() {
    local prompt="$1"
    local default="${2:-n}"
    local response
    
    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi
    
    read -p "$prompt" response
    response=${response:-$default}
    if [[ "$response" =~ ^[Yy] ]]; then
        echo "true"
    else
        echo "false"
    fi
}

# Function to ask text questions with defaults
ask_text() {
    local prompt="$1"
    local default="$2"
    local response
    
    if [ -n "$default" ]; then
        read -p "$prompt [$default]: " response
        echo "${response:-$default}"
    else
        read -p "$prompt: " response
        echo "$response"
    fi
}

# Check if we're in the right place
if [ "$TARGET_DIR" = "$PIP_DIR" ]; then
    echo -e "${RED}Error: You're running this from inside the .pip directory itself${NC}"
    echo "Please run this from your project root after adding .pip as a submodule"
    exit 1
fi

# Step 1: Project Info
echo -e "${GREEN}📝 Step 1: Project Information${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

PROJECT_NAME=$(ask_text "Project name" "$(basename "$TARGET_DIR")")
PROJECT_DESCRIPTION=$(ask_text "Brief description" "")
PROJECT_TYPE=$(ask_text "Project type (product/library/service/internal)" "product")

echo

# Step 2: Agent Configuration
echo -e "${GREEN}👥 Step 2: Agent Roles${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Which agent roles do you need? (All are optional)"
echo

USE_CEO=$(ask_yes_no "CEO (mission, strategy, cross-functional decisions)" "y")
USE_CTO=$(ask_yes_no "CTO (technical architecture, delivery)" "y")
USE_CPO=$(ask_yes_no "CPO (product roadmap, outcomes)" "y")
USE_CISO=$(ask_yes_no "CISO (security, risk, compliance)" "y")
USE_CMO=$(ask_yes_no "CMO (marketing, messaging, content)" "n")
USE_CRO=$(ask_yes_no "CRO (revenue, pricing, growth)" "n")

echo

# Step 3: Product Surfaces
echo -e "${GREEN}🌐 Step 3: Product Surfaces${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

HAS_PRODUCT_APP=$(ask_yes_no "Do you have a core product/app?" "y")
HAS_MARKETING_SITE=$(ask_yes_no "Do you have a marketing website?" "n")
HAS_BLOG=$(ask_yes_no "Do you have a blog?" "n")

echo

# Step 4: Infrastructure
echo -e "${GREEN}🏗️  Step 4: Infrastructure${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

USE_NX_FRAGMENT=$(ask_yes_no "Apply Nx + Docker + Postgres dev environment?" "n")

echo

# Step 5: Environment Setup
echo -e "${GREEN}🔐 Step 5: Environment Variables${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

SETUP_ENVRC=$(ask_yes_no "Set up .envrc for direnv?" "y")

echo
echo -e "${YELLOW}═══════════════════════════════════════════════${NC}"
echo -e "${YELLOW}Ready to bootstrap! Here's what I'll do:${NC}"
echo -e "${YELLOW}═══════════════════════════════════════════════${NC}"
echo "• Project: $PROJECT_NAME ($PROJECT_TYPE)"
[ -n "$PROJECT_DESCRIPTION" ] && echo "• Description: $PROJECT_DESCRIPTION"
echo "• Agents: $(
    agents=""
    [ "$USE_CEO" = "true" ] && agents="$agents CEO"
    [ "$USE_CTO" = "true" ] && agents="$agents CTO"
    [ "$USE_CPO" = "true" ] && agents="$agents CPO"
    [ "$USE_CISO" = "true" ] && agents="$agents CISO"
    [ "$USE_CMO" = "true" ] && agents="$agents CMO"
    [ "$USE_CRO" = "true" ] && agents="$agents CRO"
    echo "$agents"
)"
echo "• Surfaces: $(
    surfaces=""
    [ "$HAS_PRODUCT_APP" = "true" ] && surfaces="$surfaces Product"
    [ "$HAS_MARKETING_SITE" = "true" ] && surfaces="$surfaces Marketing"
    [ "$HAS_BLOG" = "true" ] && surfaces="$surfaces Blog"
    [ -z "$surfaces" ] && surfaces=" None"
    echo "$surfaces"
)"
[ "$USE_NX_FRAGMENT" = "true" ] && echo "• Infrastructure: Nx + Docker + Postgres"
[ "$SETUP_ENVRC" = "true" ] && echo "• Environment: .envrc setup"
echo

PROCEED=$(ask_yes_no "Proceed with bootstrap?" "y")
if [ "$PROCEED" != "true" ]; then
    echo -e "${YELLOW}Bootstrap cancelled${NC}"
    exit 0
fi

echo
echo -e "${GREEN}🚀 Starting bootstrap...${NC}"
echo

# Create .pip directory structure
mkdir -p "$TARGET_DIR/.pip"/{mission,method,graph,ia/agents,fragments,bin,docs/{blog,processes,templates}}

# Copy base files
echo "📄 Setting up base files..."
cp "$PIP_DIR/README.md" "$TARGET_DIR/.pip/"
cp "$PIP_DIR/CONTRIBUTING.md" "$TARGET_DIR/.pip/"
cp "$PIP_DIR/INDEX.md" "$TARGET_DIR/.pip/"
cp "$PIP_DIR/fragment-prompt.md" "$TARGET_DIR/.pip/"
cp "$PIP_DIR/WARP.md" "$TARGET_DIR/.pip/"

# Copy mission
cp "$PIP_DIR/mission/mission.md" "$TARGET_DIR/.pip/mission/"
sed -i.bak "s/\[Your Product Name\]/$PROJECT_NAME/g" "$TARGET_DIR/.pip/mission/mission.md" 2>/dev/null || true
rm -f "$TARGET_DIR/.pip/mission/mission.md.bak"

# Copy method
cp "$PIP_DIR/method/delivery-method.md" "$TARGET_DIR/.pip/method/"

# Copy agent manifest
cp "$PIP_DIR/ia/agent_manifest.yml" "$TARGET_DIR/.pip/ia/"

# Copy agents based on selection
echo "👥 Setting up agent roles..."
[ "$USE_CEO" = "true" ] && cp -r "$PIP_DIR/ia/agents/ceo" "$TARGET_DIR/.pip/ia/agents/"
[ "$USE_CTO" = "true" ] && cp -r "$PIP_DIR/ia/agents/cto" "$TARGET_DIR/.pip/ia/agents/"
[ "$USE_CPO" = "true" ] && cp -r "$PIP_DIR/ia/agents/cpo" "$TARGET_DIR/.pip/ia/agents/"
[ "$USE_CISO" = "true" ] && cp -r "$PIP_DIR/ia/agents/ciso" "$TARGET_DIR/.pip/ia/agents/"
[ "$USE_CMO" = "true" ] && cp -r "$PIP_DIR/ia/agents/cmo" "$TARGET_DIR/.pip/ia/agents/"
[ "$USE_CRO" = "true" ] && cp -r "$PIP_DIR/ia/agents/cro" "$TARGET_DIR/.pip/ia/agents/"

# Copy graph files based on selection
echo "🌐 Setting up product surfaces..."
[ "$HAS_PRODUCT_APP" = "true" ] && cp "$PIP_DIR/graph/product-app.md" "$TARGET_DIR/.pip/graph/"
[ "$HAS_MARKETING_SITE" = "true" ] && cp "$PIP_DIR/graph/marketing-website.md" "$TARGET_DIR/.pip/graph/"
[ "$HAS_BLOG" = "true" ] && cp "$PIP_DIR/graph/blog.md" "$TARGET_DIR/.pip/graph/"

# Copy docs
echo "📚 Setting up documentation..."
cp "$PIP_DIR/docs/activity-log.md" "$TARGET_DIR/.pip/docs/"
cp "$PIP_DIR/docs/changelog.md" "$TARGET_DIR/.pip/docs/"
cp "$PIP_DIR/docs/glossary.md" "$TARGET_DIR/.pip/docs/"
cp "$PIP_DIR/docs/fragments-guide.md" "$TARGET_DIR/.pip/docs/"
cp -r "$PIP_DIR/docs/processes" "$TARGET_DIR/.pip/docs/"
cp -r "$PIP_DIR/docs/templates" "$TARGET_DIR/.pip/docs/"

# Set up environment
if [ "$SETUP_ENVRC" = "true" ]; then
    echo "🔐 Setting up environment..."
    if [ -f "$PIP_DIR/.envrc.example" ]; then
        cp "$PIP_DIR/.envrc.example" "$TARGET_DIR/.envrc.example"
        if [ ! -f "$TARGET_DIR/.envrc" ]; then
            cp "$TARGET_DIR/.envrc.example" "$TARGET_DIR/.envrc"
            echo "  ✅ Created .envrc (edit this with your secrets)"
        else
            echo "  ⚠️  .envrc already exists, skipping"
        fi
    fi
fi

# Apply Nx fragment if requested
if [ "$USE_NX_FRAGMENT" = "true" ]; then
    echo "🏗️  Applying Nx + Docker infrastructure..."
    "$PIP_DIR/bin/apply-nx-dev-infra.sh"
fi

echo
echo -e "${GREEN}✨ Bootstrap complete! 🎉${NC}"
echo
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review and customize .pip/mission/mission.md"
echo "  2. Update .pip/ia/agent_manifest.yml with owner assignments"
[ "$HAS_PRODUCT_APP" = "true" ] && echo "  3. Define your product flows in .pip/graph/product-app.md"
[ "$SETUP_ENVRC" = "true" ] && echo "  4. Add your secrets to .envrc"
[ "$USE_NX_FRAGMENT" = "true" ] && echo "  5. Run: nx run infra:up"
echo
echo -e "${BLUE}📖 Read .pip/README.md for full documentation${NC}"
echo
