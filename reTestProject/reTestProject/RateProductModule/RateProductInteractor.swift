//
//  RateProductInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RateProductInteractorProtocol {
    func getData(offset: Int, limit: Int, callback: @escaping (Result<[RateProductModel]?, Error>) -> Void)
}

class RateProductInteractor: RateProductInteractorProtocol {
    
    let manager: RateProductManagerProtocol
    weak var presenter: RateProductPresenterProtocol?
    var data = [RateProductModel]()
    
    init(manager: RateProductManagerProtocol) {
        self.manager = manager
    }
    
    func getData(offset: Int, limit: Int, callback: @escaping (Result<[RateProductModel]?, Error>) -> Void)  {
        manager.getRateProducts(offset: offset, limit: limit) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if let data {
                    self.data.append(contentsOf: data)
                    callback(.success(self.data))
                } else {
                    callback(.success(nil))
                }
            case .failure(let error):
                callback(.failure(error))
                //info for developer:
                guard let error  = error as? BaseErrors, let errorDescription = error.descritpion else {
                    assertionFailure(error.localizedDescription)
                    return
                }
                assertionFailure(errorDescription)
            }
        }
    }
}
