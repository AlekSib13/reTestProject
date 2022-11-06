//
//  RestAPI + Launch.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import Alamofire

protocol RestLaunchProtocol {
    func getUserData(callback: @escaping UserScoreCallback)
    func getToken(login: String, password: String, callback: @escaping DictStringCallback)
}

extension RestAPIService: RestLaunchProtocol {
    func getUserData(callback: @escaping UserScoreCallback) {
        //mockData
        callback(.success(UserScoreModel(currentScore: 0, totalScore: 30)))
        //TODO: uncommentApiCalls
//        let url = baseRestURL.appending(path: "/user")
//        return makeDecodableRequestForData(url: url, callback: callback)
    }
    
    
    func getToken(login: String, password: String, callback: @escaping DictStringCallback) {
        //mockData
        callback(.success(["token":"skamdksnq"]))
        
        //TODO: uncommentApiCalls
//        let url = baseRestURL.appending(path: "/token")
//        let params: Parameters = ["login": login, "password": password]
//        return makeDecodableRequestForData(url: url, callback: callback)
    }
}
