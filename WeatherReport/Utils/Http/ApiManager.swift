//
// Created by Halil Kaya on 7.10.2021.
//

import Foundation
import Alamofire
import CoreLocation


final class ApiManager {
    static func getLocation(_ location: String, callback: @escaping (Result<[Location], NetworkError>) -> Void) {
        let searchParam = location.replacingOccurrences(of: " ", with: "%20")
        let request = AF.request(
                "https://www.metaweather.com/api/location/search/?query=\(searchParam)",
                encoding: JSONEncoding.default
        )
        request.responseDecodable(of: Array<Location>.self) { response in
            switch response.result {
            case .failure:
                callback(.failure(.error(err: "Error loading location")))
            case .success:
                guard let data = response.value else {return}
                if (data.count > 0) {
                    callback(.success(data))
                }
            }
        }
    }
    static func getWithCoord(_ latlon: String, callback: @escaping (Result<[Coordinates], NetworkError>) -> Void) {
        //print("latlon     :   \(latlon)")
        let request = AF.request(
                "https://www.metaweather.com/api/location/search/?lattlong=\(latlon)",
                encoding: JSONEncoding.default
        )
        request.responseDecodable(of: Array<Coordinates>.self) { response in
            switch response.result {
            case .failure:
                callback(.failure(.error(err: "Error loading coordinates")))
            case .success:
                guard let data = response.value else {return}
                if (data.count > 0) {
                    callback(.success(data))
                }
            }
        }
    }
    static func loadLocationWeather(_ locationId: Int, callback: @escaping (Result<ConsolidatedWeather, NetworkError>) -> Void) {
        let request = AF.request(
                "https://www.metaweather.com/api/location/\(locationId)",
                encoding: JSONEncoding.default
        )
        request.responseDecodable(of: ConsolidatedWeather.self) { response in
            switch response.result {
            case .failure:
                callback(.failure(.error(err: "Error loading weather")))
            case .success:
                guard let data = response.value else {return}
                callback(.success(data))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(err: String)
    case error(err: String)
}
