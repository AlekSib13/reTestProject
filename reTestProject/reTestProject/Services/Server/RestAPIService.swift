//
//  RestApiService.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RestAPIServiceProtocol {}

class RestAPIService: RestAPIServiceProtocol {
    static let shared = RestAPIService()
    
    private init() {}
}
