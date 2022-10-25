//
//  CouponRoutre.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol CouponRouterProtocol {}

class CouponRouter: CouponRouterProtocol {
    
    weak var viewController: CouponViewControllerProtocol?
}
