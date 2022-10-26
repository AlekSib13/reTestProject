//
//  RateProductPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol RateProductPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class RateProductPresenter: RateProductPresenterProtocol {
    
    let interactor: RateProductInteractorProtocol
    let router: RateProductRouterProtocol
    weak var viewController: RateProductPageViewControllerProtocol?
    
    init(interactor: RateProductInteractorProtocol, router: RateProductRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        makeInitialDataRequest()
    }
    
    private func makeInitialDataRequest() {
        interactor.getData(offset: GeneralConstants.APIGeneralConstants.requestDefaultOffset, limit: GeneralConstants.APIGeneralConstants.requestDefaultLimit) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if let data = data, let firstElement = data.first {
                    self.viewController?.setInitialVC(with: firstElement)
                } else {
                    self.viewController?.showNoDataCover()
                }
            case .failure(_):
                self.viewController?.showErrorCover()
            }
        }
    }
}
