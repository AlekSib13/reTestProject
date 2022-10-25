//
//  CouponBuilder.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit


class CouponBuilder {
    
    static func build() -> UIViewController {
        let router = CouponRouter()
        let interactor = CouponInteractor(manager: CouponManager(restService: RestAPIService.shared))
        let presenter = CouponPresenter(interactor: interactor, router: router)
        let viewController = CouponViewController(presenter: presenter)
        
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
