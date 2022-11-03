//
//  RateProductBuilder.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit

class RateProductBuilder {
    
    static func build() -> UIViewController {
        let router = RateProductRouter()
        let interactor = RateProductInteractor(manager: RateProductManager(restService: RestAPIService.shared, dbManager: RealmDBManager.shared))
        let presenter = RateProductPresenter(interactor: interactor, router: router)
        let viewController = RateProductContainerViewController(presenter: presenter)
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        
        
        return viewController
    }
}
