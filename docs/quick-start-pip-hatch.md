# Quick Start: pip + hatch Integration

**Goal**: Test how pip's governance framework and hatch's tooling work together in 15 minutes.

---

## Prerequisites

```bash
# Node.js 18+ and pnpm
node --version  # Should be v18+
pnpm --version  # Should be v8+

# Git
git --version
```

---

## Step 1: Install hatch (3 minutes)

```bash
# Clone hatch repository
cd ~/Projects
git clone https://github.com/derrybirkett/hatch.git
cd hatch

# Install dependencies
npm install

# Link globally for CLI access
npm link

# Verify installation
hatch --version
```

---

## Step 2: Create Test Project (2 minutes)

```bash
# Create new directory for test
mkdir -p ~/Projects/pip-hatch-demo
cd ~/Projects/pip-hatch-demo

# Use hatch to scaffold a SaaS app
hatch init task-tracker --story "A simple task management app where users can create tasks, mark them done, and filter by status"

# Navigate into generated project
cd task-tracker
```

**Expected output**: Nx monorepo with apps/, libs/, e2e/ directories created.

---

## Step 3: Add pip Governance Layer (2 minutes)

```bash
# Initialize pip governance in the project
# Copy pip framework into .pip/ directory
cp -r ~/Projects/mnspc/pip/.pip .

# Or clone fresh:
# git clone https://github.com/derrybirkett/pip.git .pip

# Verify governance files exist
ls -la .pip/ia/
ls -la .pip/mission/
ls -la .pip/method/
ls -la .pip/patterns/
```

---

## Step 4: Define Mission (3 minutes)

Edit `.pip/mission/mission.md`:

```markdown
# Mission

## Who It Serves
- Primary: Individual developers tracking personal tasks
- Secondary: Small teams (2-5 people)

## Problem We Solve
- Too many task managers are overly complex
- Need something faster than Todoist, simpler than Jira
- Want keyboard shortcuts and instant search

## Solution Overview
- Minimal task board with 3 columns (Todo, In Progress, Done)
- Cmd+K quick add
- Real-time sync across devices
- Mobile-responsive

## Vision & Outcomes
- Vision: The fastest task manager for developers
- Outcomes:
  1. New users create first task within 30 seconds
  2. Average task creation time: <5 seconds
  3. 70% of users return next day

## Success Metrics
- Task creation time: <5s average
- Daily active users: >40% of sign-ups
- 7-day retention: >50%
```

---

## Step 5: Verify hatch Foundation (3 minutes)

```bash
# Install dependencies
pnpm install

# Start all development servers
pnpm dev

# Verify running (in browser):
# ✓ Marketing website:  http://localhost:3001
# ✓ Dashboard (main app): http://localhost:3000  
# ✓ API:                 http://localhost:3333

# In another terminal, run E2E tests
pnpm test:e2e

# Expected: Auth flow tests pass (login, signup, logout)
```

---

## Step 6: Apply Agentic Pattern (2 minutes)

**Scenario**: Implement task CRUD using pip's Tool Use pattern

Edit `.pip/docs/activity-log.md`:

```markdown
| Date | Agent | What | Why |
|------|-------|------|-----|
| 2026-03-09 | Backend Dev | Add Task CRUD API | Enable task creation, reading, updating, deleting |
```

**Tool Use Pattern**:

```yaml
Thought: Need to add tasks to database
Action: Update Prisma schema
Tool: apps/api/prisma/schema.prisma
Code: |
  model Task {
    id        String   @id @default(cuid())
    title     String
    status    String   @default("todo")
    userId    String
    createdAt DateTime @default(now())
    updatedAt DateTime @updatedAt
    
    user User @relation(fields: [userId], references: [id])
    @@index([userId])
  }

Observation: Schema updated
Action: Run migration
Command: nx run api:prisma:migrate -- dev --name add_tasks
Result: Migration successful ✅
```

---

## Step 7: Validate Integration (5 minutes)

**Check pip governance active**:

