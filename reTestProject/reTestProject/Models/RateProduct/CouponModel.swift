//
//  CouponModel.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 30.10.2022.
//

import Foundation

struct CouponModel: Decodable, AnyRewardProtocol {
    let code: String
    let sourceUrl: String?
    
    
    enum CodingKeys: String, CodingKey {
        case code = "CODE"
        case sourceUrl = "URL"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(String.self, forKey: .code)
        self.sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
    }
    
    //mocking init
    init(code: String, sourceUrl: String? = nil) {
        self.code = code
        self.sourceUrl = sourceUrl
    }
}
