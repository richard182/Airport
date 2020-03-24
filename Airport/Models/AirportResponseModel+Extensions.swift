//
//  AirportResponseModel+Extensions.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation

extension AirportResponseModel {
    
    func mapToAirport() -> Airport {
        
        return Airport(airportID: airportID,
                       code: code,
                       name: name,
                       cityId: cityId,
                       cityName: cityName,
                       countryCode: countryCode,
                       location: location)
    }
}
