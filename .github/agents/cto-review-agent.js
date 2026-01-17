#!/usr/bin/env node

/**
 * CTO Review Agent - Technical code review
 * Reviews PRs for code quality, architecture, and best practices
 */

const { execSync } = require('child_process');
const OpenAI = require('openai');

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

const CONFIG = {
  model: 'gpt-4-turbo-preview',
  maxTokens: 2000,
  temperature: 0.2,
};

function exec(command, options = {}) {
  try {
    const result = execSync(command, {
      encoding: 'utf8',
      stdio: options.silent ? 'pipe' : 'inherit',
      ...options,
    });
    return result ? result.trim() : '';
  } catch (error) {
    console.error(`Command failed: ${command}`);
    throw error;
  }
}

/**
 * Get PR details and diff
 */
function getPRDetails() {
  console.log('📋 Fetching PR details...');
  
  const prNumber = process.env.PR_NUMBER;
  const prJson = exec(`gh pr view ${prNumber} --json number,title,body,author,files,additions,deletions`, { silent: true });
  const pr = JSON.parse(prJson);
  
  // Get diff
  const diff = exec(`gh pr diff ${prNumber}`, { silent: true });
  
  return { ...pr, diff };
}

/**
 * Perform CTO review using OpenAI
 */
async function performCTOReview(pr) {
  console.log('\n🔍 CTO performing technical review...');

  const prompt = `You are a CTO reviewing a pull request. Analyze this PR for technical quality.

**PR #${pr.number}: ${pr.title}**

${pr.body || 'No description provided'}

**Author:** ${pr.author.login}
**Changes:** +${pr.additions} -${pr.deletions}

**Diff:**
\`\`\`diff
${pr.diff.slice(0, 8000)}
\`\`\`

**Review Focus:**
1. Code quality and maintainability
2. Architecture alignment with .pip principles (small, incremental changes)
3. Performance implications
4. Test coverage (if tests modified/added)
5. Breaking changes
6. Documentation needs
7. Best practices adherence

**Response Format (JSON only):**
{
  "decision": "APPROVE|COMMENT|REQUEST_CHANGES",
  "summary": "Brief overall assessment",
  "issues": [
    {
      "severity": "critical|major|minor|suggestion",
      "category": "architecture|performance|testing|documentation|best-practice",
      "title": "Issue title",
      "description": "Detailed explanation",
      "suggestion": "How to fix it",
      "files_affected": "Optional: specific files or areas to address"
    }
  ]
}

**Severity Guidelines:**
- **critical**: Must fix before merge - blocks security/functionality/data integrity
- **major**: Should fix before merge - significant technical debt or maintainability issue
- **minor**: Should fix soon but doesn't block - small improvements that reduce risk
- **suggestion**: Nice-to-have enhancement - best practices, optimizations, future improvements

**Decision Guidelines:**
- APPROVE if no critical/major issues (minor and suggestions are OK)
- COMMENT for minor issues that don't block merge
- REQUEST_CHANGES only for critical issues that must be fixed
- Use "suggestion" severity for enhancements that can be tracked as separate issues
- Be constructive and specific
- Consider .pip principles: small, strategic, measurable changes

  try {
    const response = await openai.chat.completions.create({
      model: CONFIG.model,
      messages: [
        {
          role: 'system',
          content: 'You are an experienced CTO reviewing code. Be thorough but constructive. Respond only with valid JSON.',
        },
        {
          role: 'user',
          content: prompt,
        },
      ],
      max_tokens: CONFIG.maxTokens,
      temperature: CONFIG.temperature,
    });

    const content = response.choices[0].message.content.trim();
    const jsonMatch = content.match(/```(?:json)?\s*([\s\S]*?)```/) || [null, content];
    const jsonContent = jsonMatch[1] || content;
    
    return JSON.parse(jsonContent);
  } catch (error) {
    console.error('❌ OpenAI API error:', error.message);
    throw error;
  }
}

/**
 * Post review to GitHub
 */
function postReview(prNumber, review, createdIssues = []) {
  console.log(`\n📝 Posting ${review.decision} review...`);

  let reviewBody = `## 🏗️ CTO Technical Review

${review.summary}

`;

  if (review.issues.length > 0) {
    const critical = review.issues.filter(i => i.severity === 'critical');
    const major = review.issues.filter(i => i.severity === 'major');
    const minor = review.issues.filter(i => i.severity === 'minor');
    const suggestions = review.issues.filter(i => i.severity === 'suggestion');

    if (critical.length > 0) {
      reviewBody += `### 🔴 Critical Issues\n\n`;
      critical.forEach(issue => {
        reviewBody += `**${issue.title}** (${issue.category})\n${issue.description}\n\n💡 **Suggestion:** ${issue.suggestion}\n\n`;
      });
    }

    if (major.length > 0) {
      reviewBody += `### 🟡 Major Issues\n\n`;
      major.forEach(issue => {
        reviewBody += `**${issue.title}** (${issue.category})\n${issue.description}\n\n💡 **Suggestion:** ${issue.suggestion}\n\n`;
      });
    }

    if (minor.length > 0) {
      reviewBody += `### 🔵 Minor Issues\n\n`;
      minor.forEach(issue => {
        reviewBody += `**${issue.title}** (${issue.category})\n${issue.description}\n\n💡 **Suggestion:** ${issue.suggestion}\n\n`;
      });
    }

    if (suggestions.length > 0) {
      reviewBody += `### 💭 Suggestions\n\n`;
      suggestions.forEach(issue => {
        reviewBody += `**${issue.title}** (${issue.category})\n${issue.description}\n\n💡 **Suggestion:** ${issue.suggestion}\n\n`;
      });
    }
  } else {
    reviewBody += `✅ No issues found. Code looks good!\n\n`;
  }

  // Add links to created enhancement issues
  if (createdIssues.length > 0) {
    reviewBody += `\n---\n\n📋 **Enhancement Issues Created**: ${createdIssues.map(num => `#${num}`).join(', ')}\n\n`;
  }

  reviewBody += `---\n*Automated review by CTO Agent*`;

  // Post review comment
  try {
    exec(`gh pr review ${prNumber} --comment --body "${reviewBody.replace(/"/g, '\\"')}"`);
    console.log('✅ Review posted');
  } catch (error) {
    console.error('⚠️  Failed to post review, trying as comment...');
    exec(`gh pr comment ${prNumber} --body "${reviewBody.replace(/"/g, '\\"')}"`);
  }
}

