//
//  RateProductManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RateProductManagerProtocol {
    func getRateProducts(offset: Int, limit: Int, callback: @escaping ProductRateCallback)
}

class RateProductManager: RateProductManagerProtocol {
    
    let restService: RestRateProductProtocol
    
    init(restService: RestRateProductProtocol) {
        self.restService = restService
    }
    
    
    func getRateProducts(offset: Int, limit: Int, callback: @escaping ProductRateCallback) {
        //MARK: mock data
        
        
        //TODO: uncomment for API requests and hide mock data
//        restService.getProductRate(offset: offset, limit: limit, callback: callback)
    }
}
