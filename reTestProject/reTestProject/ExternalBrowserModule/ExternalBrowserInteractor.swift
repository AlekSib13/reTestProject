//
//  ExternalBrowserInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol ExternalBrowserInteractorProtocol {
    func getUrl() -> URL
}

class ExternalBrowserInteractor: ExternalBrowserInteractorProtocol {
    
    weak var presenter: ExternalBrowserPresenterProtocol?
    
    var url: URL
    
    
    init(url: URL) {
        self.url = url
    }
    
    func getUrl() -> URL {
        url
    }
    
}
