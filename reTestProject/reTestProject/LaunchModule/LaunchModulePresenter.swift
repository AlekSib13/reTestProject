//
//  LaunchModulePresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation


protocol LaunchModulePresenterProtocol: AnyObject {}

class LaunchModulePresenter: LaunchModulePresenterProtocol {
    
    let interactor: LaunchModuleInteractorProtocol
    let router: LaunchModuleRouterProtocol
    weak var viewController: LaunchModuleViewControllerProtocol?
    
    init(interactor: LaunchModuleInteractorProtocol, router: LaunchModuleRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
