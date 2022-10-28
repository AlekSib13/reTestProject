//
//  BaseUILabel.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 28.10.2022.
//

import Foundation
import UIKit

class BaseUILabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: UIEdgeInsets(top: .zero, left: GeneralConstants.Spacing.offsetOf5, bottom: .zero, right: GeneralConstants.Spacing.offsetOf5)))
    }
}
