# Interactive Bootstrap: From User Story to Project in 60 Seconds

**Date:** 2025-12-01  
**Version:** v0.3.0  
**Feature:** Interactive Project Bootstrap Wizard

## What's New

Starting a new project with `.pip` is now as simple as answering 6 questions. The new interactive bootstrap wizard captures your user story and automatically generates personalized project documentation—mission statement, README, activity log, and changelog—all customized to your specific project.

## The Problem

Previously, setting up a new project with `.pip` required:
1. Manually editing `docs/mission.md` with your project details
2. Customizing the `README.md` to reflect your use case
3. Understanding the template structure before making changes
4. Risk of forgetting to update key sections

This created friction at the most critical moment: project inception.

## The Solution

```bash
./.pip/bin/bootstrap-project.sh
```

One command launches an interactive wizard that asks:
1. **Project Name** - What should we call this?
2. **Who It Serves** - Your primary users
3. **Problem** - What pain point are you solving?
4. **Solution** - How does your project address it?
5. **Differentiator** - What makes it unique?
6. **Project Type** - Web app, mobile, CLI, etc.

In 60 seconds, you get:
- `docs/mission.md` with a complete mission statement
- Personalized `README.md` with your project story
- `docs/activity-log.md` ready for tracking changes
- `docs/changelog.md` customized with your project name

## Example Output

Here's what the wizard generates for "TaskFlow," a time-tracking app for freelancers:

### Generated mission.md
```markdown
# Mission: TaskFlow

## Who It Serves
- **Primary user**: Freelancers and consultants

## Problem We Solve
Tracking billable hours is tedious and error-prone

## Solution Overview
Automated time tracking with smart project switching

**Differentiator**: AI auto-categorizes tasks based on context

## Project Type
Web application
```

### Generated README.md
```markdown
# TaskFlow

Automated time tracking with smart project switching

## Problem
Tracking billable hours is tedious and error-prone

## Solution
Web application that automated time tracking with smart project switching

**What makes it different**: AI auto-categorizes tasks based on context
```

Clean, professional, and ready to build on.

## Technical Details

The bootstrap script:
- Uses colored CLI output for better UX (green prompts, blue headers, yellow status)
- Sanitizes all user input to prevent control characters in generated files
- Maps project type selections to human-readable descriptions
- Follows the genome/organism pattern—generates docs in your project, not in `.pip/`

### Implementation Highlights

```bash
# User-friendly input with printf + read (no control characters)
printf "   > "
read -r PROJECT_NAME

# Sanitize all inputs
PROJECT_NAME=$(echo "$PROJECT_NAME" | tr -d '[:cntrl:]')

# Generate personalized mission.md
cat > docs/mission.md << EOF
# Mission: ${PROJECT_NAME}
...
EOF
```

## Integration with .pip Workflow

The bootstrap wizard fits seamlessly into the recommended setup flow:

1. **Add .pip as submodule**: `git submodule add git@github.com:derrybirkett/pip.git .pip`
2. **Run bootstrap**: `./.pip/bin/bootstrap-project.sh` ← **NEW**
3. **Initialize Nx**: `npx nx@latest init --integrated`
4. **Apply infrastructure**: `./.pip/bin/apply-nx-dev-infra.sh`
5. **Start building**: `nx run infra:up`

The bootstrap step is now highlighted in the README as the recommended first step.

## Why This Matters

User stories are the foundation of product development. By capturing your story upfront, `.pip` ensures that:
- Every project starts with clear purpose and direction
- Documentation reflects actual user value, not generic templates
- The mission statement guides all future decisions
- Onboarding new team members is faster (they read your story)

This aligns perfectly with `.pip`'s LEAN methodology: **validated learning starts with understanding who you serve and what problem you're solving.**

## What's Next

Future enhancements could include:
- AI-powered mission statement refinement
- Integration with Linear for automatic issue creation based on user story
- Multi-language support for international teams
- Custom template support for different project types

## Try It Now

```bash
# In your new project directory
git submodule add git@github.com:derrybirkett/pip.git .pip
./.pip/bin/bootstrap-project.sh
```

Answer 6 questions, and you're off to the races.

---

**Links:**
- [PR #8](https://github.com/derrybirkett/pip/pull/8)
- [Commit 2e06be9](https://github.com/derrybirkett/pip/commit/2e06be9)
- [Release v0.3.0](https://github.com/derrybirkett/pip/releases/tag/v0.3.0)
- [Bootstrap Script](https://github.com/derrybirkett/pip/blob/main/bin/bootstrap-project.sh)

**Previous:** [Fragment Compatibility Fixes](./2025-12-01-fragment-compatibility-fixes.md)
