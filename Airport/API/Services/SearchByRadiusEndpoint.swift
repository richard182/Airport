//
//  SearchByRadiusEndpoint.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import Moya

enum SearchByRadiusEndpoint: TargetType {
    
    case search(requestModel: AirportByRadiusRequestModel)
    
    var baseURL: URL {
        return URL(staticString: "https://cometari-airportsfinder-v1.p.rapidapi.com")
    }
    
    var path: String {
        return "api/airports/by-radius"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .search(let model):
            print("\(model.radius) \(model.longitude) \(model.latitude)")
            return .requestParameters(parameters:
                ["radius": model.radius,
                 "lng": model.longitude,
                 "lat": model.latitude
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["x-rapidapi-host": "cometari-airportsfinder-v1.p.rapidapi.com",
                "x-rapidapi-key": "2911a68842msh9b471fa7c956a6fp12d1a2jsn5b5504fb46a9"]
    }
}
