//
//  CouponManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation

protocol CouponManagerProtocol {}

class CouponManager: CouponManagerProtocol {
    
    let restService: CouponProtocol
    
    init(restService: CouponProtocol) {
        self.restService = restService
    }
}
