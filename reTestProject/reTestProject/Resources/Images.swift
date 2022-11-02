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
    
    struct RateProduct {
        static let coupon = { UIImage(named: "coupon") }()
    }
    
    struct Cover {
        static let nothingToEvaluate = { UIImage(named: "nothingToEvaluate") }()
        static let noData = { UIImage(named: "noData") }()
    }
    
    struct Coupon {
        static let coupon = { UIImage(named: "reward") }()
        static let externalSourceButton = { UIImage(named: "rHome") }()
    }
    
    struct Logo {
        static let defaultMainLogo = { UIImage(named: "defaultMainLogo") }()
    }
    
    struct Other {
        static let idea = { UIImage(named: "idea") }()
        static let create = { UIImage(named: "create") }()
        static let world = { UIImage(named: "world") }()
    }
}