```bash
# Verify agent manifest
cat .pip/ia/agent_manifest.yml | grep -A 5 "cto:"

# Verify patterns available
ls .pip/patterns/agent-workflows/

# Output should show: react-pattern.md, tool-use-pattern.md, etc.
```

**Check hatch tooling works**:

```bash
# Build succeeds
pnpm build

# Linting configured
pnpm lint

# Type checking works
pnpm type-check

# Docker setup exists
ls docker-compose.yml
ls apps/*/Dockerfile*
```

**Integration success criteria**:

- [ ] hatch generated working Nx monorepo
- [ ] All apps start without errors (`pnpm dev`)
- [ ] E2E tests pass
- [ ] pip mission.md defines product direction
- [ ] pip agent_manifest.yml shows decision rights
- [ ] pip patterns/ directory available for agent use
- [ ] Can trace feature from mission → implementation using both layers

---

## What Just Happened?

**hatch provided**:
- ✅ Complete working codebase (3 apps, 3 libs)
- ✅ Authentication system (JWT, login/signup pages)
- ✅ UI component library (buttons, inputs, cards)
- ✅ API framework (NestJS with Prisma)
- ✅ Testing infrastructure (Playwright E2E)
- ✅ DevOps setup (Docker, GitHub Actions)

**pip provided**:
- ✅ Mission statement (who, what, why, success metrics)
- ✅ Delivery methodology (data models → APIs → UI sequence)
- ✅ Agent governance (CEO/CTO/CPO decision rights)
- ✅ Agentic patterns (ReAct, Tool Use, Planning, Reflection)
- ✅ Activity logging framework
- ✅ Decision traceability

**Together**:
- You can go from idea → deployed product in days, not weeks
- AI agents have clear governance (pip) and tools (hatch)
- All decisions are traceable (activity-log.md)
- Code quality is enforced (linting, type-checking, testing)

---

## Next Steps

**Option 1: Build a feature using agentic patterns**

Follow [testing-pip-hatch-integration.md](./testing-pip-hatch-integration.md) Phase 3 to implement a feature using pip's ReAct or Multi-Agent Collaboration patterns.

**Option 2: Deploy to production**

```bash
# Commit generated code
git add .
git commit -m "feat: initial task tracker from hatch + pip governance"

# Push to GitHub
gh repo create task-tracker --public --source=. --remote=origin
git push -u origin main

# Deploy using GitHub Actions (already configured by hatch)
# Or manually deploy to Vercel/Railway:
# - apps/website → Vercel
# - apps/dashboard → Vercel  
# - apps/api → Railway
```

**Option 3: Extend with custom features**

```bash
# Generate new component using Nx
nx generate @nx/react:component TaskCard --project=ui

# Generate new API endpoint
nx generate @nestjs/schematics:resource comments --project=api

# Document decision in pip
echo "| 2026-03-09 | CTO | Added comments feature | Enable task collaboration |" >> .pip/docs/activity-log.md
```

---

## Troubleshooting

**hatch command not found**:
```bash
npm link --force
which hatch  # Should show path
```

**pnpm install fails**:
```bash
# Clear cache and retry
pnpm store prune
rm -rf node_modules
pnpm install
```

**Ports already in use**:
```bash
# Kill processes on ports 3000, 3001, 3333
lsof -ti:3000 -ti:3001 -ti:3333 | xargs kill -9

# Or change ports in apps/*/project.json
```

**Tests fail**:
```bash
# Install Playwright browsers
npx playwright install

# Run tests with UI mode for debugging
pnpm test:e2e --ui
```

---

## Summary

You've now tested the pip + hatch integration:

1. ✅ **hatch** scaffolded complete technical foundation (15 min vs 2-3 weeks manual)
2. ✅ **pip** provided governance framework for agent coordination
3. ✅ Together they enable rapid idea → product iteration
4. ✅ All code is production-ready, tested, and documented

**Time saved**: ~4 weeks of boilerplate setup  
**Quality gain**: Best practices baked in (TypeScript, testing, security, accessibility)  
**Agentic efficiency**: AI agents can coordinate using pip patterns on hatch foundation

Ready to build your product! 🚀
