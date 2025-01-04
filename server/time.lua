local state = GlobalState
local baseTime = Config.RealSecondsIGMinutes * 1000
local timeFrozen = Config.FreezeTime or false

---@class Time
---@field hour number
---@field minute number
state.time = {
    hour = 00,
    minute = 00,
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
        frozen = timeFrozen,
    }

    return true, {success = true, message = "Time changed to: " .. state.time.hour .. ":" .. state.time.minute}
end

exports("setTime", setTime)

local function freezeTime(bool)
    if bool ~= nil then
        timeFrozen = bool
        return 
    end

    timeFrozen = not timeFrozen
    return timeFrozen
end

exports("freezeTime", freezeTime)

CreateThread(function()
    while true do
        if Config.UseServerTime then
            local realTime = os.date("*t")
            setTime(realTime.hour, realTime.min)
        end
        local currentMinute = state.time.minute
        local currentHour = state.time.hour
        local nextMinute = timeFrozen and 0 or 1
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