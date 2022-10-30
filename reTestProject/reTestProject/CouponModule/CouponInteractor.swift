//
//  CouponInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol CouponInteractorProtocol {
    func getCouponData(callback: @escaping (Result<CouponModel, Error>) -> Void)
}

class CouponInteractor: CouponInteractorProtocol {
    
    let manager: CouponManagerProtocol
    weak var presenter: CouponPresenterProtocol?
    
    init(manager: CouponManagerProtocol) {
        self.manager = manager
    }
    
    func getCouponData(callback: @escaping (Result<CouponModel, Error>) -> Void) {
        manager.getCoupon {result in
            switch result {
            case .success(let couponModel):
                if let couponModel {
                    callback(.success(couponModel))
                } else {
                    //for developer
                    assertionFailure("nil returned")
                }
            case .failure(let error):
                callback(.failure(error))
                //info for developer:
                guard let error  = error as? BaseErrors, let errorDescription = error.descritpion else {
                    assertionFailure(error.localizedDescription)
                    return
                }
                assertionFailure(errorDescription)
            }
        }
    }
}
