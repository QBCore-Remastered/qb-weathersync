Config = Config or {}

Config.WeatherChangeEvery              = 10                      -- Time in minutes, set to 0 to disable
Config.StartingWeather                 = 'EXTRASUNNY'            -- See below for other options
Config.StartingTime                    = {hour = 12, minute = 0} -- Time to start the resource
Config.RealSecondsIGMinutes = 8
Config.FreezeTime                      = false
Config.FreezeWeather                   = false
Config.Blackout                        = false
Config.BlackoutAffectsVehicles         = false
Config.UseServerTime                   = false                   -- Sync game time with servers OS time
Config.UseRealWeather                  = {
    enabled = true,
    country = "US",
    city = "Snowdon"
}

Config.NextWeatherLogic = {
    ['CLEAR'] = { 'CLEARING', 'OVERCAST' },
    ['CLOUDS'] = { 'CLEARING', 'OVERCAST' },
    ['EXTRASUNNY'] = { 'CLEARING', 'OVERCAST' },
    ['CLEARING'] = { 'FOGGY', 'CLOUDS', 'CLEAR', 'EXTRASUNNY', 'SMOG', 'FOGGY' },
    ['OVERCAST'] = { 'RAIN', 'CLOUDS', 'CLEAR', 'EXTRASUNNY', 'SMOG', 'FOGGY' },
    ['THUNDER'] = { 'CLEARING' },
    ['RAIN'] = { 'CLEARING' },
    ['SMOG'] = { 'CLEAR' },
    ['FOGGY'] = { 'CLEAR' }
}

Config.PredefinedTimes = {
    morning   = { hour = 9,  minute = 0, help = 'Set the time to 09:00' },
    noon      = { hour = 12, minute = 0, help = 'Set the time to 12:00' },
    evening   = { hour = 18, minute = 0, help = 'Set the time to 18:00' },
    night     = { hour = 23, minute = 0, help = 'Set the time to 23:00' },
}

Config.AvailableWeatherTypes = { -- DON'T TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING
    'EXTRASUNNY', 'CLEAR', 'NEUTRAL', 'SMOG', 'FOGGY', 'OVERCAST', 'CLOUDS','CLEARING',
    'RAIN', 'THUNDER', 'SNOW', 'BLIZZARD', 'SNOWLIGHT', 'XMAS', 'HALLOWEEN',
}