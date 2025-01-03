local state = GlobalState
local baseTime = Config.howManySecondsForAnInGameMinute * 1000
local freezeTime = Config.freezeTime or false

---@class Time
---@field hour number
---@field minute number
state.time = {
    hour = 00,
    minute = 00,
}

---@class Blackout
---@field enabled boolean
state.blackout = {
    enabled = Config.blackout,
}

-- To ensure a value is between a min and max
---@param val number
---@param min number
---@param max number
local function clamp(val, min, max)
    if val < min then return min end
    if val > max then return max end
    return val
end

--- Ensures a value is a number
---@param value any
---@param name string
---@return boolean
local function isValidNumber(value, name)
    local valueType = type(value)
    if not (valueType == "number") then
        warn("Invalid argument to ", name, ". number expected, got: ", valueType)
        return false
    end
    return true
end

--- Sets the time to the provided hour and minute
---@param hour number
---@param minute number
---@return boolean, {success: boolean, message: string}
local function setTime(hour, minute)

    if not isValidNumber(hour, "hour") then return false, {success = false, message = "Invalid hour type"} end
    if not isValidNumber(minute, "minute") then return false, {success = false, message = "Invalid minute type"} end
    
    if minute > 59 then minute = 0; hour = hour + 1 end
    if hour > 23 then hour = 0 end

    state.time = {
        hour = clamp(hour, 0, 23),
        minute = clamp(minute, 0, 59),
        isMorning = hour < 12,
        isAfternoon = hour >= 12 and hour < 18,
        isEvening = hour >= 18 and hour < 23,
        isNight = hour >= 23 or hour < 6,
    }

    return true, {success = true, message = "Time changed to: " .. state.time.hour .. ":" .. state.time.minute}
end

exports("setTime", setTime)

CreateThread(function()
    while true do
        if Config.useServerTime then
            local realTime = os.date("*t")
            setTime(realTime.hour, realTime.min)
        end
        local currentMinute = state.time.minute
        local currentHour = state.time.hour
        local nextMinute = freezeTime and 0 or 1
        setTime(currentHour, currentMinute + nextMinute)
        Wait(baseTime or 8)
    end
end)

RegisterNetEvent('qb-weathersync:ChangeTime', function(hour, minute)
    local src = source
    if src == 0 then return end

    if not IsPlayerAceAllowed(src, 'command') then return end

    setTime(tonumber(hour), tonumber(minute))
end)

RegisterCommand("time", function(source, args)
    if not args[1] and source ~= 0 and IsPlayerAceAllowed(source, 'command') then
        return TriggerClientEvent('qb-weathersync:TimeInput', source)
    end

    local hour = tonumber(args[1])
    local minute = tonumber(args[2])
    setTime(hour, minute)
end, true)

RegisterCommand("freezetime", function()
    freezeTime = not freezeTime
end, true)

local times = {
    morning = {hour = 9, minute = 0},
    noon = {hour = 12, minute = 0},
    evening = {hour = 18, minute = 0},
    night = {hour = 23, minute = 0},
}

for time, data in pairs(times) do
    RegisterCommand(time, function()
        setTime(data.hour, data.minute)
    end, true)
end