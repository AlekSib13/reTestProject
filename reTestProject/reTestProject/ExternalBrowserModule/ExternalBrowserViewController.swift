//
//  ExternalBrowserViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol ExternalBrowserViewControllerProtocol: AnyObject {}

class ExternalBrowserViewController: BaseViewController, ExternalBrowserViewControllerProtocol {
    
    let presenter: ExternalBrowserPresenterProtocol
    
    init(presenter: ExternalBrowserPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
