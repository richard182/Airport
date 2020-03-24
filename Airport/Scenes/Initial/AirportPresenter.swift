//
//  AirportPresenter.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation

protocol AiportPresentationLogic {
    func displayAirports(_ airports: [Airport])
    func diplayError(_ error: String)
}
final class AiportPresenter: AiportPresentationLogic {

    weak var viewController: AirportViewController?

    func displayAirports(_ airports: [Airport]) {
        viewController?.displayAirports(airports)
    }
    
    func diplayError(_ error: String) {
        viewController?.displayError(description: error)
    }
}
