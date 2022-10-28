//
//  Images.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 28.10.2022.
//

import Foundation
import UIKit

extension UIImage {
    
    struct Buttons {
        static let likeButton = { UIImage(named: "thumbs-up") }()
        static let dislikeButton = { UIImage(named: "thumbs-down") }()
        static let skip = { UIImage(named: "skip") }()
        static let info = { UIImage(named: "info") }()
    }
}
