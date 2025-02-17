Config = Config or {}

Config.WeatherAPI = {
    key = "5bc5a681a79402cd8c98beb8ee7f8749", -- Enter your own key here
---@type table<"Thunderstorm" | "Drizzle" | "Rain" | "Snow" | "Clear" | "Clouds" | "Mist" | "Smoke" | "Haze" | "Dust" | "Fog" | "Sand" | "Ash" | "Squall" | "Tornado", 'EXTRASUNNY' | 'CLEAR' | 'NEUTRAL' | 'SMOG' | 'FOGGY' | 'OVERCAST' | 'CLOUDS' | 'CLEARING' | 'RAIN' | 'THUNDER' | 'SNOW' | 'BLIZZARD' | 'SNOWLIGHT' | 'XMAS' | 'HALLOWEEN'>
    map = {
        default = "EXTRASUNNY",

        Thunderstorm = "THUNDER",
        Drizzle = "RAIN",
        Rain = "RAIN",
        Snow = "SNOW",
        Mist = "FOGGY",
        Smoke = "SMOG",
        Haze = "SMOG",
        Dust = "SMOG",
        Fog = "FOGGY",
        Sand = "SMOG",
        Ash = "SMOG",
        Squall = "CLEARING",
        Tornado = "SMOG",
        Clear = "EXTRASUNNY",
        Clouds = "CLOUDS"
    },
    getWeather = function(city, country, key, map)
        local url = ("https://api.openweathermap.org/data/2.5/weather?q=%s,%s&appid=%s"):format(city, country, key)
        local status, strdata = PerformHttpRequestAwait(url)

        if not status == 200 then return map.default or "EXTRA_SUNNY" end

        if not strdata then return map.default or "EXTRA_SUNNY" end
        local data = json.decode(strdata)
        local currentWeather = data.weather[1].main

        return map[currentWeather] or map.default or "EXTRA_SUNNY"

    end
}