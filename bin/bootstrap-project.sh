#!/usr/bin/env bash
set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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
cp .pip/docs/activity-log.md docs/activity-log.md
echo -e "${GREEN}✅ Created docs/activity-log.md${NC}"

cp .pip/docs/changelog.md docs/changelog.md
# Customize changelog with project name
sed -i '' "s/All notable changes to the website\/app are documented here./All notable changes to ${PROJECT_NAME} are documented here./" docs/changelog.md
echo -e "${GREEN}✅ Created docs/changelog.md${NC}"

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

### Framework Documentation  
- [.pip Framework](./.pip/README.md) - Framework overview
- [Using .pip as Genome](./.pip/docs/using-pip-as-genome.md) - Detailed usage guide
- [Fragment System](./.pip/docs/fragments-guide.md) - Infrastructure scaffolding

## Getting Started

\`\`\`bash
# Initialize Nx workspace
npx nx@latest init --integrated
pnpm init
pnpm add -D nx @nx/workspace

# Apply infrastructure fragment
./.pip/bin/apply-nx-dev-infra.sh

# Start development environment
nx run infra:up
\`\`\`

## Status

🚧 **In Development** - Project bootstrapped $(date +%Y-%m-%d)

---

**Primary User**: ${PRIMARY_USER}  
**Project Type**: ${PROJECT_TYPE_TEXT}
EOF

echo -e "${GREEN}✅ Created README.md${NC}"

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
echo "  • README with your project story"
echo
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review and customize docs/mission.md"
echo "  2. Initialize Nx: npx nx@latest init --integrated"
echo "  3. Apply infrastructure: ./.pip/bin/apply-nx-dev-infra.sh"
echo "  4. Start building!"
echo
echo -e "${BLUE}Happy building! 🚀${NC}"
echo
