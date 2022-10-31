//
//  LaunchModuleInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit

protocol LaunchModuleInteractorProtocol {
    func getData(by index: Int) -> (title: String, attachment: UIImage?)
    func getAccess(login: String?, password: String?, callback: @escaping (Result<Bool, Error>) -> Void)
}

class LaunchModuleInteractor: LaunchModuleInteractorProtocol {
    
    let manager: LaunchModuleManagerProtocol
    weak var presenter: LaunchModulePresenterProtocol?
    
    var attachmentsList = [UIImage?]()
    var logoFullTitleNamesList = [String]()
    var userData: UserScoreModel?
    
    
    init(manager: LaunchModuleManagerProtocol) {
        self.manager = manager
        setData()
    }
    
    func getData(by index: Int) -> (title: String, attachment: UIImage?) {
        (title: logoFullTitleNamesList[index], attachment: attachmentsList[index])
    }
    
    private func setData() {
        self.attachmentsList = [UIImage.Other.idea, UIImage.Other.create, UIImage.Other.world]
        self.logoFullTitleNamesList = [DefaultStrings.LaunchModule.invent, DefaultStrings.LaunchModule.create, DefaultStrings.LaunchModule.live]
    }
    
    func getAccess(login: String?, password: String?, callback: @escaping (Result<Bool, Error>) -> Void) {
        //using login and password to get token
        if let login, let password {
            makeTokenRequest(login: login, password: password) {[weak self] result in
                guard let self = self else {return}
                switch result {
                case .success(let result):
                    if result {
                        self.makeUserDataRequest(callback: callback)
                    }
                case .failure(let error):
                    callback(.failure(error))
                }
            }
        } else {
            //there is might be a token, which is going to be used
            if let _ = manager.getCashedToken() {
               makeUserDataRequest(callback: callback)
            } else {
                //it was found out, there is no token.Access is denied anyway
                callback(.success(false))
            }
        }
    }
    
//    private func makeUserDataRequest(callback: @escaping (Result<UserScoreModel?, Error>) -> Void) {
//        manager.getUserData(callback: callback)
//    }
    
    private func makeUserDataRequest(callback: @escaping (Result<Bool, Error>) -> Void) {
        manager.getUserData {[weak self] result in
            guard let self = self else {return}
            //mockData.
            //this kind of data should be written to db.
            self.userData = UserScoreModel(currentScore: 0, totalScore: 30)
            callback(.success(true))
            //TODO: uncomment for API calls
//            switch result {
//            case .success(let userModel):
//                if let userModel {
//                    //should everything be fine with the token, user data is returned. Access is allowed
//                    self.userData = userModel
//                    callback(.success(true))
//                } else {
//                    //smth went wrong - there should have be the token, but there was not. Access is denied anyway
//                    let error = BaseErrors(errorType: .noUserData, errorTitle: "No user data", descritpion: nil)
//                    assertionFailure(error.errorTitle)
//                    callback(.failure(error))
//                }
//            case .failure(let error):
//                if let baseError = error as? BaseErrors, baseError.errorType == .serverAccessDenied {
//                    //unauthorized arror
//                    callback(.failure(error))
//                } else {
//                    //some other error
//                    let error = BaseErrors(errorType: .errorFromServer, errorTitle: "Could not get user data", descritpion: nil)
//                    assertionFailure(error.errorTitle)
//                    callback(.failure(error))
//                }
//            }
        }
    }
    
    private func makeTokenRequest(login: String, password: String, callback: @escaping (Result<Bool,Error>) -> Void) {
        manager.getToken(login: login, password: password, callback: callback)
    }
}
