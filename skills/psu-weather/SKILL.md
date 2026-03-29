---
name: psu-weather
description: Fetches current weather and forecast for State College, PA (Penn State) with clothing suggestions
metadata: {"openclaw":{"emoji":"🌤️"}}
---

# Penn State Weather Skill

You are reporting the weather for **State College, PA** (Penn State University Park campus).

## How to Fetch Weather

### Primary Source: wttr.in

Use `web_fetch` on this URL to get weather data:

```
https://wttr.in/State+College+PA?format=j1
```

The response is JSON. Parse it to extract:
- `current_condition[0].temp_F` — current temperature in Fahrenheit
- `current_condition[0].weatherDesc[0].value` — condition description
- `current_condition[0].humidity` — humidity percentage
- `current_condition[0].windspeedMiles` — wind speed
- `current_condition[0].FeelsLikeF` — feels like temperature
- `weather[0].maxtempF` — today's high
- `weather[0].mintempF` — today's low
- `weather[0].hourly` — scan for max `chanceofrain` or `chanceofsnow`

### Fallback Source: Open-Meteo

If wttr.in fails or returns unparseable content, use `web_fetch` on:

```
https://api.open-meteo.com/v1/forecast?latitude=40.7934&longitude=-77.8600&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&daily=temperature_2m_max,temperature_2m_min,precipitation_probability_max&temperature_unit=fahrenheit&wind_speed_unit=mph&timezone=America%2FNew_York
```

From this response:
- `current.temperature_2m` — current temp (°F)
- `current.wind_speed_10m` — wind speed (mph)
- `current.relative_humidity_2m` — humidity
- `current.weather_code` — WMO code (0=clear, 1-3=cloudy, 45/48=fog, 51-67=rain, 71-77=snow, 80-82=showers, 95-99=thunderstorm)
- `daily.temperature_2m_max[0]` — today's high
- `daily.temperature_2m_min[0]` — today's low
- `daily.precipitation_probability_max[0]` — precip chance %

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

🧥 [one-liner clothing suggestion]
```

## Clothing Suggestions

- Below 32°F: "Bundle up — heavy coat, gloves, and a hat."
- 32–45°F: "Grab a warm jacket — it's cold but manageable."
- 45–60°F: "A light jacket or hoodie should do the trick."
- 60–75°F: "Perfect Penn State weather — t-shirt and jeans kind of day!"
- Above 75°F: "Shorts and sunscreen weather."
- Rain >50%: Append "Don't forget an umbrella!"
- Snow >50%: Append "Watch out for slippery sidewalks on campus."
- Wind >20mph: Append "It's gusty — hang onto your stuff walking across the HUB lawn."

## If Both Sources Fail

Say: "Couldn't fetch weather right now — check weather.com for State College, PA."
Do not guess or invent weather data.
