//
//  RateProductViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit

protocol RateProductPageViewControllerProtocol: AnyObject {}

class RateProductPageViewController: UIPageViewController, RateProductPageViewControllerProtocol {
    
    let presenter: RateProductPresenterProtocol
    
    init(presenter: RateProductPresenterProtocol) {
        self.presenter = presenter
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
