//
//  ResponseMappable.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation

public protocol ResponseMappable {
    init(map: [String: Any])
}

public extension Dictionary where Key == String {
    
    func from<T>(_ key: String) -> T? {
        return self[key] as? T
    }
    
    func from<T: ResponseMappable>(_ field: String) -> T? {
        
        if let JSON: [String: Any] = from(field) {
            return T(map: JSON)
        }
        
        return nil
    }
    
    func from<T: ResponseMappable>(_ field: String) -> [T]? {
        
        if let JSON: [[String: Any]] = from(field) {
            return JSON.map { T(map: $0) }
        }
        
        return nil
    }
}
