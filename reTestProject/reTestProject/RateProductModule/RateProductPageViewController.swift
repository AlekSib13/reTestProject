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
    var vc: RateProductViewControllerProtocol?
    
    
    init(presenter: RateProductPresenterProtocol) {
        self.presenter = presenter
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        guard let window = UIApplication.shared.delegate?.window else {return}
        print("the window is \(window)")
        window?.rootViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
