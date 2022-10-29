//
//  BaseNavigationController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 29.10.2022.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {.lightContent}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.tintColor = .black
    }
}


