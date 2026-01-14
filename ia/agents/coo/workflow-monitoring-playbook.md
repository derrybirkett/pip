# COO — Workflow Monitoring Playbook

## Overview

This playbook defines how the COO agent monitors, triages, and remediates CI/CD workflow failures to maintain operational excellence and delivery velocity.

## Monitoring Scope

### GitHub Actions Workflows
- **Build workflows**: Compilation, linting, type checking
- **Test workflows**: Unit, integration, E2E tests
- **Deployment workflows**: Staging, production releases
- **Automation workflows**: Scheduled jobs, dependency updates, security scans
- **Release workflows**: Tagging, changelog generation, artifact publishing

### Key Metrics
- Workflow success/failure rate
- Build duration and trends
- Queue time and concurrency limits
- Flaky test patterns
- Dependency vulnerability scan results

## Failure Triage Process

### 1. Detection
Monitor for workflow failures via:
- GitHub Actions UI (workflow run status)
- GitHub webhook events (workflow_run completed with failure)
- Scheduled polling of workflow status
- Email/Slack notifications

### 2. Classification
Categorize failures by type:

**A. Branch Conflicts** (Most Common)
- Symptom: `git push` fails with "Updates were rejected"
- Root cause: Remote branch has commits not present locally
- Remediation: COO-handled (see playbook below)

**B. Test Failures**
- Symptom: Test suite exits with non-zero code
- Root cause: Code changes break existing tests OR flaky tests
- Remediation: CTO-escalated (requires code fix or test stabilization)

**C. Dependency Issues**
- Symptom: `npm install`, `pip install`, or similar fails
- Root cause: Broken upstream dependencies, version conflicts
- Remediation: COO-handled for updates; CTO-escalated for lock file conflicts

**D. Security Scan Failures**
- Symptom: Vulnerability scanner finds CVEs above threshold
- Root cause: Known vulnerabilities in dependencies or code
- Remediation: CISO-escalated (security review required)

**E. Infrastructure/Platform Issues**
- Symptom: Timeouts, runner unavailability, rate limits
- Root cause: GitHub Actions platform issues or quota limits
- Remediation: COO-handled (retry, adjust concurrency) or CEO-escalated (budget/plan upgrade)

**F. Authentication/Secrets**
- Symptom: 401/403 errors, expired tokens
- Root cause: Expired credentials, missing secrets, permission changes
- Remediation: CISO-escalated (credential rotation)

### 3. Remediation Decision Tree

```
Workflow Failed
    ↓
Can auto-remediate? (COO decision)
    ↓
YES → Auto-remediate → Monitor → Success? → Close
    ↓                                ↓
    |                               NO → Escalate
    ↓
NO → Escalate to appropriate agent
    ↓
CTO: Code/test/tooling issues
CISO: Security/auth/compliance
CPO: Product rollback decisions
CEO: Critical business impact
```

## Auto-Remediation Playbooks

### Branch Conflict Resolution

**Scenario**: `git push` fails with "Updates were rejected"

**Steps**:
1. Fetch latest remote refs: `git fetch origin`
2. Check if remote branch exists: `git branch -r | grep <branch-name>`
3. **Option A**: Delete remote branch (if automation retry)
   ```bash
   git push origin --delete <branch-name>
   ```
4. **Option B**: Pull and merge (if preserving remote commits)
   ```bash
   git checkout <branch-name>
   git pull origin <branch-name>
   git push origin <branch-name>
   ```
5. **Option C**: Force push (⚠️ destructive - use with caution)
   ```bash
   git push -f origin <branch-name>
   ```

**Default for automation workflows**: Option A (delete and retry)

**When to escalate**: If branch contains important commits from another source

### Stale Dependency Updates

**Scenario**: Scheduled dependency update workflow fails

**Steps**:
1. Review failure logs for specific dependency causing issue
2. Check if dependency version is yanked/broken upstream
3. Pin to last known good version temporarily
4. Create issue for CTO to investigate and resolve
5. Notify CPO if feature timeline affected

**When to escalate**: Lock file conflicts, breaking API changes

### Flaky Test Detection

**Scenario**: Test passes locally but fails intermittently in CI

