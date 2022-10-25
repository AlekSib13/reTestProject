//
//  ExternalBrowserPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation

protocol ExternalBrowserPresenterProtocol: AnyObject {}

class ExternalBrowserPresenter: ExternalBrowserPresenterProtocol {
    
    let interactor: ExternalBrowserInteractorProtocol
    let router: ExternalBrowserRouterProtocol
    weak var viewController: ExternalBrowserViewControllerProtocol?
    
    init(interactor: ExternalBrowserInteractorProtocol, router: ExternalBrowserRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}
