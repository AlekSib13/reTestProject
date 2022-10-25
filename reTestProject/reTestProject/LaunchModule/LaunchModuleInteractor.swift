//
//  LaunchModuleInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation

protocol LaunchModuleInteractorProtocol {}

class LaunchModuleInteractor: LaunchModuleInteractorProtocol {
    
    let manager: LaunchModuleManagerProtocol
    weak var presenter: LaunchModulePresenterProtocol?
    
    init(manager: LaunchModuleManagerProtocol) {
        self.manager = manager
    }
}
