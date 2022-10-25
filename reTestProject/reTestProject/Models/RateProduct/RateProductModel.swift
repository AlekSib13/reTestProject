//
//  RateProductModel.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


struct RateProductModel: AnyProductModelProtocol, Decodable {
    var id: Int
    var productName: String
    var productImage: String
    var productRating: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case productName = "NAME"
        case productImage = "IMAGE"
        case productRating = "RATING"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.productName = try container.decode(String.self, forKey: .productName)
        self.productImage = try container.decode(String.self, forKey: .productImage)
        self.productRating = try container.decodeIfPresent(Int.self, forKey: .productRating)
    }
    
    //mocking init
    init(id: Int, productName: String, productImage: String, productRating: Int?) {
        self.id = id
        self.productName = productName
        self.productImage = productImage
        self.productRating = productRating
    }
}
