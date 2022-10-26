//
//  LaunchModuleViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit

protocol LaunchModuleViewControllerProtocol: AnyObject {}

class LaunchModuleViewController: BaseViewController, LaunchModuleViewControllerProtocol {
    
    let presenter: LaunchModulePresenterProtocol
    
    init(presenter: LaunchModulePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    
    func configureView() {
    }
    
    func setConstraints() {}
}
