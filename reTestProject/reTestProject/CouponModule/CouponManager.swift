//
//  CouponManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation

protocol CouponManagerProtocol {
    func getCoupon(callback: @escaping CouponCallback)
}

class CouponManager: CouponManagerProtocol {
    
    let restService: CouponProtocol
    
    init(restService: CouponProtocol) {
        self.restService = restService
    }
    
    func getCoupon(callback: @escaping CouponCallback) {
        //MARK: mock data
        let data = CouponModel(code: "Ab1721a", sourceUrl: "https://www.google.com/")
        callback(.success(data))
        //TODO: uncomment for API requests and hide mock data
//        restService.getCoupon(callback: callback)
    }
}
