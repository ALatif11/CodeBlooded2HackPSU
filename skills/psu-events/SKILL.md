---
name: psu-events
description: Fetches upcoming Penn State campus events from the PSU events calendar
metadata: {"openclaw":{"emoji":"📅"}}
---

# Penn State Events Skill

You are gathering upcoming campus events for Penn State students.

## How to Fetch Events

### Primary Source: Penn State Events Calendar

Use `web_fetch` to pull events from the official calendar:

```
web_fetch("https://events.psu.edu")
```

Parse the page to extract today's and this week's upcoming events. Look for event names, dates/times, locations, and descriptions.

Also try the more specific feed if available:

```
web_fetch("https://events.psu.edu/today")
```

### Fallback: Web Search

If the events calendar is hard to parse or returns limited results, use `web_search`:

```
web_search("Penn State events this week site:psu.edu")
web_search("Penn State University Park events today")
web_search("Penn State student events this week")
```

You can also check:
- **studentaffairs.psu.edu** — Student affairs events
- **spa.psu.edu** — Student Programming Association
- **involvement.psu.edu** — UPUA and student orgs

Use `web_fetch` on any promising links to get event details.

### Additional Sources

For sports events:
```
web_search("Penn State athletics schedule this week site:gopsusports.com")
```

## Output Format

List up to **5** upcoming events:

```
📅 **Campus Events**

📌 **[Event Name]**
   🕐 [Date & Time]
   📍 [Location]
   [One-line description if helpful]

📌 **[Event Name]**
   🕐 [Date & Time]
   📍 [Location]
   [One-line description if helpful]

...
```

## Prioritization

When selecting which events to show, prioritize in this order:
1. **Free food events** — students love free food, always include these
2. **Career fairs and networking** — high value for students
3. **Club and organization events** — community building
4. **Sports events** — especially home football, basketball, wrestling, hockey
5. **Academic talks and lectures** — guest speakers, research presentations
6. **Arts and entertainment** — concerts, shows, exhibits
7. **Campus alerts** — construction, closures, safety notices

## Guidelines

- Show a **max of 5 events** to keep it scannable
- Include the **date, time, and location** for every event
- If an event has free food, flag it with 🍕
- If an event is today, flag it with **[TODAY]**
- If an event is a major/popular one (football game, THON, etc.), flag it with 🔥
- If no events are found, say: "No major events coming up — perfect time to hit the Creamery or explore the Arboretum!"
