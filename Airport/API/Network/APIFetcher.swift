//
//  APIFetcher.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol AirportAPIFetcher {
    func fetchRequest<T: ResponseMappable>(endpoint: TargetType) -> Observable<[T]>
}

struct AirportAPIFetcherImplementation: AirportAPIFetcher, RequestHandler {

    // MARK: - Properties
    let provider: RequestService
    
    // MARK: - Initialization
    init(provider: RequestService) {
        self.provider = provider
    }
    
    func fetchRequest<T>(endpoint: TargetType) -> Observable<[T]> where T : ResponseMappable {
        return performRequest(endpoint)
    }
}
