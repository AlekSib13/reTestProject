//
//  ExternalBrowserRouter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol ExternalBrowserRouterProtocol {}


class ExternalBrowserRouter: ExternalBrowserRouterProtocol {
    
    weak var viewController: ExternalBrowserViewControllerProtocol?
}
