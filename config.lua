Config = Config or {}

Config.WeatherChangeEvery              = 10             -- Time in minutes, set to 0 to disable
Config.StartingWeather                 = 'EXTRASUNNY'   -- See below for other options
Config.RealSecondsIGMinutes = 8
Config.FreezeTime                      = false
Config.FreezeWeather                   = false
Config.Blackout                        = false
Config.BlackoutAffectsVehicles         = false
Config.UseServerTime                   = false          -- Sync game time with servers OS time

Config.AvailableWeatherTypes = { -- DON'T TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING
    'EXTRASUNNY', 'CLEAR', 'NEUTRAL', 'SMOG', 'FOGGY', 'OVERCAST', 'CLOUDS','CLEARING',
    'RAIN', 'THUNDER', 'SNOW', 'BLIZZARD', 'SNOWLIGHT', 'XMAS', 'HALLOWEEN',
}