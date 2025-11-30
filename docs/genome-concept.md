# The .pip Genome Concept

## What is the Genome Model?

`.pip` functions as a **project genome** - a living instruction system embedded as a git submodule that provides the DNA for how your project operates. Just as biological DNA contains instructions for building and operating an organism, `.pip` contains the instructions for building and operating your software project.

## Why Submodule Architecture?

### Separation of Concerns
- **Host Repository**: Your actual project code (application, service, library)
- **.pip Submodule**: The operational system (governance, processes, standards)

This separation ensures:
- Your project code stays focused on business logic
- Operational standards remain consistent across projects
- Updates to processes can be pulled from upstream
- Each project can customize while maintaining a common foundation

### Version Control Benefits
```bash
# Your project structure
my-project/
├── .pip/                    # Submodule: operational genome
│   ├── mission/
│   ├── method/
│   ├── ia/
│   └── docs/
├── src/                     # Your application code
├── tests/
└── README.md
```

The submodule approach means:
- `.pip` has its own version history
- Your project references a specific `.pip` commit
- You control when to update operational standards
- Multiple projects can share the same genome

## The Genome Metaphor

### DNA: Core Instructions
Like DNA, `.pip` contains:
- **Mission** (purpose genes): Why the project exists
- **Method** (process genes): How work gets done
- **Agents** (role genes): Who decides what
- **Standards** (quality genes): What good looks like

### Expression: Project-Specific Customization
Just as genes are expressed differently in different cells:
- Each project customizes `mission/mission.md` for its specific purpose
- Agent roles can be assigned to different people
- Processes adapt to project scale and context
- Standards remain consistent but implementation varies

### Evolution: Continuous Improvement
The genome evolves:
- Updates to `.pip` improve all projects that adopt them
- Projects can contribute improvements back upstream
- Mutations (customizations) that work well can be merged back
- Failed experiments stay isolated to individual projects

## How to Use .pip as a Genome

### 1. Initial Integration

Add `.pip` as a submodule to your project:

```bash
# In your project root
git submodule add git@github.com:derrybirkett/pip.git .pip
git submodule update --init --recursive
```

### 2. Customize for Your Project

The genome provides the structure; you provide the specifics:

```bash
# Customize mission
vim .pip/mission/mission.md

# Assign agent owners
vim .pip/ia/agent_manifest.yml

# Define your product
vim .pip/graph/product-app.md

# Commit your customizations
git add .pip
git commit -m "chore: configure .pip genome for project"
```

### 3. Reference in Your Project README

Your project's README should acknowledge the genome:

```markdown
# My Project

[Project description]

## Operational System

This project uses [.pip](https://github.com/derrybirkett/pip) as its operational genome:
- Mission and strategy: `.pip/mission/mission.md`
- Delivery method: `.pip/method/delivery-method.md`
- Agent roles: `.pip/ia/agent_manifest.yml`
- Activity log: `.pip/docs/activity-log.md`

See `.pip/README.md` for full documentation.
```

### 4. Update the Genome

Pull improvements from upstream:

```bash
# Update to latest .pip version
cd .pip
git checkout main
git pull origin main
cd ..
git add .pip
git commit -m "chore: update .pip genome to latest version"
```

Or pin to a specific version:

```bash
cd .pip
git checkout v1.2.0  # Specific tag
cd ..
git add .pip
git commit -m "chore: pin .pip genome to v1.2.0"
```

## AI Agent Integration

The genome is designed for AI consumption:

### Universal Entry Point
Point AI agents to `.pip/fragment-prompt.md` - a single file that provides context about:
- Project structure and conventions
- Agent roles and decision rights
- Process requirements (activity log, changelog, etc.)
- Technical standards and best practices

### Platform-Specific Files
- **Warp**: Automatically reads `.pip/WARP.md`
- **Cursor/Copilot**: Reference `.pip` in workspace settings
- **ChatGPT/Claude Projects**: Include `.pip/fragment-prompt.md` in instructions

### How AI Agents Use the Genome

1. **Context Loading**: Agent reads genome files to understand project
2. **Decision Making**: Agent references role docs for authority boundaries
3. **Process Compliance**: Agent follows method and checklist requirements
4. **Standard Adherence**: Agent applies tech stack and git practices
5. **Documentation**: Agent updates activity log and changelog per genome rules

