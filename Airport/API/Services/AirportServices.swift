//
//  AirportServices.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import RxSwift

protocol SearchAPI {
    func getAirport(by request: AirportByRadiusRequestModel) -> Observable<[Airport]>
}

