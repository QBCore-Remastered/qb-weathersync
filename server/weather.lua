local state = GlobalState
local freezeWeather = Config.FreezeWeather or false
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

exports("setWeather", SetWeather)

---@return string
local function getRandomWeather()
    local current = Config.NextWeatherLogic[state.weather.current]
    if not current then return "CLEAR" end
    return current[math.random(#current)] or "CLEAR"
end

CreateThread(function()
    local isDynamicWeather = Config.WeatherChangeEvery > 0
    while isDynamicWeather do
        local newWeather = getRandomWeather()
        SetWeather(newWeather)

        Wait(Config.WeatherChangeEvery * 60000)
    end
end)

RegisterNetEvent('qb-weathersync:ChangeWeather', function(args)

    local src = source
    if src == 0 then return end

    if not IsPlayerAceAllowed(src, 'command') then return end

    local success, message = SetWeather(args.weatherType)
end)


function ToggleFreezeWeather()
    freezeWeather = not freezeWeather
end