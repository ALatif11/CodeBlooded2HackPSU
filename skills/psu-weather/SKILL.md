---
name: psu-weather
description: Fetches current weather and forecast for State College, PA (Penn State) with clothing suggestions
metadata: {"openclaw":{"requires":{"bins":["curl"]},"emoji":"🌤️"}}
---

# Penn State Weather Skill

You are reporting the weather for **State College, PA** (Penn State University Park campus).

## How to Fetch Weather

### Primary Source: wttr.in

Run this command to get weather data as JSON:

```bash
curl -s "wttr.in/State+College+PA?format=j1"
```

Parse the JSON response to extract:
- **Current conditions:** `current_condition[0]` — temperature (`temp_F`), weather description (`weatherDesc`), humidity, wind speed (`windspeedMiles`), "feels like" (`FeelsLikeF`)
- **Today's forecast:** `weather[0]` — high (`maxtempF`), low (`mintempF`), precipitation chance (check `hourly[].chanceofrain` or `hourly[].chanceofsnow`)

### Fallback Source: Open-Meteo

If wttr.in fails, use this (no API key required):

```bash
curl -s "https://api.open-meteo.com/v1/forecast?latitude=40.7934&longitude=-77.8600&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=America%2FNew_York"
```

Open-Meteo returns temperatures in Fahrenheit (as requested) and uses WMO weather codes. Map common codes:
- 0: Clear sky
- 1-3: Partly cloudy to overcast
- 45, 48: Fog
- 51-67: Drizzle/Rain
- 71-77: Snow
- 80-82: Rain showers
- 85-86: Snow showers
- 95-99: Thunderstorms

## Output Format

Use weather emoji based on conditions:
- ☀️ Clear/Sunny
- ⛅ Partly Cloudy
- ☁️ Overcast
- 🌧️ Rain
- 🌦️ Light rain / Showers
- ❄️ Snow
- ⛈️ Thunderstorms
- 🌫️ Fog
- 💨 Very windy (>20mph)

Format the output like this:

```
☀️ **State College Weather**
Currently: 52°F (Feels like 48°F) — Partly Cloudy
Wind: 8 mph | Humidity: 65%

Today: High 58°F / Low 42°F
Precipitation: 10% chance of rain

🧥 Clothing tip: [one-liner suggestion based on conditions]
```

## Clothing Suggestions

Generate a one-liner based on conditions:
- **Below 32°F:** "Bundle up — it's freezing out there. Heavy coat, gloves, and a hat are a must."
- **32-45°F:** "Grab a warm jacket — it's cold but manageable."
- **45-60°F:** "A light jacket or hoodie should do the trick."
- **60-75°F:** "Perfect Penn State weather — t-shirt and jeans kind of day!"
- **Above 75°F:** "It's warm out — shorts and sunscreen weather."
- **Rain likely (>50%):** Append "Don't forget an umbrella!"
- **Snow likely (>50%):** Append "Watch out for slippery sidewalks on campus."
- **Very windy (>20mph):** Append "It's gusty — hang onto your stuff walking across the HUB lawn."
