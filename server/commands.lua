-- Weather Commands
RegisterCommand("weather", function(source, args)
    local weatherType = args[1]
    if not weatherType then
        TriggerClientEvent("QBCore:Notify", source, "Usage: /weather [weatherType]", "error")
        return
    end

    local success, message = SetWeather(weatherType)
    TriggerClientEvent("QBCore:Notify", source, message.message, success and "success" or "error")
end, true)

RegisterCommand("freezeweather", function(source, args)
    ToggleFreezeWeather()
end, true)

-- Time Commands
RegisterCommand("time", function(source, args)
    local hour = tonumber(args[1])
    local minute = tonumber(args[2])

    if not hour or not minute then
        TriggerClientEvent("QBCore:Notify", source, "Invalid time format, use /time [hour] [minute]", "error")
        return
    end

    local success, message = SetTime(hour, minute)
    TriggerClientEvent("QBCore:Notify", source, message.message, success and "success" or "error")
end, true)

RegisterCommand("freezetime", function()
    ToggleFreezeTime()
end, true)

local times = {
    morning = {hour = 9, minute = 0},
    noon = {hour = 12, minute = 0},
    evening = {hour = 18, minute = 0},
    night = {hour = 23, minute = 0},
}

for time, data in pairs(times) do
    RegisterCommand(time, function()
        SetTime(data.hour, data.minute)
    end, true)
end

-- Blackout Commands
RegisterCommand("blackout", function(source, args)
    local enable = args[1] == "true" or args[1] == "1" or false
    SetBlackout(enable)
end, true)