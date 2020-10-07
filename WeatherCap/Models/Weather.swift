//
//  Weather.swift
//  WeatherCap
//
//  Created by Christophe Mei on 07/10/2020.
//

struct Weather: Codable {
    var lat: Float?
    var lon: Float?
    var timezone: String?
    var timezoneOffset: Int?
    var current: WeatherHour?
    var hourly: [WeatherHour]?
    var daily: [WeatherDay]?

    enum CodingKeys: String, CodingKey {
        case lat
        case lon
        case timezone
        case timezoneOffset = "timezone_offset"
        case current
        case hourly
        case daily
    }
}

struct WeatherHour: Codable {
    var dt: Int?
    var sunrise: Int?
    var sunset: Int?
    var temp: Float?
    var pressure: Int?
    var humidity: Int?
    var uvi: Float?
    var clouds: Int?
    var visibility: Int?
    var windSpeed: Float?
    var windDeg: Int?
    var weather: [WeatherDescription]?

    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case pressure
        case humidity
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

struct WeatherDay: Codable {
    var dt: Int?
    var sunrise: Int?
    var sunset: Int?
    var temp: WeatherTemp?
    var pressure: Int?
    var humidity: Int?
    var uvi: Float?
    var clouds: Int?
    var visibility: Int?
    var windSpeed: Float?
    var windDeg: Int?
    var weather: [WeatherDescription]?

    enum CodingKeys: String, CodingKey {
        case dt
        case sunrise
        case sunset
        case temp
        case pressure
        case humidity
        case uvi
        case clouds
        case visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case weather
    }
}

struct WeatherDescription: Codable {
    var weatherId: Int?
    var main: String?
    var weatherDescription: String?
    var icon: String?

    enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case main
        case weatherDescription = "description"
        case icon
    }
}

struct WeatherTemp: Codable {
    var day: Float?
    var min: Float?
    var max: Float?
    var night: Float?
    var eve: Float?
    var morn: Float?
}
