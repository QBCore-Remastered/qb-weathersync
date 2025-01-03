local stateBagHandlers = {}

local rainLevels = {
    RAIN = 0.3,
    THUNDER = 0.5,
}

local function setWeather(weatherType)
    SetWeatherTypeOverTime(weatherType, 15.0)
    Wait(15000)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist(weatherType)
    SetWeatherTypeNow(weatherType)
    SetWeatherTypeNowPersist(weatherType)
    SetForceVehicleTrails(not weatherType == 'XMAS')
    SetForcePedFootstepsTracks(not weatherType == 'XMAS')
    SetRainLevel(rainLevels[weatherType] or 0.0)
end

local function setBlackout(enabled)
    SetArtificialLightsState(enabled)
    SetArtificialLightsStateAffectsVehicles(enabled and Config.BlackoutAffectsVehicles or false)
end

local function setTime(hour, minute)
    print("Setting time to: ", hour, minute)
    NetworkOverrideClockTime(hour, minute, 0)
end

local function removeStateHandlers()
    for _, handler in pairs(stateBagHandlers) do
        RemoveStateBagChangeHandler(handler)
    end
end

local function addStateHandlers()
    removeStateHandlers()

    stateBagHandlers.weather = AddStateBagChangeHandler("weather", nil, function(_, _, value, _, replicated)
        if replicated then return end
        setWeather(value.current)
    end)

    stateBagHandlers.blackout = AddStateBagChangeHandler("blackout", nil, function(_, _, value, _, replicated)
        if replicated then return end
        setBlackout(value)
    end)
    stateBagHandlers.time = AddStateBagChangeHandler("time", nil, function(_, _, value, _, replicated)
        if replicated then return end
        setTime(value.hour, value.minute)
    end)
end

addStateHandlers()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', addStateHandlers)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', removeStateHandlers)
