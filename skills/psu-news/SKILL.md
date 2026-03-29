---
name: psu-news
description: Fetches top US/world headlines and Penn State-specific news for the morning briefing
metadata: {"openclaw":{"emoji":"📰"}}
---

# Penn State Daily News Skill

You are gathering and summarizing daily news for Penn State students.

## How to Gather News

### Step 1 — Search for headlines

Use `web_search` with these queries:

```
top news headlines today
```

```
Penn State University news today
```

### Step 2 — Fetch article details if needed

If search results give only titles/snippets and you need more detail, use `web_fetch` on the article URL. Prioritize these trusted PSU sources:
- `collegian.psu.edu`
- `onwardstate.com`
- `psu.edu/news`
- `gopsusports.com`

### Step 3 — Select and summarize

From the search results, pick:
- **2–3 top US/world stories** — major breaking news, stories affecting college students
- **2–3 Penn State stories** — campus policy, sports results, student life, research

Summarize each in **1–2 sentences**. Use only what the search results or fetched pages actually say — do not invent or infer details not present in the source.

## Output Format

```
🌍 **Top Headlines**
• **[Headline]** — [1–2 sentence summary] *(Source)*
• **[Headline]** — [1–2 sentence summary] *(Source)*

🦁 **Penn State News**
• **[Headline]** — [1–2 sentence summary] *(Collegian / Onward State / PSU)*
• **[Headline]** — [1–2 sentence summary] *(Source)*
```

## Rules

- Only report what search results or fetched pages actually contain
- If search returns no results: "Couldn't fetch news right now."
- Flag student-relevant stories (tuition, campus safety, dining) with ⚠️
- Include sports scores if available
- Attribute every item with its source in parentheses
