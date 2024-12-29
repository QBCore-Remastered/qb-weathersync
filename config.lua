Config = {
    weatherChangeEvery              = 10, -- Time in minutes, set to 0 to disable
    startingWeather                 = 'EXTRASUNNY', -- See below for other options
    howManySecondsForAnInGameMinute = 8,
    freezeTime                      = false,
    blackout                        = false,
    blackoutAffectsVehicles         = false,
    useServerTime                   = false, -- Sync game time with servers OS time
}

Config.AvailableWeatherTypes = { -- DON'T TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING
    'EXTRASUNNY', 'CLEAR', 'NEUTRAL', 'SMOG', 'FOGGY', 'OVERCAST', 'CLOUDS','CLEARING',
    'RAIN', 'THUNDER', 'SNOW', 'BLIZZARD', 'SNOWLIGHT', 'XMAS', 'HALLOWEEN',
}
