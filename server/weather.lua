print("HERE")

if Config.UseRealWeather.enabled then
    local city = Config.UseRealWeather.city
    local country = Config.UseRealWeather.country
    local key = Config.WeatherAPI.key
    local map = Config.WeatherAPI.map

    print('Getting weather for: ' .. city .. ', ' .. country)

    local weather = Config.WeatherAPI.getWeather(city, country, key, map)
    print('Weather: ', weather)
end


local state = GlobalState
local weatherFrozen = Config.FreezeWeather or false
local validWeatherTypes = {}
local weatherThreads = {}

for _, validWeatherType in pairs(Config.AvailableWeatherTypes) do
    validWeatherTypes[validWeatherType] = true
end

---@class Weather
---@field current 'EXTRASUNNY' | 'CLEAR' | 'NEUTRAL' | 'SMOG' | 'FOGGY' | 'OVERCAST' | 'CLOUDS' | 'CLEARING' | 'RAIN' | 'THUNDER' | 'SNOW' | 'BLIZZARD' | 'SNOWLIGHT' | 'XMAS' | 'HALLOWEEN' | 
state.weather = {
    current = Config.StartWeather or 'EXTRASUNNY',
    lastChanged = 0,
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
        return false, {success = false, message = 'Invalid weather type'}
    end

    state.weather = {
        current = weatherType,
        lastChanged = GetGameTimer(),
    }

    weatherThreads[#weatherThreads] = false
    WeatherThread()

    return true, {success = true, message = 'Weather changed to: ' .. state.weather.current}
end

exports('setWeather', setWeather)

---@return string
local function getRandomWeather()
    local current = Config.NextWeatherLogic[state.weather.current]
    if not current then return 'CLEAR' end
    return current[math.random(#current)] or 'CLEAR'
end

function WeatherThread()
    local isDynamicWeather = Config.WeatherChangeEvery > 0
    if not isDynamicWeather then return end

    local id = #weatherThreads+1
    weatherThreads[id] = true

    Citizen.CreateThreadNow(function()
        Wait(Config.WeatherChangeEvery * 60000)

        if not weatherThreads[id] then
            weatherThreads[id] = nil
            return
        end

        local newWeather = getRandomWeather()
        setWeather(newWeather)
    end)
end

local function freezeWeather(bool)
    if bool ~= nil then
        weatherFrozen = bool
        return
    end

    -- toggle if true or false is not provided
    weatherFrozen = not weatherFrozen
    return weatherFrozen
end

exports('freezeWeather', freezeWeather)

RegisterNetEvent('qb-weathersync:ChangeWeather', function(args)

    local src = source
    if src == 0 then return end

    if not IsPlayerAceAllowed(src, 'command') then return end

    local success, message = setWeather(args.weatherType)
end)

WeatherThread()
