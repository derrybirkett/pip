---
layout: default
title: .pip Framework Blog
---

# Building Agentic Development Systems

Latest insights on AI agent coordination, design patterns, and development workflows.

## Latest Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
    </li>
  {% endfor %}
</ul>

---

## About .pip

`.pip` (Project Intelligence & Process) is a lightweight documentation framework for AI-assisted development. It provides:
- Agent-based governance with C-suite roles (CEO, CTO, CPO, CISO, CMO, CRO)
- Process templates for discovery, delivery, and collaboration
- Reusable infrastructure fragments and agentic design patterns
- Multi-agent coordination workflows

[View Repository on GitHub](https://github.com/derrybirkett/pip) • [Read the Docs](https://github.com/derrybirkett/pip/blob/main/README.md)
