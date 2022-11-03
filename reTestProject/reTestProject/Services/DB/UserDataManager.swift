//
//  UserDataManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 02.11.2022.
//

import Foundation

protocol UserDataManagerProtocol {
    func writeUserScoreToDB(id: String, data: UserScoreModel, callback: @escaping (Result<Bool, Error>) -> Void)
    func readUserScoreFromDB(id: String, callback: @escaping (Result<UserScoreModel, Error>) -> Void)
}

extension RealmDBManager: UserDataManagerProtocol {
    func writeUserScoreToDB(id: String, data: UserScoreModel, callback: @escaping (Result<Bool, Error>) -> Void) {
        let dbObject = RmUserScoreData()
        writeUserScoreRmModelToDB(id: id, data: dbObject.toDBObject(id: id, from: data), callback: callback)
    }
    
    
    func readUserScoreFromDB(id: String, callback: @escaping (Result<UserScoreModel, Error>) -> Void) {
        readUserScoreRmModelFromDB(id: id) {result in
            switch result {
            case .success(let dbObject):
                callback(.success(dbObject.toDataModel()))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
