//
//  Response.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation
import RxSwift
import Moya

extension Response {
    
    func map<T: ResponseMappable>(to type: T.Type) throws -> T {
        
        guard let jsonDictionary = try mapJSON() as? [String: Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        return T(map: jsonDictionary)
    }
    
    func map<T: ResponseMappable>(to type: T.Type, atKeyPath keyPath: String) throws -> T {
        
        guard let jsonDictionary = try mapJSON() as? [String: Any],
            let jsonObject: [String: Any] = jsonDictionary.from(keyPath) else {
            throw MoyaError.jsonMapping(self)
        }
        
        return T(map: jsonObject)
    }
    
    func map<T: ResponseMappable>(to type: [T].Type) throws -> [T] {
       
        guard let jsonArray = try mapJSON() as? [[String: Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        
        return jsonArray.map { T(map: $0) }
    }
    
    func map<T: ResponseMappable>(to type: [T].Type, keyPath: String) throws -> [T] {
        
        guard let jsonDictionary = try mapJSON() as? [String: Any],
            let jsonArray: [[String: Any]] = jsonDictionary.from(keyPath) else {
                throw MoyaError.jsonMapping(self)
        }
        
        return jsonArray.map { T(map: $0) }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    func map<T: ResponseMappable>(to type: T.Type, keyPath: String? = nil) -> Single<T> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).flatMap { response -> Single<T> in
            return Single.just(try response.map(to: type))
        }.observeOn(MainScheduler.instance)
    }
    
    func map<T: ResponseMappable>(to type: T.Type,atKeyPath keyPath: String) -> Single<T> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).flatMap { response -> Single<T> in
            return Single.just(try response.map(to: type, atKeyPath: keyPath))
        }.observeOn(MainScheduler.instance)
    }
    
    func map<T: ResponseMappable>(to type: [T].Type) -> Single<[T]> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).flatMap { response -> Single<[T]> in
                return Single.just(try response.map(to: type))
        }.observeOn(MainScheduler.instance)
    }
    
    func map<T: ResponseMappable>(to type: [T].Type, keyPath: String) -> Single<[T]> {
        return observeOn(ConcurrentDispatchQueueScheduler(qos: .background)).flatMap { response -> Single<[T]> in
                return Single.just(try response.map(to: type, keyPath: keyPath))
        }.observeOn(MainScheduler.instance)
    }
}
