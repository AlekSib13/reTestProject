//
//  RateProductModel.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation

enum ProductRatingRange: Int {
    case disliked = 0
    case liked
    case skipped
}

struct RateProductModel: AnyProductModelProtocol, Decodable {
    
    let id: Int
    let productName: String
    let productImage: String
    var productRating: Int?
    let interestingInfo: String?
    let productLink: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case productName = "NAME"
        case productImage = "IMAGE"
        case productRating = "RATING"
        case interestingInfo = "INTERESTING_INFO"
        case productLink = "LINK"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.productImage = try container.decode(String.self, forKey: .productImage)
        self.productRating = try container.decodeIfPresent(Int.self, forKey: .productRating)
        self.interestingInfo = try container.decodeIfPresent(String.self, forKey: .interestingInfo)
        self.productLink = try container.decode(String.self, forKey: .productLink)
    }
    
    //mocking init
    init(id: Int, productName: String, productImage: String, productRating: Int? = nil, interestingInfo: String? = nil, productLink: String? = nil) {
        self.id = id
        self.productName = productName
        self.productImage = productImage
        self.productRating = productRating
        self.interestingInfo = interestingInfo
        self.productLink = productLink
    }
    
    mutating func updateRating(newRating: ProductRatingRange) {
        productRating = newRating.rawValue
    }
}

typealias RateProductResult = [RateProductModel]
