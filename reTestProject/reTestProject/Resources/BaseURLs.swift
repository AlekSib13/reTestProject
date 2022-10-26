//
//  BaseURLs.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 26.10.2022.
//

import Foundation


struct BaseURL {
    static var baseUrl: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "some_host"
        return components
    }
}
