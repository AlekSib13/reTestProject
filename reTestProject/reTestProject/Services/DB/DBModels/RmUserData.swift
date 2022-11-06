//
//  RmUserData.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 02.11.2022.
//

import Foundation
import RealmSwift

class RmUserScoreData: Object {
    @Persisted var id: String
    @Persisted var score: Int
    @Persisted var totalScore: Int
    
    override static func primaryKey() -> String? {
        "id"
    }
    
    func toDBObject(id: String, from object: UserScoreModel) -> RmUserScoreData {
        self.id = id
        score = object.currentScore
        totalScore = object.totalScore
        return self
    }
    
    func toDataModel() -> UserScoreModel {
        UserScoreModel(currentScore: self.score, totalScore: self.totalScore)
    }
}

