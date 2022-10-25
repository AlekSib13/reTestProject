//
//  RateProductManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RateProductManagerProtocol {}

class RateProductManager: RateProductManagerProtocol {
    
    let restService: RestRateProductProtocol
    
    init(restService: RestRateProductProtocol) {
        self.restService = restService
    }
}
