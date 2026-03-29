# Nittany Briefer - Setup Guide

## Discord Bot Setup

### 1. Create a Discord Application

1. Go to [Discord Developer Portal](https://discord.com/developers/applications)
2. Click **New Application** → Name it "Nittany Briefer"
3. Go to **Bot** tab → Click **Add Bot**
4. Enable these Privileged Gateway Intents:
   - **Message Content Intent** (REQUIRED)
   - **Server Members Intent** (recommended)
5. Copy the **Bot Token**

### 2. Set the Bot Token

```bash
export DISCORD_BOT_TOKEN="YOUR_BOT_TOKEN_HERE"
```

Add this to your shell profile (`~/.bashrc` or `~/.zshrc`) to persist it.

### 3. Invite the Bot to Your Server

1. In the Developer Portal, go to **OAuth2 → URL Generator**
2. Select scopes: `bot`, `applications.commands`
3. Select permissions:
   - Send Messages
   - Read Message History
   - Embed Links
   - Use External Emojis
4. Copy the generated URL and open it in your browser
5. Select your Penn State Discord server and authorize

### 4. Pair the Bot with OpenClaw

1. Start the OpenClaw gateway: `openclaw gateway start`
2. DM the bot on Discord — it will give you a pairing code
3. Approve the pairing via the OpenClaw CLI

## Cron Job: Automatic Morning Briefing

Tell the agent to set up the cron job by saying:

> "Set up a morning briefing cron job for 7:30 AM on weekdays"

Or configure it manually. The cron expression for 7:30 AM ET, Monday-Friday:

```
30 7 * * 1-5
```

### Manual Cron Setup

You can add this to `~/.openclaw/cron/jobs.json`:

```json
{
  "morning-briefing": {
    "schedule": {
      "cron": "30 7 * * 1-5",
      "timezone": "America/New_York"
    },
    "mode": "isolated",
    "payload": {
      "agentTurn": "Good morning! Please run a full morning briefing using all skills: psu-weather, psu-news, psu-events, and psu-canvas. Send the combined briefing to the Discord channel."
    }
  }
}
```

### What the Cron Job Does

Every weekday at 7:30 AM ET, the agent will:
1. Fetch State College weather (psu-weather)
2. Gather top headlines and Penn State news (psu-news)
3. Pull upcoming campus events (psu-events)
4. Fetch Canvas assignments if a token is set (psu-canvas)
5. Combine everything into one formatted Discord message

## Canvas API Token (Optional)

For the assignments feature, each student needs their own Canvas token:

1. Log into [Penn State Canvas](https://psu.instructure.com)
2. Go to **Account → Settings**
3. Scroll to **Approved Integrations** → Click **+ New Access Token**
4. Name it "Nittany Briefer" and generate
5. Copy the token and tell the bot: `set my canvas token: YOUR_TOKEN`

The token is stored in OpenClaw memory per-user and never displayed.

## Testing the Skills

You can test each skill individually by talking to the agent:

- **Weather:** "What's the weather in State College?"
- **News:** "Give me today's news briefing"
- **Events:** "What's happening on campus this week?"
- **Canvas:** "What assignments do I have due?"
- **Full briefing:** "Give me my morning briefing"
