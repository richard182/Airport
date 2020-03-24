//
//  AirportInteractor.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import RxSwift

protocol AirportBusinessLogic {
    func getWeather(request: AirportByRadiusRequestModel)
}

final class AirportInteractor: AirportBusinessLogic {
    
    var presenter: AiportPresentationLogic?
    var worker: AirportWorker?
    
    private let disposeBag = DisposeBag()
    
    // MARK: get airports
    func getWeather(request: AirportByRadiusRequestModel) {
        let provider = RequestServiceProvider()
        let fetcher = AirportAPIFetcherImplementation(provider: provider)
        worker = AirportWorker(fetcher: fetcher)
        worker?
            .getAirport(by: request)
            .subscribe(onNext: { [weak self] airports in
                    airports.isEmpty ? self?.presenter?.diplayError("No encontramos estaciones cercanas") : self?.presenter?.displayAirports(airports)
                }, onError: { _ in
                    self.presenter?.diplayError("Ocurrio un error")
            }).disposed(by: disposeBag)
    }
}
