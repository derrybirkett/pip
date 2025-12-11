#!/usr/bin/env node

const { OpenAI } = require('openai');
const fs = require('fs').promises;
const path = require('path');
const { format, addDays, nextTuesday, nextFriday } = require('date-fns');

// Initialize OpenAI
const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

// Content topics and themes - CUSTOMIZE FOR YOUR PROJECT
const CONTENT_THEMES = [
  'Industry Best Practices and Trends',
  'Technology Implementation Strategies',
  'Business Process Optimization',
  'Leadership and Team Management',
  'Customer Success Stories',
  'Product Development Insights',
  'Market Analysis and Opportunities',
  'Innovation and Digital Transformation',
  'Operational Efficiency Improvements',
  'Strategic Planning and Execution'
];

// Target audience pain points - CUSTOMIZE FOR YOUR AUDIENCE
const PAIN_POINTS = [
  'Implementing new technologies effectively',
  'Measuring ROI on business initiatives',
  'Managing team productivity and engagement',
  'Scaling operations efficiently',
  'Staying competitive in the market',
  'Optimizing business processes',
  'Making data-driven decisions',
  'Improving customer satisfaction',
  'Reducing operational costs',
  'Accelerating time-to-market'
];

async function generateBlogPost(topic, targetDate) {
  // CUSTOMIZE THIS PROMPT FOR YOUR BRAND AND AUDIENCE
  const prompt = `
You are a thought leader writing for business professionals about ${topic}.

Write a comprehensive blog post (1200-1500 words) that:

1. **Addresses professional concerns**: Focus on practical, actionable solutions
2. **Provides valuable insights**: Share expertise and best practices
3. **Includes real-world applications**: How this applies to common business challenges
4. **Maintains professional tone**: Authoritative but accessible

Structure:
- Compelling headline that addresses a specific need
- Hook that identifies a relevant challenge or opportunity
- 3-4 main sections with practical insights
- Concrete examples or case studies
- Clear call-to-action for next steps

Focus on:
- Practical implementation strategies
- Measurable outcomes and benefits
- Risk mitigation approaches
- Scalable solutions
- Industry best practices

Write in a confident, solution-oriented voice that positions expertise as the key to success.

Return the response in this exact JSON format:
{
  "title": "Blog post title",
  "description": "SEO meta description (150-160 characters)",
  "content": "Full blog post content in markdown format",
  "tags": ["tag1", "tag2", "tag3"],
  "summary": "2-sentence summary of the main value proposition"
}
`;

  try {
    const completion = await openai.chat.completions.create({
      model: "gpt-4",
      messages: [
        {
          role: "system",
          content: "You are an expert content creator specializing in business strategy and professional development. You write compelling, actionable content for business leaders and professionals."
        },
        {
          role: "user",
          content: prompt
        }
      ],
      temperature: 0.7,
      max_tokens: 4000
    });

    const response = completion.choices[0].message.content;
    
    // Parse JSON response
    let parsedResponse;
    try {
      parsedResponse = JSON.parse(response);
    } catch (parseError) {
      console.error('Failed to parse AI response as JSON:', parseError);
      // Fallback: try to extract content between JSON markers
      const jsonMatch = response.match(/\{[\s\S]*\}/);
      if (jsonMatch) {
        parsedResponse = JSON.parse(jsonMatch[0]);
      } else {
        throw new Error('Could not extract valid JSON from AI response');
      }
    }

    return {
      ...parsedResponse,
      targetDate,
      topic
    };
  } catch (error) {
    console.error('Error generating content:', error);
    throw error;
  }
}

function createSlug(title) {
  return title
    .toLowerCase()
    .replace(/[^a-z0-9\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .trim();
}

function getNextPublicationDate(targetDate) {
  if (targetDate) {
    return new Date(targetDate);
  }
  
  const now = new Date();
  const nextTues = nextTuesday(now);
  const nextFri = nextFriday(now);
  
  // Choose the next available publication date (Tuesday or Friday)
  return nextTues < nextFri ? nextTues : nextFri;
}

async function createBlogPostFile(postData) {
  const { title, description, content, tags, targetDate, topic } = postData;
  const slug = createSlug(title);
  const pubDate = getNextPublicationDate(targetDate);
  
  const frontmatter = `---
title: '${title.replace(/'/g, "''")}'
description: '${description.replace(/'/g, "''")}'
pubDate: '${format(pubDate, 'yyyy-MM-dd')}'
heroImage: '/blog-placeholder-1.jpg'
tags: [${tags.map(tag => `'${tag}'`).join(', ')}]
---

${content}`;

  const filename = `${slug}.md`;
  
  // CUSTOMIZE THESE PATHS FOR YOUR PROJECT STRUCTURE
  const draftsPaths = [
    'apps/blog/src/content/drafts',  // Astro structure
    'content/drafts',                // Hugo structure
    '_drafts',                       // Jekyll structure
    'src/content/drafts'             // Alternative structure
  ];
  
  let filepath;
  for (const draftsPath of draftsPaths) {
    try {
      await fs.access(draftsPath);
      filepath = path.join(draftsPath, filename);
      break;
    } catch (error) {
      // Directory doesn't exist, try next one
      continue;
    }
  }
  
  if (!filepath) {
    // Default to first path and create directory
    filepath = path.join(draftsPaths[0], filename);
    await fs.mkdir(path.dirname(filepath), { recursive: true });
  }
  
  // Write the file
  await fs.writeFile(filepath, frontmatter, 'utf8');
  
  return {
    filename,
    filepath,
    slug,
    pubDate: format(pubDate, 'yyyy-MM-dd'),
    wordCount: content.split(/\s+/).length
  };
}

async function main() {
  try {
    console.log('🤖 Starting AI content generation...');
    
    // Get topic (from input or random selection)
    const topicOverride = process.env.TOPIC_OVERRIDE;
    const topic = topicOverride || CONTENT_THEMES[Math.floor(Math.random() * CONTENT_THEMES.length)];
    
    console.log(`📝 Generating content for topic: ${topic}`);
    
    // Generate the blog post
    const postData = await generateBlogPost(topic, process.env.TARGET_DATE);
    
    // Create the blog post file
    const fileInfo = await createBlogPostFile(postData);
    
    console.log(`✅ Content generated successfully!`);
    console.log(`📄 File: ${fileInfo.filename}`);
    console.log(`📅 Publication Date: ${fileInfo.pubDate}`);
    console.log(`📊 Word Count: ${fileInfo.wordCount}`);
    
    // Set outputs for GitHub Actions
    console.log(`::set-output name=content_created::true`);
    console.log(`::set-output name=post_title::${postData.title}`);
    console.log(`::set-output name=topic::${topic}`);
    console.log(`::set-output name=target_date::${fileInfo.pubDate}`);
    console.log(`::set-output name=slug::${fileInfo.slug}`);
    console.log(`::set-output name=word_count::${fileInfo.wordCount}`);
    console.log(`::set-output name=summary::${postData.summary}`);
    
  } catch (error) {
    console.error('❌ Content generation failed:', error);
    console.log(`::set-output name=content_created::false`);
    process.exit(1);
  }
}

// Run the script
if (require.main === module) {
  main();
}

module.exports = { generateBlogPost, createBlogPostFile, CONTENT_THEMES, PAIN_POINTS };