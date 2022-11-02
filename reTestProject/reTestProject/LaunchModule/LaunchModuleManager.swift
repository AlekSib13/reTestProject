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
    func getUserData(callback: @escaping UserScoreCallback)
}

class LaunchModuleManager: LaunchModuleManagerProtocol {
    
    let restService: RestLaunchProtocol
    let dbManager: 
    
    init(restService: RestLaunchProtocol) {
        self.restService = restService
    }
    
    func getCashedToken() -> String? {
        getTokenFromDefaultStorage()
    }
    
    private func getTokenFromDefaultStorage() -> String? {
        let token = UserDefaults.standard.object(forKey: AppKeys.UserDefaultKeys.token)
        return (token as? String) ?? nil
    }
    
    func getUserData(callback: @escaping UserScoreCallback) {
        restService.getUserData(callback: callback)
    }
    
    func getToken(login: String, password: String, callback: @escaping (Result<Bool,Error>) -> Void) {
        //mockdata
        setTokenToDefaultStorage(token: "lkkjnajsbdh")
        callback(.success(true))
        
        //TODO: uncomment for API requests and hide mock data
//        restService.getToken(login: login, password: password) {[weak self] result in
//            guard let self = self else {return}
//            switch result {
//            case .success(let dict):
//                if let dict, let token = dict[AppKeys.UserDefaultKeys.token] {
//                    self.setTokenToDefaultStorage(token: token)
//                    callback(.success(true))
//                } else {
//                    //for developer
//                    let error = BaseErrors(errorType: .noToken, errorTitle: "No token error", descritpion: "No token or token format is incorrect")
//                    assertionFailure(error.errorTitle)
//                }
//            case .failure(let error):
//                //for developer
//                callback(.failure(error))
//                let error = BaseErrors(errorType: .errorFromServer, errorTitle: "Error from server", descritpion: "Error from server while traing to get token")
//                assertionFailure(error.errorTitle)
//            }
//        }
    }
    
    private func setTokenToDefaultStorage(token: String) {
        UserDefaults.standard.set(token, forKey: AppKeys.UserDefaultKeys.token)
    }
}
