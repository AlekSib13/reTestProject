//
//  LaunchModuleManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation

protocol LaunchModuleManagerProtocol {}

class LaunchModuleManager: LaunchModuleManagerProtocol {
    
    let restService: RestLaunchProtocol
    
    init(restService: RestLaunchProtocol) {
        self.restService = restService
    }
}
