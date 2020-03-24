//
//  UIViewController+Extensions.swift
//  Airport
//
//  Created by Richard on 3/23/20.
//  Copyright © 2020 richard. All rights reserved.
//

import UIKit

protocol RouterProtocol { }

extension RouterProtocol {
    
    func getViewController(for storyboard: AirportStoryboard, with identifier: String) -> UIViewController? {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func setRootViewController(_ viewController: UIViewController?) {
        
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else {
            return
        }
         
        window.rootViewController?.dismiss(animated: false, completion: nil)
        (window.rootViewController as? UINavigationController)?.popToRootViewController(animated: false)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}

extension UIViewController {
    
    static var typeName: String {
        return String(describing: self)
    }
    
    func setTranslucentNavigationBar()  {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
}
