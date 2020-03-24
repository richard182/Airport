//
//  RequestHandler.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public protocol RequestHandler {
    var provider: RequestService { get }
}

public extension RequestHandler {
    
    func performRequest<T: ResponseMappable>(_ endpoint: TargetType) -> Observable<[T]> {
        return Observable.create { observer in
            
            _ = self.provider.request(request: endpoint)
                .filterSuccessfulStatusCodes()
                .map(to: [T].self)
                .subscribe { event in
                    
                    switch event {
                    case .success(let response):
                        observer.onNext(response)
                        observer.onCompleted()
                        
                    case .error(let error):
                        observer.onError(error)
                        observer.onCompleted()
                    }
            }
            
            return Disposables.create()
        }
    }
}
