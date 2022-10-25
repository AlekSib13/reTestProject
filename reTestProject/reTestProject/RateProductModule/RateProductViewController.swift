//
//  RateProductViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit


protocol RateProductViewControllerProtocol {
    var pageIndex: Int {get set}
}

class RateProductViewController: BaseViewController, UIScrollViewDelegate, RateProductViewControllerProtocol {
    var pageIndex: Int
    
    
    init(pageIndex: Int) {
        self.pageIndex = pageIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
