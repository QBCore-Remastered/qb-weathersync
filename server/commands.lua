local weather = exports['qb-weathersync']

local booleans = {
    ["true"] = true,
    ["false"] = false,
    ["1"] = true,
    ["0"] = false,
}

-- Weather Commands
RegisterCommand("weather", function(source, args)
    local weatherType = args[1]
    if not weatherType and source ~= 0 and IsPlayerAceAllowed(source, 'command') then
        return TriggerClientEvent('qb-weathersync:WeatherMenu', source)
    end

    local success, message = weather:setWeather(weatherType)
end, true)

RegisterCommand("freezeweather", function(source, args)
    weather:freezeWeather(booleans[args[1]])
end, true)

-- Time Commands
RegisterCommand("time", function(source, args)
    if not args[1] and source ~= 0 and IsPlayerAceAllowed(source, 'command') then
        return TriggerClientEvent('qb-weathersync:TimeInput', source)
    end

    local hour = tonumber(args[1])
    local minute = tonumber(args[2])
    weather:setTime(hour, minute)
end, true)

RegisterCommand("freezetime", function(source, args)
    weather:freezeTime(booleans[args[1]])
end, true)

local times = {
    morning = {hour = 9, minute = 0},
    noon = {hour = 12, minute = 0},
    evening = {hour = 18, minute = 0},
    night = {hour = 23, minute = 0},
}

for time, data in pairs(times) do
    RegisterCommand(time, function()
        weather:setTime(data.hour, data.minute)
    end, true)
end

-- Blackout Commands
RegisterCommand("blackout", function(source, args)
    weather:setBlackout(booleans[args[1]] or false)
end, true)