local Translations = {
    weather = {
        now_frozen = 'El clima ahora está congelado.',
        now_unfrozen = 'El clima ya no está congelado.',
        invalid = 'Tipo de tiempo inválido, los tipos de tiempo válidos son: \nEXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN ',
        willchangeto = 'El tiempo cambiará a: %{value}.',
    },
    time = {
        now_frozen = 'El tiempo ahora está congelado.',
        now_unfrozen = 'El tiempo ya no se congela.',
        morning = 'El tiempo se ha establecido por la mañana.',
        noon = 'El tiempo se ha establecido por el mediodía.',
        evening = 'El tiempo se ha establecido por la tarde.',
        night = 'El tiempo se ha establecido por la noche.',
        change = 'El tiempo ha cambiado a %{hour}:%{minute}.',
        invalidh = 'Hora inválida, las horas válidas son: 0 - 23',
        invalidm = 'Minutos inválidos, los minutos válidos son: 0 - 59',
        access = 'Acceso para comando /time denegador.',
    },
    blackout = {
        enabled = 'El apagón está ahora habilitado.',
        disabled = 'El apagón ahora está deshabilitado.',
    },
    help = {
        weathercommand = 'Cambia el clima.',
        weathertype = 'tipo',
        availableweather = 'Tipos disponibles: extrasunny, clear, neutral, smog, foggy, overcast, clouds, clearing, rain, thunder, snow, blizzard, snowlight, xmas & halloween',
        timecommand = 'Cambiar el tiempo.',
        timehname = 'Hora',
        timemname = 'Minutos',
        timeh = 'un numero entre 0 - 23',
        timem = 'un numero entre 0 - 59',
        freezecommand = 'Detiene/continua el tiempo.',
        truefalse = 'true/false',
        freezeweathercommand = 'Activa/desactiva cambios dinámicos del clima.',
        morningcommand = 'Establezca el tiempo para las 09:00',
        nooncommand = 'Establezca el tiempo para las 12:00',
        eveningcommand = 'Establezca el tiempo para las 18:00',
        nightcommand = 'Establezca el tiempo para las 23:00',
        blackoutcommand = 'Cambiar el modo de apagón.',
    },
    menu = {
        weatherselection = 'Selección de clima',
        setweather = 'Establecer el clima a: %{value}',
        timeselection = 'Selección de tiempo',
        timesubmit = 'Ingresar tiempo',
        hour = 'Hora',
        minute = 'Minutos',
    },
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
