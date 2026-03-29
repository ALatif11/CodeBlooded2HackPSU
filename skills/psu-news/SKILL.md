---
name: psu-news
description: Fetches top US/world headlines and Penn State-specific news for the morning briefing
metadata: {"openclaw":{"emoji":"📰"}}
---

# Penn State Daily News Skill

You are gathering and summarizing daily news for Penn State students.

## How to Gather News

### Top US/World Headlines

Use `web_search` to find today's top news:

```
web_search("top news headlines today")
```

Select **2-3** of the most significant stories. Prioritize:
- Major breaking news
- Stories that affect college students (economy, education policy, tech)
- Widely discussed stories that students will want to know about

### Penn State News

Use `web_search` to find Penn State-specific news:

```
web_search("Penn State news today site:psu.edu OR site:collegian.psu.edu OR site:onwardstate.com")
```

Also try:
```
web_search("Penn State University news this week")
```

If you find relevant links, use `web_fetch` to get more details from these trusted sources:
- **collegian.psu.edu** — The Daily Collegian (student newspaper)
- **onwardstate.com** — Onward State (student blog/news)
- **psu.edu/news** — Official Penn State news
- **gopsusports.com** — Penn State athletics

Select **2-3** Penn State-specific stories. Prioritize:
- Campus policy changes, closures, or alerts
- Sports results and upcoming big games
- Student organization news
- Research breakthroughs or notable faculty/student achievements
- Events with wide student impact

## Output Format

Group the output into two sections:

```
🌍 **Top Headlines**
• **[Headline 1]** — [1-2 sentence summary]
• **[Headline 2]** — [1-2 sentence summary]
• **[Headline 3]** — [1-2 sentence summary]

🦁 **Penn State News**
• **[PSU Headline 1]** — [1-2 sentence summary]
• **[PSU Headline 2]** — [1-2 sentence summary]
```

## Guidelines

- Keep each summary to **1-2 sentences max** — students want a quick scan, not full articles
- Be factual and neutral — report, don't editorialize
- If a story is particularly relevant to students (e.g., tuition changes, campus safety), flag it with a ⚠️
- If sports results are available (especially football, basketball, wrestling), include the score
- Always attribute the source in parentheses at the end: *(Collegian)*, *(Onward State)*, *(AP)*
- If no Penn State-specific news is found, say: "No major Penn State news today — enjoy the quiet!"
