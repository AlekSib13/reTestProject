//
//  CouponInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol CouponInteractorProtocol {}

class CouponInteractor: CouponInteractorProtocol {
    
    let manager: CouponManagerProtocol
    weak var presenter: CouponPresenterProtocol?
    
    init(manager: CouponManagerProtocol) {
        self.manager = manager
    }
}
