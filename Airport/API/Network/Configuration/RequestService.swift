//
//  RequestService.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public protocol RequestService {
    func request(request: TargetType) -> Single<Moya.Response>
}

public struct RequestServiceProvider: RequestService {
    
    private let provider: MoyaProvider<MultiTarget>
    
    public init(endpointClosure: @escaping MoyaProvider<MultiTarget>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
                stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider.neverStub,
                session: Session = MoyaProvider<MultiTarget>.defaultAlamofireSession(),
                plugins: [PluginType] = [CachePlugin()],
                trackInflights: Bool = false) {
        
        self.provider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure,
                                                  stubClosure: stubClosure,
                                                  callbackQueue: nil,
                                                  session: session,
                                                  plugins: plugins,
                                                  trackInflights: trackInflights)
    }
    
    public func request(request: TargetType) -> Single<Response> {
        return provider.rx.request(MultiTarget(request))
    }
}

protocol CachePolicyGettable {
    var cachePolicy: URLRequest.CachePolicy { get }
}

public struct CachePlugin: PluginType {
    
    public init() { }
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        
        if let cachePolicyGettable = target as? CachePolicyGettable {
            var mutableRequest = request
            mutableRequest.cachePolicy = cachePolicyGettable.cachePolicy
            return mutableRequest
        }
        
        return request
    }
}
