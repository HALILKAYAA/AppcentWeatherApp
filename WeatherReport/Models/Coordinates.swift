//
// Created by Halil Kaya on 7.10.2021.
//

import Foundation

struct Coordinates: Codable, Identifiable {
    var distance: Int
    var title: String
    var locationType: String
    var id: Int
    var latt_long: String

    enum CodingKeys: String, CodingKey {
        case distance
        case title
        case locationType = "location_type"
        case id = "woeid"
        case latt_long
    }

    init(initId: Int = 1) {
        distance = initId
        title = ""
        locationType = ""
        id = initId
        latt_long = ""
    }
}
