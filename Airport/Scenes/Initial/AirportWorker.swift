//
//  AirportWorker.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import RxSwift
import Moya

final class AirportWorker: SearchAPI {
    
    let fetcher: AirportAPIFetcher
    
    init(fetcher: AirportAPIFetcher) {
        self.fetcher = fetcher
    }
    
    func getAirport(by request: AirportByRadiusRequestModel) -> Observable<[Airport]> {
        let requestModel = request
        let endpoint = SearchByRadiusEndpoint.search(requestModel: requestModel)
        let request: Observable<[AirportResponseModel]> = fetcher.fetchRequest(endpoint: endpoint)
        
        return request.flatMap { responseModel -> Observable<[Airport]> in
            return .just(responseModel.map({ $0.mapToAirport() }) )
        }
    }
}
