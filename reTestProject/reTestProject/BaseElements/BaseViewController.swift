//
//  BaseViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit
import SnapKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    
    private func configure() {
        view.backgroundColor = UIColor.BaseColours.turquoiseBlueKrayola
    }
    
    private func setConstraints() {}
}
