//
//  RateProductViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit


protocol RateProductPageViewControllerDelegate: UIPageViewControllerDelegate, UIPageViewControllerDataSource {}


protocol RateProductPageViewControllerProtocol: AnyObject where Self: UIPageViewController {
    func setDelegate(delegate: RateProductPageViewControllerDelegate)
}

class RateProductPageViewController: UIPageViewController, RateProductPageViewControllerProtocol {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpConstraints()
    }
    
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func setUpConstraints() {}
    
    func setDelegate(delegate: RateProductPageViewControllerDelegate) {
        self.delegate = delegate
        self.dataSource = delegate
    }
}
