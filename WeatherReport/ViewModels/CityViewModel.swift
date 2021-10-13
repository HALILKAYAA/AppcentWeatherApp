//
// Created by Halil Kaya on 7.10.2021.
//

import Foundation
import Alamofire
import SwiftUI
import CoreLocation

class CityViewModel: ObservableObject {
    @Published var consolidated = ConsolidatedWeather() {
        didSet {
            if (consolidated.weather.count > 0) {
                today = consolidated.weather[0]
            }
            if (consolidated.weather.count > 1) {
                daily = consolidated.weather[1...consolidated.weather.count-1]
            }
        }
    }
    @Published var daily: ArraySlice<Weather> = []
    @Published var city: String = "antalya" {
        didSet {
            getLocation()
        }
    }

    init() {
        getLocation()
    }

    @Published var location: Location = Location()
    @Published var cityDetails: Coordinates = Coordinates()
    
    var today: Weather = Weather()

    func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.loadLocationCoord(coord: place.location?.coordinate)
            }
        }
    }
    func loadLocationCoord(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let latlon = "\(coord.latitude),\(coord.longitude)"
            ApiManager.getWithCoord(latlon) { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let response):
                    if (response.count > 0) {
                        self.cityDetails = response[0]
                        self.loadLocationWeather(locationId: self.cityDetails.id)
                        self.location.title = self.location.title
                    }
                }
            }
        } else {
            let latlon = "41.040852,28.986179"
            ApiManager.getWithCoord(latlon) { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let response):
                    if (response.count > 0) {
                        self.loadLocationWeather(locationId: 2344116)
                    }
                }
            }
        }
    }
    func getCityLocation() {
            ApiManager.getLocation(city) { result in
                switch result {
                case .failure(let err):
                    print(err)
                case .success(let response):
                    if (response.count > 0) {
                        self.location = response[0]
                        self.loadLocationWeather(locationId: self.location.id)
                    }
                }
            }
        }
    
    func loadLocationWeather(locationId: Int) {
        //print("locationId :  \(locationId)")
        ApiManager.loadLocationWeather(locationId) { result  in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let response):
                //print(response)
                self.consolidated = response
                self.location.title = self.cityDetails.title
                self.location.locationType = self.cityDetails.locationType
            }
        }
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()

    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()

    private lazy var fromStringFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()

    var date: String {
        return dateFormatter.string(
                from: today.date != "" ? fromStringFormatter.date(from: today.date)! : Date()
        )
    }

    var temperature: String {
        return getTempFor(temp: today.temp)
    }

    var conditions: String {
        return today.weatherStateName
    }

    var windSpeed: String {
        return String(format: "%0.1f", today.windSpeed)
    }

    var humidity: String {
        return String(format: "%d%%", today.humidity)
    }

    var predictability: String {
        return String(format: "%d%%", today.predictability)
    }

    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }

    func getTimeFor(time: String) -> String {
        return timeFormatter.string(
                from: fromStringFormatter.date(from: time)!
        )
    }

    func getDayFor(time: String) -> String {
        return dayFormatter.string(
                from: fromStringFormatter.date(from: time)!
        )
    }
    var weatherIcon: String {
        if today.icon.count > 0 {
            return today.icon
        }
        return "dayClearSky"
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "c":
            return Image(systemName: "sun.max.fill")
        case "lc":
            return Image(systemName: "cloud.sun.fill")
        case "hc":
            return Image(systemName: "cloud.fill")
        case "s":
            return Image(systemName: "cloud.drizzle.fill")
        case "lr":
            return Image(systemName: "cloud.drizzle.fill")
        case "hr":
            return Image(systemName: "cloud.heavyrain.fill")
        case "t":
            return Image(systemName: "cloud.bolt.fill")
        case "sn":
            return Image(systemName: "cloud.snow.fill")
        case "sl":
            return Image(systemName: "cloud.fog.fill")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
    func getLottieAnimationFor(icon: String) -> String {
        switch icon {
        case "c":
            return "dayClearSky"
        case "lc":
            return "dayFewClouds"
        case "hc":
            return "nightFewClouds"
        case "s":
            return "dayShowerRains"
        case "lr":
            return "nightShowerRains"
        case "hr":
            return "dayRain"
        case "t":
            return "dayThunderstorm"
        case "sn":
            return "daySnow"
        case "sl":
            return "dayMist"
        default:
            return "dayClearSky"
        }
    }
    
}
