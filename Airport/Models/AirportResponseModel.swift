//
//  AirportResponseModel.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import MapKit

struct AirportResponseModel: ResponseMappable {
    
    let airportID: String
    let code: String
    let name: String
    let cityId: String
    let cityName: String
    let countryCode: String
    let location: CLLocationCoordinate2D
    let themes: [String]
    let pointsOfSale: [String]
    
    init(map: [String : Any]) {
        airportID = map.from("airportId") ?? ""
        code = map.from("code") ?? ""
        name = map.from("name") ?? ""
        cityId = map.from("cityId") ?? ""
        cityName = map.from("city") ?? ""
        countryCode = map.from("countryCode") ?? ""
        themes = map.from("themes") ?? []
        pointsOfSale = map.from("pointsOfSale") ?? []
        
        guard
            let locationMap: [String: Any] = map.from("location"),
            let longitude: Double = locationMap.from("longitude"),
            let latitude: Double = locationMap.from("latitude"),
            let latitudeDegrees = CLLocationDegrees(exactly: latitude),
            let longitudeDegrees = CLLocationDegrees(exactly: longitude)
        else {
            location = CLLocationCoordinate2D()
            return
        }
        
        location = CLLocationCoordinate2D(latitude: latitudeDegrees,
                                          longitude: longitudeDegrees)
    }    
}
