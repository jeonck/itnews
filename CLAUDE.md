# IT Daily Brief — repository instructions

This repo is a Hugo (PaperMod) site published at **https://itnews.metacog.co.kr/**.
It holds one post per day: an English-language IT news briefing.

A scheduled Claude routine runs every morning at **06:00 US Central** and writes
that day's post. If you are that routine, follow this document exactly.

## Daily job

1. Determine today's date in **US Central time**: `TZ=America/Chicago date +%F`
   (call it `YYYY-MM-DD`) and the offset `TZ=America/Chicago date +%:z`
   (`-05:00` during CDT, `-06:00` during CST).
2. If `content/posts/YYYY-MM-DD.md` already exists, stop — today is already published.
3. Search the web for the most important IT news and insights from roughly the
   **last 24 hours**, covering the four areas below. Use several searches per
   area and prefer primary/credible sources.
4. Write `content/posts/YYYY-MM-DD.md` using the template below.
5. Commit and push to `main`. GitHub Actions builds and deploys automatically.

## The four areas

1. **AI / ML** — generative AI, LLMs, major AI product/model releases or research
2. **Development** — notable language, framework, dev tool, or open-source updates
3. **Big Tech & Startups** — major company news, funding, M&A
4. **Security & Cloud** — significant vulnerabilities, breaches, cloud infrastructure news

Pick the **2–4 most notable items per area**. Skip an area entirely (omit its
heading) if genuinely nothing notable happened. For each item write:

- a short headline
- **1–2 sentences** on why it matters
- a source link

Keep it concise and skimmable — a quick daily briefing, not an exhaustive
report. End the post with a `## Sources` list of every link used.

## Post template

```markdown
---
title: "IT Daily Brief — August 17, 2026"
date: 2026-08-17T06:00:00-05:00
draft: false
summary: "One sentence naming the two or three biggest stories of the day."
tags: ["daily-brief", "ai", "development", "big-tech", "security"]
categories: ["Daily Brief"]
---

*Everything that mattered in tech over the last 24 hours, in about two minutes.*

## 🤖 AI / ML

### Headline of the first item
Why it matters, in one or two sentences. — [Source](https://example.com/article)

### Headline of the second item
Why it matters, in one or two sentences. — [Source](https://example.com/article)

## 🛠 Development

### ...

## 🏢 Big Tech & Startups

### ...

## 🔐 Security & Cloud

### ...

## Sources

- [Publication — Article title](https://example.com/article)
- [Publication — Article title](https://example.com/article)
```

## Hard rules

- **Filename** is `content/posts/YYYY-MM-DD.md` — nothing else.
- **`date`** must carry the correct Central offset (`-05:00` CDT / `-06:00` CST)
  and be at or before the current time. A future-dated post is silently dropped
  from the build.
- Write in **English**, even though the operator's own notes are in Korean.
- Use the four `##` headings above, in that order, with those emoji.
- Every item must have a **real, working source URL** taken from search results.
  Never invent a link, a headline, or a story. If an area has nothing, drop it.
- Do not touch `hugo.toml`, `themes/`, or the workflow while writing a post.
- Verify before pushing: `hugo --minify` must finish with zero errors.

## Local commands

```bash
hugo server -D          # preview at http://localhost:1313
hugo --minify           # production build into public/
```
