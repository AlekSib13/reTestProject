//
//  CouponViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit

protocol CouponViewControllerProtocol: AnyObject {}

class CouponViewController: BaseViewController, CouponViewControllerProtocol {
    
    let presenter: CouponPresenterProtocol
    
    init(presenter: CouponPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
