#!/usr/bin/env bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ensure_line_in_file() {
  local line="$1"
  local file="$2"

  if [ ! -f "$file" ]; then
    touch "$file"
  fi

  if ! grep -qxF "$line" "$file"; then
    echo "$line" >> "$file"
  fi
}

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                                                                ║${NC}"
echo -e "${BLUE}║              .pip Project Bootstrap Assistant                  ║${NC}"
echo -e "${BLUE}║                                                                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${YELLOW}Let's set up your project! I'll ask a few questions to create"
echo -e "your mission statement and bootstrap your documentation.${NC}"
echo
echo "────────────────────────────────────────────────────────────────"
echo

# Get project information
echo -e "${GREEN}1. Project Name${NC}"
echo "   What should we call this project?"
printf "   > "
read -r PROJECT_NAME
echo

echo -e "${GREEN}2. Who Does This Serve?${NC}"
echo "   Who is the primary user or customer?"
echo "   Example: 'Small business owners', 'Mobile developers', 'Fitness enthusiasts'"
printf "   > "
read -r PRIMARY_USER
echo

echo -e "${GREEN}3. What Problem Are You Solving?${NC}"
echo "   What specific pain point does this address?"
echo "   Example: 'Manually tracking inventory takes hours each week'"
printf "   > "
read -r PROBLEM
echo

echo -e "${GREEN}4. What's Your Solution?${NC}"
echo "   How does your project solve this problem?"
echo "   Example: 'Automated inventory tracking with real-time sync'"
printf "   > "
read -r SOLUTION
echo

echo -e "${GREEN}5. What Makes It Different?${NC}"
echo "   What's your unique differentiator?"
echo "   Example: 'Works offline-first with no monthly subscription'"
printf "   > "
read -r DIFFERENTIATOR
echo

echo -e "${GREEN}6. What Type of Project?${NC}"
echo "   1) Web App"
echo "   2) Mobile App"  
echo "   3) Full-stack (Web + API)"
echo "   4) API/Backend Service"
echo "   5) CLI Tool"
echo "   6) Other"
printf "   > "
read -r PROJECT_TYPE
echo

# Strip control characters from all inputs
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr -d '[:cntrl:]')
PRIMARY_USER=$(echo "$PRIMARY_USER" | tr -d '[:cntrl:]')
PROBLEM=$(echo "$PROBLEM" | tr -d '[:cntrl:]')
SOLUTION=$(echo "$SOLUTION" | tr -d '[:cntrl:]')
DIFFERENTIATOR=$(echo "$DIFFERENTIATOR" | tr -d '[:cntrl:]')
PROJECT_TYPE=$(echo "$PROJECT_TYPE" | tr -d '[:cntrl:]')

# Determine project type text
case $PROJECT_TYPE in
  1) PROJECT_TYPE_TEXT="Web application" ;;
  2) PROJECT_TYPE_TEXT="Mobile application" ;;
  3) PROJECT_TYPE_TEXT="Full-stack application" ;;
  4) PROJECT_TYPE_TEXT="API/Backend service" ;;
  5) PROJECT_TYPE_TEXT="CLI tool" ;;
  *) 
    echo "   What type of project is it?"
    printf "   > "
    read -r PROJECT_TYPE_TEXT
    PROJECT_TYPE_TEXT=$(echo "$PROJECT_TYPE_TEXT" | tr -d '[:cntrl:]')
    ;;
esac
echo

echo "────────────────────────────────────────────────────────────────"
echo -e "${YELLOW}Creating your project documentation...${NC}"
echo

# Create docs directory
mkdir -p docs

# Generate mission.md
cat > docs/mission.md << EOF
# Mission: ${PROJECT_NAME}

## Who It Serves
- **Primary user**: ${PRIMARY_USER}

## Problem We Solve
${PROBLEM}

## Solution Overview
${SOLUTION}

**Differentiator**: ${DIFFERENTIATOR}

