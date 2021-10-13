//
// Created by Halil Kaya on 7.10.2021.
//

import Foundation

struct ConsolidatedWeather: Codable {
    var weather: Array<Weather>
    var title: String
    var locationType: String
    
    enum CodingKeys: String, CodingKey {
        case weather = "consolidated_weather"
        case title
        case locationType = "location_type"
    }

    init(initId: Int = 1) {
        weather = []
        title = ""
        locationType = ""
    }
}

struct Weather: Codable, Identifiable {
    var id: Int
    var weatherStateName: String
    var humidity: Int
    var predictability: Int
    var temp: Double
    var minTemp: Double
    var maxTemp: Double
    var windSpeed: Double
    var date: String
    var icon: String


    enum CodingKeys: String, CodingKey {
        case id
        case weatherStateName = "weather_state_name"
        case icon = "weather_state_abbr"
        case humidity
        case predictability
        case temp = "the_temp"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case windSpeed = "wind_speed"
        case date = "applicable_date"
    }

    init(initId: Int = 1) {
        id = initId
        weatherStateName = ""
        humidity = 0
        predictability = 0
        temp = 0
        minTemp = 0
        maxTemp = 0
        windSpeed = 0
        date = ""
        icon = ""
    }
}
