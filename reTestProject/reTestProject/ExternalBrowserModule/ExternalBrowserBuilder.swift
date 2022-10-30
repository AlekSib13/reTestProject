//
//  ExternalBrowserBuilder.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit

class ExternalBrowserBuilder {
    
    static func build(url: URL) -> UIViewController {
        let router = ExternalBrowserRouter()
        let interactor = ExternalBrowserInteractor(url: url)
        let presenter = ExternalBrowserPresenter(interactor: interactor, router: router)
        let viewController = ExternalBrowserViewController(presenter: presenter)
        
        interactor.presenter = presenter
        router.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