## Project Type
${PROJECT_TYPE_TEXT}

## Why It Matters (Vision & Outcomes)
- **Vision**: <Describe where you want to be in 12-24 months>
- **Outcomes**: 
  1. <First measurable outcome>
  2. <Second measurable outcome>
  3. <Third measurable outcome>
- **Success metrics**: <Quantified targets and leading indicators>

## Non-Goals
- <Explicitly list what we are NOT doing>

## Current Status
- **Lifecycle stage**: Discovery
- **Next milestone**: <Date and objective>
EOF

echo -e "${GREEN}✅ Created docs/mission.md${NC}"

# Copy activity log and changelog templates
cp .pip/docs/templates/organism-activity-log.md docs/activity-log.md
echo -e "${GREEN}✅ Created docs/activity-log.md${NC}"

cp .pip/docs/templates/organism-changelog.md docs/changelog.md
# Customize changelog with project name
sed -i '' "s/\[Project Name\]/${PROJECT_NAME}/g" docs/changelog.md
echo -e "${GREEN}✅ Created docs/changelog.md${NC}"

# Copy agentic workflow playbook
if [ -f ".pip/docs/templates/organism-agentic.md" ]; then
  cp .pip/docs/templates/organism-agentic.md docs/agentic.md
  echo -e "${GREEN}✅ Created docs/agentic.md${NC}"
fi

# Seed development guide
if [ -f ".pip/docs/templates/organism-dev.md" ]; then
  cp .pip/docs/templates/organism-dev.md docs/dev.md
  echo -e "${GREEN}✅ Created docs/dev.md${NC}"
fi

# Seed local env conventions (direnv)
if [ -f ".pip/docs/templates/organism-envrc.example" ]; then
  cp .pip/docs/templates/organism-envrc.example .envrc.example
  echo -e "${GREEN}✅ Created .envrc.example${NC}"
  ensure_line_in_file ".envrc" ".gitignore"
  ensure_line_in_file ".direnv/" ".gitignore"
fi

# Seed SECURITY.md
if [ -f ".pip/docs/templates/organism-security.md" ]; then
  cp .pip/docs/templates/organism-security.md SECURITY.md
  echo -e "${GREEN}✅ Created SECURITY.md${NC}"
fi

# Seed GitHub issue templates + CODEOWNERS stub
mkdir -p .github/ISSUE_TEMPLATE

if [ -f ".pip/docs/templates/organism-issue-bug.yml" ]; then
  cp .pip/docs/templates/organism-issue-bug.yml .github/ISSUE_TEMPLATE/bug_report.yml
  echo -e "${GREEN}✅ Created .github/ISSUE_TEMPLATE/bug_report.yml${NC}"
fi

if [ -f ".pip/docs/templates/organism-issue-feature.yml" ]; then
  cp .pip/docs/templates/organism-issue-feature.yml .github/ISSUE_TEMPLATE/feature_request.yml
  echo -e "${GREEN}✅ Created .github/ISSUE_TEMPLATE/feature_request.yml${NC}"
fi

if [ -f ".pip/docs/templates/organism-codeowners" ]; then
  cp .pip/docs/templates/organism-codeowners .github/CODEOWNERS
  echo -e "${GREEN}✅ Created .github/CODEOWNERS${NC}"
fi

# Seed GitHub repo hygiene (workflows + PR template)
mkdir -p .github/workflows

if [ -f ".pip/docs/templates/organism-validate-docs.yml" ]; then
  cp .pip/docs/templates/organism-validate-docs.yml .github/workflows/validate-docs.yml
  echo -e "${GREEN}✅ Created .github/workflows/validate-docs.yml${NC}"
fi

if [ -f ".pip/docs/templates/organism-pull-request-template.md" ]; then
  cp .pip/docs/templates/organism-pull-request-template.md .github/PULL_REQUEST_TEMPLATE.md
  echo -e "${GREEN}✅ Created .github/PULL_REQUEST_TEMPLATE.md${NC}"