**Steps**:
1. Re-run workflow up to 3 times to confirm flakiness
2. If passes on retry: Mark as flaky, create issue for CTO
3. If consistently fails: Escalate to CTO immediately (real failure)
4. Track flaky test patterns for engineering team review

**When to escalate**: Always (CTO owns test quality)

### Infrastructure Timeouts

**Scenario**: Workflow times out after max duration

**Steps**:
1. Check GitHub Actions status page for platform issues
2. Review recent workflow duration trends (gradual vs. sudden)
3. If platform issue: Retry once after 15 minutes
4. If gradual trend: Create issue for CTO (optimization needed)
5. If sudden spike: Escalate to CTO (investigate code change)

**When to escalate**: Persistent timeouts, suspected code issue

## Escalation Guidelines

### When to Escalate to CTO
- Test failures requiring code changes
- Build failures from compilation/linting errors
- Architecture/tooling decisions needed
- Performance optimization required
- Flaky test patterns (for prioritization)

### When to Escalate to CISO
- Security scan failures (CVE detection)
- Authentication/credential failures
- Compliance gate failures
- Suspicious activity in workflow logs

### When to Escalate to CPO
- Feature rollback decisions
- Release timeline impact assessment
- Acceptance criteria validation needed

### When to Escalate to CEO
- Critical production incident
- Multi-hour delivery blockage
- Budget/plan limitations (runner minutes, quotas)
- Cross-functional decision needed

### When to Escalate to CMO
- Release communication delays
- Blog post publication issues
- Changelog generation failures

## Communication Templates

### Failure Alert (to relevant agent)
```
🚨 Workflow Failure Alert

Workflow: [workflow name]
Run: [link to GitHub Actions run]
Branch: [branch name]
Failure Type: [classification]
Root Cause: [brief diagnosis]

Action Required: [specific ask]
Impact: [delivery timeline, feature affected]
Priority: [P0-Critical | P1-High | P2-Medium | P3-Low]
```

### Resolution Update (to stakeholders)
```
✅ Workflow Restored

Workflow: [workflow name]
Failure Duration: [time from failure to resolution]
Remediation: [what was done]
Prevention: [follow-up actions to prevent recurrence]

Next Steps: [any outstanding work items]
```

### Incident Escalation (to CEO)
```
🔴 Critical Incident

Impact: [delivery blocked, production down, etc.]
Duration: [time since incident start]
Affected Systems: [workflows, environments, features]
Attempted Remediations: [what's been tried]

Recommendation: [course of action, resource needs, timeline]
```

## Monitoring Dashboard (Recommended)

### Real-Time Metrics
- Workflow run status (success/failure/in-progress)
- Current queue depth and wait times
- Active incidents and escalations
- Runner availability and utilization

### Historical Trends
- 30-day workflow success rate
- MTTD and MTTR by failure type
- Auto-remediation success rate
- Escalation frequency by agent

### Proactive Alerts
- Success rate drops below 95%
- MTTR exceeds 30 minutes
- Same workflow fails 3+ times in 24 hours
- Dependency vulnerability count increases
- Runner quota approaching limits

## Continuous Improvement

### Weekly Review
- Analyze failure patterns and root causes
- Identify candidates for new auto-remediation playbooks
- Review escalation accuracy (right agent, right priority)
- Update runbooks based on new failure types

### Monthly Retrospective
- Review KPIs vs. targets
- Collect feedback from CTO, CISO, CPO on escalation quality
- Identify process improvements
- Update workflow monitoring tooling and automation

### Quarterly Planning
- Roadmap for workflow reliability improvements
- Budget planning for GitHub Actions runners/plans
- Training for new failure types and remediation techniques
- Alignment with CTO on infrastructure investments

## Tools & Access Requirements

### Required Access
- GitHub Actions admin access (view/re-run workflows)
- Repository write access (branch management)
- GitHub API token (automation)
- Notification channels (email, Slack, etc.)

### Recommended Tools
- GitHub CLI (`gh`) for workflow management
- Monitoring dashboard (GitHub Actions UI, Grafana, etc.)
- Alert routing (PagerDuty, Opsgenie, etc.)
- Incident tracking (Linear, GitHub Issues)

### Automation Opportunities
- Webhook listeners for real-time failure detection
- Auto-retry logic for transient failures
- Proactive health checks before scheduled releases
- Automated incident creation and routing