/**
 * Create issues for agent suggestions
 * Only creates issues for 'suggestion' and 'minor' severity items
 * Returns array of created issue numbers
 */
function createIssuesForSuggestions(prNumber, prTitle, review) {
  if (!review.issues || review.issues.length === 0) return [];

  console.log('\n📋 Creating enhancement issues from review...');
  const createdIssues = [];

  // Only create issues for suggestions and minor items
  // Major and critical should be addressed in the PR itself
  const enhancementIssues = review.issues.filter(
    issue => issue.severity === 'suggestion' || issue.severity === 'minor'
  );

  if (enhancementIssues.length === 0) {
    console.log('  No enhancement issues to create (only major/critical found)');
    return [];
  }

  enhancementIssues.forEach((issue) => {
    const severityLabel = issue.severity === 'minor' ? 'priority-medium' : 'priority-low';
    const categoryLabel = issue.category || 'technical-debt';
    
    // Enhanced issue body with better structure for agent pickup
    const issueBody = `## 🔍 Enhancement from CTO Review

**Source:** PR #${prNumber} - ${prTitle}
**Severity:** ${issue.severity}
**Category:** ${issue.category}
${issue.files_affected ? `**Files/Areas:** ${issue.files_affected}` : ''}

### Description
${issue.description}

### Suggested Implementation
${issue.suggestion}

### Context
This enhancement was identified during code review but does not block the PR merge. It represents a ${issue.severity === 'minor' ? 'small improvement' : 'nice-to-have optimization'} that can be addressed in a future iteration.

### Next Steps
- [ ] CPO: Review and approve for roadmap inclusion
- [ ] If approved: Assign to autonomous agent or manual pickup
- [ ] Implement suggested changes
- [ ] Link back to this issue in implementation PR

---
**Created by:** CTO Review Agent  
**Status:** Awaiting CPO triage`;

    const issueTitle = issue.title;

    try {
      // Create issue and capture the issue number from output
      const result = exec(
        `gh issue create --title "${issueTitle.replace(/"/g, '\\"')}" --body "${issueBody.replace(/"/g, '\\"')}" --label "enhancement,from-cto-review,needs-cpo-triage,${severityLabel},${categoryLabel}"`,
        { silent: true }
      );
      
      // Extract issue number from URL (e.g., "https://github.com/owner/repo/issues/123")
      const issueMatch = result.match(/\/issues\/(\d+)/);
      if (issueMatch) {
        const issueNumber = issueMatch[1];
        createdIssues.push(issueNumber);
        console.log(`  ✅ Issue #${issueNumber}: ${issue.title}`);
      }
    } catch (error) {
      console.error(`  ⚠️  Failed to create issue: ${issue.title}`);
    }
  });

  console.log(`\n  Created ${createdIssues.length} enhancement issue(s)`);
  return createdIssues;
}

/**
 * Main execution
 */
async function main() {
  console.log('🚀 CTO Review Agent Starting...\n');

  try {
    // Get PR details
    const pr = getPRDetails();
    console.log(`  PR #${pr.number}: ${pr.title}`);
    console.log(`  Author: ${pr.author.login}`);
    console.log(`  Changes: +${pr.additions} -${pr.deletions}`);

    // Perform review
    const review = await performCTOReview(pr);
    console.log(`\n✨ Review complete: ${review.decision}`);
    console.log(`  Issues found: ${review.issues.length}`);

    // Create enhancement issues for suggestions (for CPO triage)
    const createdIssues = createIssuesForSuggestions(pr.number, pr.title, review);

    // Post review with links to created issues
    postReview(pr.number, review, createdIssues);

    // Set output for workflow
    const shouldBlock = review.decision === 'REQUEST_CHANGES';
    console.log(`\n🚦 Should block merge: ${shouldBlock}`);
    
    // Write to GitHub Actions output
    if (process.env.GITHUB_OUTPUT) {
      require('fs').appendFileSync(
        process.env.GITHUB_OUTPUT,
        `should_block=${shouldBlock}\n`
      );
    }

    console.log('\n🎉 CTO review complete!');
  } catch (error) {
    console.error('\n❌ Error:', error.message);
    process.exit(1);
  }
}

if (require.main === module) {
  main();
}

module.exports = { main };
