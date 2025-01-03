local state = GlobalState
local weatherFrozen = Config.FreezeWeather or false
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
local function setWeather(weatherType)

    if weatherFrozen then weatherType = state.weather.current end

    weatherType = string.upper(weatherType)

    if not isValidWeatherType(weatherType) then
        return false, {success = false, message = "Invalid weather type"}
    end

    state.weather = {
        current = weatherType
    }

    return true, {success = true, message = "Weather changed to: " .. state.weather.current}
end

exports("setWeather", setWeather)

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
        setWeather(newWeather)

        Wait(Config.WeatherChangeEvery * 60000)
    end
end)

local function freezeWeather(bool)
    if bool ~= nil then
        weatherFrozen = bool
        return 
    end

    -- toggle if true or false is not provided
    weatherFrozen = not weatherFrozen
end

exports("freezeWeather", freezeWeather)

RegisterNetEvent('qb-weathersync:ChangeWeather', function(args)

    local src = source
    if src == 0 then return end

    if not IsPlayerAceAllowed(src, 'command') then return end

    local success, message = setWeather(args.weatherType)
end)
