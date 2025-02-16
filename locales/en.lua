local Translations = {
    weather = {
        now_frozen = 'Weather is now frozen.',
        now_unfrozen = 'Weather is no longer frozen.',
        invalid = 'Invalid weather type, valid weather types are: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'Weather will change to: %{weather}.',
    },
    time = {
        now_frozen = 'Time is now frozen.',
        now_unfrozen = 'Time is no longer frozen.',
        morning = 'Time set to morning.',
        noon = 'Time set to noon.',
        evening = 'Time set to evening.',
        night = 'Time set to night.',
        change = 'Time has changed to %{hour}:%{minute}.',
        invalidh = 'Invalid hour, valid hours are: 0 - 23',
        invalidm = 'Invalid minutes, valid minutes are: 0 - 59',
        access = 'Access for command /time denied.',
    },
    blackout = {
        enabled = 'Blackout is now enabled.',
        disabled = 'Blackout is now disabled.',
    },
    help = {
        weathercommand = 'Change the weather.',
        weathertype = 'weathertype',
        availableweather = 'Available types: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Change the time.',
        timehname = 'hours',
        timemname = 'minutes',
        timeh = 'A number between 0 - 23',
        timem = 'A number between 0 - 59',
        freezecommand = 'Freeze / unfreeze time.',
        truefalse = 'true/false',
        freezeweathercommand = 'Enable/disable dynamic weather changes.',
        morningcommand = 'Set the time to 09:00',
        nooncommand = 'Set the time to 12:00',
        eveningcommand = 'Set the time to 18:00',
        nightcommand = 'Set the time to 23:00',
        blackoutcommand = 'Toggle blackout mode.',
    },
    menu = {
        weatherselection = 'Weather Selection',
        setweather = 'Set the weather to: %{value}',
        timeselection = 'Time Selection',
        timesubmit = 'Enter Time',
        hour = 'Hour',
        minute = 'Minute',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
