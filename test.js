const key = "5bc5a681a79402cd8c98beb8ee7f8749"
const getWeather = function(city, country, key) {

    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city},${country}&appid=${key}`
    console.log(url)
    const local_weather = fetch(url).then(response => response.json()).then(data => console.log(data))
}


getWeather("London", "GB", key)