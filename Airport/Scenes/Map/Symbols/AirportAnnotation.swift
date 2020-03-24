//
//  AirportAnnotation.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import UIKit
import MapKit

class AirportAnnotation: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var address: String?
    var id: String?
    
    init(coordinate: CLLocationCoordinate2D, name: String, address: String, id: String) {
        self.coordinate = coordinate
        self.title = name
        self.address = address
        self.id = id
    }
}
