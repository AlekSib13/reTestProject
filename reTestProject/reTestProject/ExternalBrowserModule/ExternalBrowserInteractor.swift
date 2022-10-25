//
//  ExternalBrowserInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol ExternalBrowserInteractorProtocol {}

class ExternalBrowserInteractor: ExternalBrowserInteractorProtocol {
    
    weak var presenter: ExternalBrowserPresenterProtocol?
}
