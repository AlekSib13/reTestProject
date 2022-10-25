//
//  CouponPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol CouponPresenterProtocol: AnyObject {}

class CouponPresenter: CouponPresenterProtocol {
    
    let interactor: CouponInteractorProtocol
    let router: CouponRouterProtocol
    weak var viewController: CouponViewControllerProtocol?
    
    init(interactor: CouponInteractorProtocol, router: CouponRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
