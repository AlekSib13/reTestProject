//
//  RateProductPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RateProductPresenterProtocol: AnyObject {}

class RateProductPresenter: RateProductPresenterProtocol {
    
    let interactor: RateProductInteractorProtocol
    let router: RateProductRouterProtocol
    weak var viewController: RateProductPageViewControllerProtocol?
    
    init(interactor: RateProductInteractorProtocol, router: RateProductRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
