//
//  RateProductInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RateProductInteractorProtocol {}

class RateProductInteractor: RateProductInteractorProtocol {
    
    let manager: RateProductManagerProtocol
    weak var presenter: RateProductPresenterProtocol?
    
    init(manager: RateProductManagerProtocol) {
        self.manager = manager
    }
}
