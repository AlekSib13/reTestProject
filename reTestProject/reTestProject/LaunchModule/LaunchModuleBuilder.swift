//
//  LaunchModuleBuilder.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit

class LaunchModuleBuilder {
    
    static func build() -> UIViewController {
        let router = LaunchModuleRouter()
        let interactor = LaunchModuleInteractor(manager: LaunchModuleManager(restService: RestAPIService.shared, dbManager: RealmDBManager.shared))
        let presenter = LaunchModulePresenter(interactor: interactor, router: router)
        let viewController = LaunchModuleViewController(presenter: presenter)
        
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
