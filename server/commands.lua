QBCore = exports["qb-core"]:GetCoreObject()

local permission = Config.CommandPermission

QBCore.Commands.Add("blackout", "Toggle blackout mode.", {}, false, function(_, args)
    local enable = args[1] == "true" or args[1] == "1" or false
    SetBlackout(enable)
end, permission)

QBCore.Commands.Add("time", "Change the server time.", {{ name = "hour", help = "A number between 0 - 23" }, { name = "minute", help = "A number between 0 - 59"}}, true, function(source, args)
    local hour = tonumber(args[1])
    local minute = tonumber(args[2])

    if not hour or not minute then
        TriggerClientEvent("QBCore:Notify", source, "Invalid time format, use /time [hour] [minute]", "error")
        return
    end

    local success, message = SetTime(hour, minute)
    TriggerClientEvent("QBCore:Notify", source, message.message, success and "success" or "error")
end, permission)

QBCore.Commands.Add("freezetime", "Freeze / unfreeze time.", {}, false, ToggleFreezeTime, permission)

QBCore.Commands.Add("weather", "Change the server weather.", {{ name = "weather", help = "Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween"}}, true, function(source, args)
    local weatherType = args[1]
    if not weatherType then
        TriggerClientEvent("QBCore:Notify", source, "Usage: /weather [weatherType]", "error")
        return
    end

    local success, message = SetWeather(weatherType)
    TriggerClientEvent("QBCore:Notify", source, message.message, success and "success" or "error")
end, permission)

QBCore.Commands.Add("freezeweather", "Enable/disable dynamic weather changes.", {}, false, ToggleFreezeWeather, permission)

local times = {
    morning = {hour = 9, minute = 0, help = "Set the time to 09:00"},
    noon = {hour = 12, minute = 0, help = "Set the time to 12:00"},
    evening = {hour = 18, minute = 0, help = "Set the time to 18:00"},
    night = {hour = 23, minute = 0, help = "Set the time to 23:00"},
}

for time, data in pairs(times) do
    QBCore.Commands.Add(time, data.help, {}, false, function()
        SetTime(data.hour, data.minute)
    end, permission)
end
