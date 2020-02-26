//
//  Storyboarded.swift
//  PRTApp
//
//  Created by Newpage-iOS on 01/09/19.
//  Copyright © 2019 Nishant. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryBoard: String {
    case Main, Login, Experiments, Activities
    
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type) .storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func navigationControllerWith<T: UINavigationController>(identifier: String) -> T {
        return instance.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    func instantiateViewController() -> UIViewController? {
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiateFrom(appStoryboard: AppStoryBoard) -> Self {
        return appStoryboard.viewController(viewControllerClass: self)
    }
}
