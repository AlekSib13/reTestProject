//
//  LaunchModuleManager.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation

protocol LaunchModuleManagerProtocol {
    func getCashedToken() -> String?
    func getToken(login: String, password: String, callback: @escaping (Result<Bool,Error>) -> Void)
    func getUserData(callback: @escaping (Result<UserScoreModel,Error>) -> Void)
}

class LaunchModuleManager: LaunchModuleManagerProtocol {
    
    let restService: RestLaunchProtocol
    let dbManager: UserDataManagerProtocol
    
    init(restService: RestLaunchProtocol, dbManager: UserDataManagerProtocol) {
        self.dbManager = dbManager
        self.restService = restService
    }
    
    func getCashedToken() -> String? {
        getTokenFromDefaultStorage()
    }
    
    private func getTokenFromDefaultStorage() -> String? {
        let token = UserDefaults.standard.object(forKey: AppKeys.UserDefaultKeys.token)
        return (token as? String) ?? nil
    }
    
    func getUserData(callback: @escaping (Result<UserScoreModel,Error>) -> Void) {
        restService.getUserData {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let userData):
                if let key = UserDefaults.standard.string(forKey: AppKeys.UserDefaultKeys.token), let userData {
                    self.dbManager.writeUserScoreToDB(id: key, data: userData) {result in
                        switch result {
                        case .success(_):
                            callback(.success(userData))
                        case .failure(let error):
                            callback(.failure(error))
                        }
                    }
                } else {
                    let error = BaseErrors(errorType: .noUserDataFromServer, errorTitle: "No data received from server", descritpion: nil)
                    assertionFailure(error.errorTitle)
                    callback(.failure(error))
                }
            case .failure(let error):
                let errorLocalized = BaseErrors(errorType: .errorFromServer, errorTitle: "Could not get user data", descritpion: error.localizedDescription)
                assertionFailure(errorLocalized.errorTitle)
                callback(.failure(error))
            }
        }
    }
    
    func getToken(login: String, password: String, callback: @escaping (Result<Bool,Error>) -> Void) {
        restService.getToken(login: login, password: password) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let dict):
                if let dict, let token = dict[AppKeys.UserDefaultKeys.token] {
                    self.setTokenToDefaultStorage(token: token)
                    callback(.success(true))
                } else {
                    //for developer
                    let error = BaseErrors(errorType: .noToken, errorTitle: "No token error", descritpion: "No token or token format is incorrect")
                    assertionFailure(error.errorTitle)
                }
            case .failure(let error):
                //for developer
                callback(.failure(error))
                let error = BaseErrors(errorType: .errorFromServer, errorTitle: "Error from server", descritpion: "Error from server while traing to get token")
                assertionFailure(error.errorTitle)
            }
        }
    }
    
    private func setTokenToDefaultStorage(token: String) {
        UserDefaults.standard.set(token, forKey: AppKeys.UserDefaultKeys.token)
    }
}
