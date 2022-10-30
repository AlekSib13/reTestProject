//
//  RateProductRouter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit

protocol RateProductRouterProtocol {
    func openSource(viaLink: URL)
    func openRewardModule()
}

class RateProductRouter: RateProductRouterProtocol {
    
    weak var viewController: RateProductContainerViewControllerProtocol?
    
    func openSource(viaLink: URL) {
        guard let currentVC = viewController as? UIViewController else {return}
        let nextVC = ExternalBrowserBuilder.build()
        currentVC.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func openRewardModule() {
        let vc = CouponBuilder.build()
        guard let currentVC = viewController as? UIViewController else {return}
        currentVC.present(vc, animated: true)
    }
}
