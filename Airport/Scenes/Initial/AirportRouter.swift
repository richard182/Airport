//
//  AirportRouter.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import UIKit

protocol AiportRoutingLogic {
  func routeAirportDetails(_ airports: [Airport])
}

final class AirportRouter: RouterProtocol, AiportRoutingLogic {
    
    weak var viewController: AirportViewController?
    
    func routeAirportDetails(_ airports: [Airport]) {
        let menuViewController = getViewController(for: .menu, with: MenuViewController.typeName) as? MenuViewController
        
        let currentItemsTabBar: [UITabBarItem] = menuViewController!.tabBarModules.items!
        var controllers: [UIViewController] = [UIViewController]()
        
        for item in currentItemsTabBar {
            
            var module: TabBarEnum = .map
            var viewController = UIViewController()
            
            switch item.tag {
            case 1:
                module = .map
                let mapViewcontroller = getViewController(for: .map, with: MapViewController.typeName) as? MapViewController
                mapViewcontroller?.airports = airports
                let navigationController = UINavigationController(rootViewController: mapViewcontroller!)
                viewController = navigationController
            case 2:
                module = .list
                let listViewController = getViewController(for: .list, with: ListViewController.typeName) as? ListViewController
                listViewController?.airports = airports
                let navigationController = UINavigationController(rootViewController: listViewController!)
                viewController = navigationController
            default:
                break
            }
            
            item.title = ""
            item.image = UIImage(named: module.normalImage)?.withRenderingMode(.alwaysOriginal)
            item.selectedImage = UIImage(named: module.selectedImage)?.withRenderingMode(.alwaysOriginal)
            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            viewController.tabBarItem = item
            viewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                viewController.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
            controllers.append(viewController)
        }
        
        menuViewController?.setViewControllers(controllers, animated: false)
        setRootViewController(menuViewController)
    }
}