## Genome vs. Template

### Template Approach (Traditional)
```bash
# Copy template once
git clone template-repo my-project
cd my-project
rm -rf .git
git init
# Template is now disconnected from source
```

**Problems:**
- No updates from upstream
- Improvements don't propagate
- Each project diverges over time
- Inconsistency across projects

### Genome Approach (.pip)
```bash
# Embed as submodule
git submodule add git@github.com:derrybirkett/pip.git .pip
# Genome stays connected to source
```

**Benefits:**
- Pull updates when ready
- Maintain consistency across projects
- Contribute improvements back
- Version control for operational standards

## Best Practices

### Do ✅

- **Keep .pip as submodule**: Don't copy files into your project
- **Customize in place**: Edit `.pip` files directly in your project
- **Commit customizations**: Your `.pip` customizations are part of your project
- **Update periodically**: Pull upstream improvements quarterly
- **Reference in docs**: Link to `.pip` files from your project docs
- **Use for AI context**: Point AI agents to `.pip` files

### Don't ❌

- **Don't copy .pip files**: Keep them in the submodule
- **Don't ignore .pip**: It's core to your project's operation
- **Don't skip customization**: Generic mission/agents aren't useful
- **Don't auto-update**: Review changes before pulling upstream
- **Don't duplicate docs**: Reference `.pip` docs instead of copying
- **Don't work without it**: New projects should start with `.pip`

## Multi-Project Consistency

The genome model enables consistency across your organization:

```bash
# Project A
project-a/
├── .pip/          # Commit abc123
├── src/
└── README.md

# Project B
project-b/
├── .pip/          # Commit abc123 (same version)
├── src/
└── README.md

# Project C
project-c/
├── .pip/          # Commit def456 (newer version)
├── src/
└── README.md
```

All projects share:
- Same agent role definitions
- Same process requirements
- Same technical standards
- Same AI agent integration

But each has:
- Unique mission and vision
- Project-specific agent assignments
- Custom product graphs
- Individual activity logs

## Evolution Strategy

### Upstream (.pip Repository)
- Maintains core genome
- Accepts contributions from projects
- Versions releases with semantic versioning
- Documents breaking changes

### Downstream (Your Projects)
- Customize for specific needs
- Pull updates when beneficial
- Contribute improvements back
- Pin versions for stability

### Contribution Flow
```bash
# In your project, you improve a process
vim .pip/docs/processes/new-process.md

# Commit to your project
git add .pip
git commit -m "docs: add new deployment process"

# Contribute back to upstream
cd .pip
git checkout -b feat/deployment-process
git add docs/processes/new-process.md
git commit -m "docs: add deployment process guide"
git push origin feat/deployment-process
# Create PR to upstream .pip repository
```

## Troubleshooting

### Submodule Not Initialized
```bash
git submodule update --init --recursive
```

### Submodule Out of Sync
```bash
cd .pip
git status
git checkout main
git pull origin main
cd ..
git add .pip
git commit -m "chore: sync .pip submodule"
```

### Merge Conflicts in .pip
```bash
# Your customizations conflict with upstream changes
cd .pip
git status
# Resolve conflicts in your editor
git add <resolved-files>
git commit -m "chore: resolve .pip merge conflicts"
cd ..
git add .pip
git commit -m "chore: update .pip with conflict resolution"
```

### Accidentally Modified .pip
```bash
# Reset to committed version
cd .pip
git reset --hard HEAD
cd ..
```

## Related Documentation

- [Fragments Guide](./fragments-guide.md) - Reusable code scaffolds
- [Activity Log](./activity-log.md) - Historical record
- [Adapting for Your Project](./adapting-for-your-project.md) - Customization guide
- [Git Practices](../ia/agents/cto/tech-stack/git-practices.md) - Submodule workflow

## Summary

Think of `.pip` as your project's **operational DNA**:
- Embedded via git submodule (not copied)
- Provides structure and standards
- Customized for each project
- Evolves over time
- Enables AI agent integration
- Maintains consistency across projects

The genome model ensures your projects have a solid operational foundation while remaining flexible enough to adapt to specific needs.
