# AI Content Automation Fragment

Automated AI-powered content generation system using GitHub Actions and OpenAI API.

## Overview

This fragment provides a complete content automation pipeline that:
- Generates high-quality blog posts using AI
- Creates pull requests for review
- Schedules content publication
- Maintains consistent brand voice and messaging

## Features

- **Automated Content Generation**: Uses OpenAI GPT-4 to create blog posts
- **Smart Scheduling**: Automatically schedules posts for optimal publication times
- **Review Workflow**: Creates PRs for human review before publication
- **Customizable Topics**: Supports topic override and manual triggering
- **SEO Optimization**: Generates meta descriptions, tags, and structured content
- **Brand Consistency**: Maintains consistent voice and messaging

## Prerequisites

- OpenAI API key
- GitHub repository with Actions enabled
- Blog structure using Astro or similar static site generator

## Installation

1. Copy workflow files to your repository:
   ```bash
   cp .pip/fragments/ai-content-automation/workflows/* .github/workflows/
   cp -r .pip/fragments/ai-content-automation/scripts .github/
   ```

2. Set up GitHub Secrets:
   ```
   OPENAI_API_KEY: Your OpenAI API key
   ```

3. Customize content themes in `generate-content.js`:
   - Update `CONTENT_THEMES` array with your topics
   - Modify `PAIN_POINTS` for your target audience
   - Adjust the AI prompt for your brand voice

## Usage

### Automatic Generation
- Runs every Sunday at 6:00 AM UTC
- Generates content for next Tuesday/Friday publication
- Creates PR for review

### Manual Trigger
```bash
# Generate content with custom topic
gh workflow run ai-content-generation.yml -f topic_override="Your Custom Topic"

# Generate for specific date
gh workflow run ai-content-generation.yml -f target_date="2024-01-15"
```

## Configuration

### Content Themes
Edit `CONTENT_THEMES` array in `generate-content.js`:
```javascript
const CONTENT_THEMES = [
  'Your Topic 1',
  'Your Topic 2',
  // Add your themes here
];
```

### AI Prompt Customization
Modify the prompt in `generateBlogPost()` function to match your:
- Brand voice and tone
- Target audience
- Content structure preferences
- Industry-specific requirements

### Publication Schedule
Adjust cron schedule in workflow file:
```yaml
schedule:
  - cron: '0 6 * * 0'  # Every Sunday at 6 AM UTC
```

## File Structure

```
.github/
├── workflows/
│   └── ai-content-generation.yml
└── scripts/
    ├── generate-content.js
    └── package.json
```

## Workflow Process

1. **Trigger**: Scheduled or manual
2. **Generate**: AI creates blog post content
3. **Create File**: Saves to drafts directory
4. **Pull Request**: Creates PR with generated content
5. **Review**: Human reviews and edits content
6. **Merge**: Content moves to publication queue
7. **Publish**: Existing automation publishes on schedule

## Customization Examples

### Enterprise SaaS Company
```javascript
const CONTENT_THEMES = [
  'API Integration Best Practices',
  'Enterprise Security Compliance',
  'Scaling SaaS Architecture',
  'Customer Success Strategies'
];
```

### Marketing Agency
```javascript
const CONTENT_THEMES = [
  'Digital Marketing Trends',
  'Content Strategy Optimization',
  'Social Media ROI Measurement',
  'Brand Positioning Strategies'
];
```

## Best Practices

1. **Review All Generated Content**: AI content should always be reviewed for accuracy
2. **Customize Prompts**: Tailor AI prompts to your specific industry and audience
3. **Monitor Quality**: Track engagement metrics to refine content generation
4. **Backup Strategy**: Have manual content creation as fallback
5. **Brand Guidelines**: Ensure AI-generated content aligns with brand voice

## Troubleshooting

### Common Issues

**OpenAI API Errors**
- Check API key validity
- Verify sufficient API credits
- Monitor rate limits

**Content Quality Issues**
- Refine AI prompts
- Add more specific examples
- Adjust temperature settings

**Scheduling Problems**
- Verify cron syntax
- Check timezone settings
- Ensure proper date calculations

## Integration with Existing Systems

This fragment works with:
- Astro static site generators
- Jekyll/Hugo blogs
- Custom CMS systems
- Headless CMS platforms

## Security Considerations

- Store OpenAI API key in GitHub Secrets
- Use minimal permissions for GitHub token
- Review generated content before publication
- Monitor API usage and costs

## Contributing

To improve this fragment:
1. Test with different content types
2. Add support for additional AI providers
3. Enhance content quality metrics
4. Improve error handling and logging

## License

Part of the .pip framework - follow project licensing terms.