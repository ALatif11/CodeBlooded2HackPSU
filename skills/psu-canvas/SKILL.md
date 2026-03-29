---
name: psu-canvas
description: Fetches upcoming Canvas LMS assignments for Penn State students using their API token
metadata: {"openclaw":{"requires":{"bins":["curl"]},"primaryEnv":"CANVAS_API_TOKEN","emoji":"📚"}}
---

# Penn State Canvas Assignments Skill

You help Penn State students track their upcoming Canvas assignments.

## Token Management

Students must provide their Canvas API token before this skill can work. Tokens are generated at:
**Canvas → Account → Settings → New Access Token**

### Setting a Token

When a student says something like "set my canvas token: TOKEN_HERE" or "my canvas token is TOKEN_HERE":
1. Extract the token value
2. Store it in memory with a key like `canvas_token` so it persists across sessions
3. Confirm: "Canvas token saved! I'll use this to fetch your assignments. You only need to set this once."
4. **Never display the token back to the user** — just confirm it was saved

### Token Security
- **NEVER** echo, display, or log the token in any output
- Store only in OpenClaw memory, never in files
- If a student asks to remove their token, delete it from memory immediately

## How to Fetch Assignments

Use the helper script in this skill's directory, or run curl directly.

### Using the helper script:

```bash
./canvas_fetch.sh "users/self/upcoming_events" "TOKEN"
```

### Direct curl commands:

**Fetch upcoming events (assignments, quizzes, calendar events):**
```bash
curl -s -H "Authorization: Bearer TOKEN" "https://psu.instructure.com/api/v1/users/self/upcoming_events"
```

**Fetch active courses:**
```bash
curl -s -H "Authorization: Bearer TOKEN" "https://psu.instructure.com/api/v1/courses?enrollment_state=active&per_page=50"
```

**Fetch assignments for a specific course (next 7 days):**
```bash
curl -s -H "Authorization: Bearer TOKEN" "https://psu.instructure.com/api/v1/courses/COURSE_ID/assignments?order_by=due_at&per_page=50"
```

## Data Processing

1. Fetch active courses first to build a course ID → course name mapping
2. Fetch upcoming events to get assignments due soon
3. Filter to only assignments due within the **next 7 days**
4. Group assignments by course
5. Sort by due date within each course

## Output Format

```
📚 **Upcoming Assignments**

**[Course Name]**
  • [Assignment Name] — Due: [Day, Date at Time] ([X points])
  • ⚠️ [Assignment Name] — Due: **Tomorrow at 11:59 PM** ([X points])

**[Course Name]**
  • [Assignment Name] — Due: [Day, Date at Time] ([X points])

---
💡 You have [N] assignments due this week. [Encouraging message]
```

## Formatting Rules

- **Group by course** — show the course name as a bold header
- **Sort by due date** within each course (soonest first)
- **Flag urgent items** with ⚠️ if due within 24 hours
- Show **assignment name, due date/time, and points possible**
- Format dates as: "Monday, Mar 15 at 11:59 PM"
- At the bottom, show a count and encouraging note:
  - 0 assignments: "You're all clear! Time to get ahead or enjoy the day."
  - 1-3 assignments: "Light week — you've got this!"
  - 4-6 assignments: "Solid workload — stay on top of it!"
  - 7+ assignments: "Heavy week ahead — start early and take breaks!"

## Error Handling

- **No token set:** "I don't have your Canvas token yet. Go to Canvas → Settings → New Access Token, then tell me: 'set my canvas token: YOUR_TOKEN'"
- **Invalid/expired token (401):** "Your Canvas token seems invalid or expired. Please generate a new one in Canvas → Settings → New Access Token."
- **API error:** "I couldn't reach Canvas right now. Penn State's servers might be busy — try again in a few minutes."
- **No upcoming assignments:** "No assignments due in the next 7 days — enjoy the breather! 🎉"
