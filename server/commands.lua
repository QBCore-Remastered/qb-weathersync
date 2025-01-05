local weather = exports['qb-weathersync']

local function notify(id, message, message_type, duration)
    TriggerClientEvent('QBCore:Notify', id, message, message_type, duration)
end

local booleans = {
    ['true'] = true,
    ['false'] = false,
    ['1'] = true,
    ['0'] = false,
}

-- Weather Commands
RegisterCommand('weather', function(source, args)
    local weatherType = args[1]
    if not weatherType and source ~= 0 and IsPlayerAceAllowed(source, 'command') then
        return TriggerClientEvent('qb-weathersync:WeatherMenu', source)
    end

    local success, message = weather:setWeather(weatherType)
    notify(source, message.message, message.success and 'success' or 'error', 5000)
end, true)

RegisterCommand('freezeweather', function(source, args)
    local frozen = weather:freezeWeather(booleans[args[1]])
    notify(source, 'Weather is now ' .. (frozen and 'frozen' or 'unfrozen'), 'primary', 5000)
end, true)

-- Time Commands
RegisterCommand('time', function(source, args)
    if not args[1] and source ~= 0 and IsPlayerAceAllowed(source, 'command') then
        return TriggerClientEvent('qb-weathersync:TimeInput', source)
    end

    local hour = tonumber(args[1])
    local minute = tonumber(args[2])
    local success, message = weather:setTime(hour, minute)
    notify(source, message.message, message.success and 'success' or 'error', 5000)
end, true)

RegisterCommand('freezetime', function(source, args)
    local frozen = weather:freezeTime(booleans[args[1]])
    notify(source, 'Time is now ' .. (frozen and 'frozen' or 'unfrozen'), 'primary', 5000)
end, true)

for time, data in pairs(Config.PredefinedTimes) do
    RegisterCommand(time, function()
        local success, message = weather:setTime(data.hour, data.minute)
        notify(source, message.message, message.success and 'success' or 'error', 5000)
    end, true)
end

-- Blackout Commands
RegisterCommand('blackout', function(source, args)
    local blackout = weather:setBlackout(booleans[args[1]] or false)
    notify(source, 'Blackout is now ' .. (blackout and 'enabled' or 'disabled'), 'primary', 5000)
end, true)