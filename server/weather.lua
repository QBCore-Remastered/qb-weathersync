local state = GlobalState
local freezeWeather = Config.freezeWeather or false
local validWeatherTypes = {}

for _, validWeatherType in pairs(Config.AvailableWeatherTypes) do
    validWeatherTypes[validWeatherType] = true
end

---@class Weather
---@field current 'EXTRASUNNY' | 'CLEAR' | 'NEUTRAL' | 'SMOG' | 'FOGGY' | 'OVERCAST' | 'CLOUDS' | 'CLEARING' | 'RAIN' | 'THUNDER' | 'SNOW' | 'BLIZZARD' | 'SNOWLIGHT' | 'XMAS' | 'HALLOWEEN' | 
state.weather = {
    current = Config.StartWeather or "EXTRASUNNY",
}

---@param weatherType string
---@return boolean
local function isValidWeatherType(weatherType)
    return validWeatherTypes[weatherType] ~= nil
end

---@param weatherType string
---@return boolean, {success: boolean, message: string}
function SetWeather(weatherType)

    if freezeWeather then weatherType = state.weather.current end

    weatherType = string.upper(weatherType)

    if not isValidWeatherType(weatherType) then
        return false, {success = false, message = "Invalid weather type"}
    end

    state.weather = {
        current = weatherType
    }

    return true, {success = true, message = "Weather changed to: " .. state.weather.current}
end

exports("SetWeather", SetWeather)

function ToggleFreezeWeather()
    freezeWeather = not freezeWeather
end

---@return string
local function getRandomWeather()
    return Config.AvailableWeatherTypes[math.random(1, #Config.AvailableWeatherTypes)]
end

AddStateBagChangeHandler("weather", nil, function(_, _, value, _, replicated)
    print("Weather changed to: ", value.current)
end)

CreateThread(function()
    local isDynamicWeather = Config.weatherChangeEvery > 0
    while isDynamicWeather do
        local newWeather = getRandomWeather()
        SetWeather(newWeather)

        Wait(Config.weatherChangeEvery * 60000)
    end
end)