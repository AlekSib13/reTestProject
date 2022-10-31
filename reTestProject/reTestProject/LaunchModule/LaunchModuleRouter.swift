//
//  LaunchModuleRouter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit

protocol LaunchModuleRouterProtocol {
    func openProductRateModule()
}

class LaunchModuleRouter: LaunchModuleRouterProtocol {
    
    weak var viewController: LaunchModuleViewControllerProtocol?
    
    func openProductRateModule() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        sceneDelegate.updateRootViewController()
    }
}
