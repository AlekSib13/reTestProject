//
//  CouponRoutre.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol CouponRouterProtocol {
    func openExternalSource(with: URL)
}

class CouponRouter: CouponRouterProtocol {
    
    weak var viewController: CouponViewControllerProtocol?
    
    func openExternalSource(with: URL) {
        assertionFailure("openExternalSource")
    }
}
