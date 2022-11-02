//
//  Errors.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 26.10.2022.
//

import Foundation


struct BaseErrors: Error {
    enum ErrorType {
        case serverError
        case decodingError
        case none
        case encodingError
        case realmInitialSetting
        case realmWritingError
        case noDataInDB
    }
    
    let errorType: ErrorType
    let errorTitle: String
    let descritpion: String?
}
