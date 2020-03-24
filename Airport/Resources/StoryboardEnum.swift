//
//  StoryboardEnum.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import Foundation

enum AirportStoryboard: String {
    case menu = "Menu"
    case map = "Map"
    case list = "List"
}

enum TabBarEnum {
    case map
    case list
    
    var normalImage: String {
        switch self {
        case .map:
            return "map"
        case .list:
            return "list"
        }
    }

    var selectedImage: String {
        switch self {
        case .map:
            return "map-active"
        case .list:
            return "list-active"
        }
    }
}
