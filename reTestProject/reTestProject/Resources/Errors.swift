//
//  Errors.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 26.10.2022.
//

import Foundation


struct BaseErrors: Error {
    enum ErrorType {
        case errorFromServer
        case decodingError
        case none
        case encodingError
        case realmInitialSetting
        case realmWritingError
        case noDataInDB
        case noToken
        case noUserData
        case serverAccessDenied
    }
    
    let errorType: ErrorType
    let errorTitle: String
    let descritpion: String?
}
