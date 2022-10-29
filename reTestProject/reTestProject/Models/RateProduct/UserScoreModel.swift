//
//  UserScoreModel.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 29.10.2022.
//

import Foundation


struct UserScoreModel: Decodable {
    let currentScore: Int
    let totalScore: Int
    
    enum CodingKeys: String, CodingKey {
        case currentScore = "USER_SCORE"
        case totalScore = "TOTAL_SCORE"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.currentScore = try container.decode(Int.self, forKey: .currentScore)
        self.totalScore = try container.decode(Int.self, forKey: .totalScore)
        
    }
    
    //mocking init
    init(currentScore: Int, totalScore: Int) {
        self.currentScore = currentScore
        self.totalScore = totalScore
    }
}