fi

# Create README.md
cat > README.md << EOF
# ${PROJECT_NAME}

${SOLUTION}

## Problem

${PROBLEM}

## Solution

${PROJECT_TYPE_TEXT} that ${SOLUTION,,}

**What makes it different**: ${DIFFERENTIATOR}

## Documentation

This project uses \`.pip\` as an immutable template (genome):
- \`.pip/\` - Framework templates and guides (DO NOT MODIFY)
- \`docs/\` - This project's actual documentation

### Project Documentation
- [Mission](./docs/mission.md) - Project purpose and vision
- [Activity Log](./docs/activity-log.md) - Historical record of changes
- [Changelog](./docs/changelog.md) - User-facing release notes
- [Agentic Workflow](./docs/agentic.md) - How to use agents with a human in the loop

### Framework Documentation  
- [.pip Framework](./.pip/README.md) - Framework overview
- [Using .pip as Genome](./.pip/docs/using-pip-as-genome.md) - Detailed usage guide
- [Fragment System](./.pip/docs/fragments-guide.md) - Infrastructure scaffolding

## Getting Started

### Option A: Docs-only (start lean)

- Customize your mission: \`docs/mission.md\`
- Keep your activity log + changelog current as you ship

### Option B: Nx SaaS scaffold (marketing + app + auth boundary)

\`\`\`bash
# Initialize Nx (if not already)
npx nx@latest init --integrated

# (Optional) Dev infra
./.pip/bin/apply-nx-dev-infra.sh

# Product surfaces
./.pip/bin/apply-nx-product-surfaces.sh

# Run
nx serve app
nx serve marketing
\`\`\`

## Status

🚧 **In Development** - Project bootstrapped $(date +%Y-%m-%d)

---

**Primary User**: ${PRIMARY_USER}  
**Project Type**: ${PROJECT_TYPE_TEXT}
EOF

echo -e "${GREEN}✅ Created README.md${NC}"

# Create .cursorrules from template
if [ -f ".pip/.cursorrules.example" ]; then
  sed "s/\[Project Name\]/${PROJECT_NAME}/g" .pip/.cursorrules.example > .cursorrules
  echo -e "${GREEN}✅ Created .cursorrules${NC}"
fi

echo
echo "────────────────────────────────────────────────────────────────"
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║                                                                ║${NC}"
echo -e "${BLUE}║                    Bootstrap Complete! 🎉                      ║${NC}"
echo -e "${BLUE}║                                                                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════╝${NC}"
echo
echo -e "${GREEN}Your project has been bootstrapped with:${NC}"
echo "  • Mission statement (docs/mission.md)"
echo "  • Activity log (docs/activity-log.md)"
echo "  • Changelog (docs/changelog.md)"
echo "  • Agentic workflow playbook (docs/agentic.md)"
echo "  • Dev guide template (docs/dev.md)"
echo "  • Local env example (.envrc.example)"
echo "  • Security policy (SECURITY.md)"
echo "  • Docs hygiene workflow (.github/workflows/validate-docs.yml)"
echo "  • Pull request template (.github/PULL_REQUEST_TEMPLATE.md)"
echo "  • Issue templates + CODEOWNERS stub (.github/*)"
echo "  • README with your project story"
echo "  • Cursor AI rules (.cursorrules)"
echo
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review and customize docs/mission.md"
echo "  2. (Optional) Initialize Nx: npx nx@latest init --integrated"
echo "  3. (Optional) Apply infra: ./.pip/bin/apply-nx-dev-infra.sh"
echo "  4. Scaffold product surfaces: ./.pip/bin/apply-nx-product-surfaces.sh"
echo "  5. Start app + marketing: nx serve app / nx serve marketing"
echo
echo -e "${BLUE}Happy building! 🚀${NC}"
echo
