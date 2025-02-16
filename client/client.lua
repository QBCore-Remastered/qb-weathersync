local state = GlobalState
local timeFrozen = false

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
    NetworkOverrideClockTime(hour, minute, 0)
end

local function removeStateHandlers()
    for _, handler in pairs(stateBagHandlers) do
        RemoveStateBagChangeHandler(handler)
    end
end

local function startFreezeThread()
    if timeFrozen then return end

    timeFrozen = true
    CreateThread(function()
        while timeFrozen do
            setTime(state.time.hour, state.time.minute)
            Wait(500)
        end
    end)
end

local function addStateHandlers()
    removeStateHandlers()

    stateBagHandlers.weather = AddStateBagChangeHandler('weather', nil, function(_, _, value, _, replicated)
        if replicated then return end
        setWeather(value.current)
    end)

    stateBagHandlers.blackout = AddStateBagChangeHandler('blackout', nil, function(_, _, value, _, replicated)
        if replicated then return end
        setBlackout(value)
    end)
    stateBagHandlers.time = AddStateBagChangeHandler('time', nil, function(_, _, value, _, replicated)
        if replicated then return end
        setTime(value.hour, value.minute)
        startFreezeThread()
    end)
end


RegisterNetEvent('qb-weathersync:TimeInput', function()
    local input = exports['qb-input']:ShowInput({
        header = Lang:t('menu.timeselection'),
        submitText = Lang:t('menu.timesubmit'),
        inputs = {
            {
                text = Lang:t('menu.hour'),
                name = 'hour',
                type = 'number',
                isRequired = true,
            },
            {
                text = Lang:t('menu.minute'),
                name = 'minute',
                type = 'number',
                isRequired = true,
            },
        },
    })

    if input == nil then return end
    TriggerServerEvent('qb-weathersync:ChangeTime', input.hour, input.minute)
end)


RegisterNetEvent('qb-weathersync:WeatherMenu', function()
    local menuOptions = {}

    menuOptions[#menuOptions+1] = {
        isMenuHeader = true,
        header = Lang:t('menu.weatherselection'),
        icon = 'fa-solid fa-cloud'
    }

    for k, v in pairs(Config.AvailableWeatherTypes) do
        menuOptions[#menuOptions+1] = {
            header = v,
            txt = Lang:t('menu.setweather', { value = v }),
            params = {
                event = 'qb-weathersync:ChangeWeather',
                isServer = true,
                args = {
                    weatherType = v,
                }
            }
        }
    end

    exports['qb-menu']:openMenu(menuOptions)
end)

addStateHandlers()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', addStateHandlers)
RegisterNetEvent('QBCore:Client:OnPlayerUnload', removeStateHandlers)

TriggerEvent('chat:addSuggestion', '/weather', Lang:t('help.weathercommand'), {
    { name = Lang:t('help.weathertype'), help = Lang:t('help.availableweather') }
})

TriggerEvent('chat:addSuggestion', '/freezeweather', Lang:t('help.freezeweathercommand'), {
    { name = Lang:t('help.truefalse'), help = Lang:t('help.freezeweathercommand') }
})

TriggerEvent('chat:addSuggestion', '/time', Lang:t('help.timecommand'), {
    { name = Lang:t('help.timehname'), help = Lang:t('help.timeh') },
    { name = Lang:t('help.timemname'), help = Lang:t('help.timem') }
})

TriggerEvent('chat:addSuggestion', '/freezetime', Lang:t('help.freezecommand'), {
    { name = Lang:t('help.truefalse'), help = Lang:t('help.freezecommand') }
})

TriggerEvent('chat:addSuggestion', '/blackout', Lang:t('help.blackoutcommand'), {
    { name = Lang:t('help.truefalse'), help = Lang:t('help.blackoutcommand') }
})

for time, data in pairs(Config.PredefinedTimes) do
    TriggerEvent('chat:addSuggestion', '/'..time, data.help, {})
end