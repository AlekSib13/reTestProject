//
//  CouponRoutre.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit

protocol CouponRouterProtocol {
    func openExternalSource(with url: URL)
}

class CouponRouter: CouponRouterProtocol {
    
    weak var viewController: CouponViewControllerProtocol?
    
    func openExternalSource(with url: URL) {
        guard let viewController = viewController as? UIViewController else {return}
        let vc = ExternalBrowserBuilder.build(url: url)
        viewController.present(vc, animated: true)
    }
}
