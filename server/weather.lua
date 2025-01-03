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
local function setWeather(weatherType)

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

exports("setWeather", setWeather)

---@return string
local function getRandomWeather()
    return Config.AvailableWeatherTypes[math.random(1, #Config.AvailableWeatherTypes)]
end

CreateThread(function()
    local isDynamicWeather = Config.weatherChangeEvery > 0
    while isDynamicWeather do
        local newWeather = getRandomWeather()
        setWeather(newWeather)

        Wait(Config.weatherChangeEvery * 60000)
    end
end)

RegisterNetEvent('qb-weathersync:ChangeWeather', function(args)
    local src = source
    if src == 0 then return end

    if not IsPlayerAceAllowed(src, 'admin') then return end

    local success, message = setWeather(args.weatherType)
end)

RegisterCommand("weather", function(source, args)
    local weatherType = args[1]
    if not weatherType and source ~= 0 then
        TriggerClientEvent('qb-weathersync:WeatherMenu', source)
        return
    end

    local success, message = setWeather(weatherType)
end, true)

RegisterCommand("freezeWeather", function(source, args)
    freezeWeather = not freezeWeather
end, true)