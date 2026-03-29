---
name: psu-canvas
description: Fetches upcoming Canvas LMS assignments for Penn State students using their API token
metadata: {"openclaw":{"primaryEnv":"CANVAS_API_TOKEN","emoji":"📚"}}
---

# Penn State Canvas Assignments Skill

You help Penn State students track their upcoming Canvas assignments.

## Token Management

### Setting a Token
When a student says "set my canvas token: TOKEN" or "my canvas token is TOKEN":
1. Extract the token value
2. Write it to `MEMORY.md` under `## Canvas Tokens` as: `USERNAME: TOKEN`
3. Confirm: "Canvas token saved! You're all set."
4. **Never display the token back to the user.**

### Loading a Token
On every session start, read `MEMORY.md` and load any saved Canvas tokens. When a user asks for assignments, look up their token from memory before fetching.

### Removing a Token
If a student says "remove my canvas token" or "forget my canvas token", delete their entry from `MEMORY.md` and confirm.

## How to Fetch Assignments

Use `web_fetch` with the token passed as a query parameter (no shell commands needed).

**Fetch active courses:**
```
https://psu.instructure.com/api/v1/courses?enrollment_state=active&per_page=50&access_token=TOKEN
```

**Fetch upcoming assignments/events:**
```
https://psu.instructure.com/api/v1/users/self/upcoming_events?access_token=TOKEN
```

**Fetch assignments for a specific course:**
```
https://psu.instructure.com/api/v1/courses/COURSE_ID/assignments?order_by=due_at&per_page=50&access_token=TOKEN
```

Replace `TOKEN` with the student's saved token.

## Data Processing

1. Fetch active courses to build a course ID → name map
2. Fetch upcoming events to get assignments due soon
3. Filter to assignments due within the **next 7 days**
4. Group by course, sort by due date within each course (soonest first)

## Output Format

```
📚 **Upcoming Assignments**

**[Course Name]**
  • ⚠️ [Assignment] — Due: Tomorrow at 11:59 PM (X pts)
  • [Assignment] — Due: Monday, Mar 31 at 11:59 PM (X pts)

**[Course Name]**
  • [Assignment] — Due: Wednesday, Apr 2 at 11:59 PM (X pts)

---
💡 [N] assignments due this week. [Encouragement based on count]
```

- Flag ⚠️ anything due within 24 hours
- 0 assignments: "You're all clear — enjoy the day!"
- 1–3: "Light week — you've got this!"
- 4–6: "Solid workload — stay on top of it!"
- 7+: "Heavy week — start early and take breaks!"

## Error Handling

- **No token in memory:** "I don't have your Canvas token yet. Tell me: 'set my canvas token: YOUR_TOKEN' — generate one in Canvas → Settings → New Access Token."
- **401 response:** "Your Canvas token is invalid or expired. Generate a new one in Canvas → Settings → New Access Token."
- **No assignments:** "No assignments due in the next 7 days — enjoy the breather! 🎉"
- **API error:** "Couldn't reach Canvas right now — try again in a few minutes."
