//
//  URL+Extensions.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation

extension URL {
    
    init(staticString string: String) {

        guard let url = URL(string: string) else {
            preconditionFailure("Invalid static URL string: \(string)")
        }

        self = url
    }
}
