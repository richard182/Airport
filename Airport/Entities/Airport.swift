//
//  Airport.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import MapKit

struct Airport {
    
    let airportID: String
    let code: String
    let name: String
    let cityId: String
    let cityName: String
    let countryCode: String
    let location: CLLocationCoordinate2D
    
    init(airportID: String, code: String, name: String, cityId: String, cityName: String, countryCode: String, location: CLLocationCoordinate2D) {
        self.airportID = airportID
        self.code = code
        self.name = name
        self.cityId = cityId
        self.cityName = cityName
        self.countryCode = countryCode
        self.location = location
    }
}
