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
    }
    
    let errorType: ErrorType
    let errorTitle: String
    let descritpion: String?
}
