//
//  CouponPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation


protocol CouponPresenterProtocol: AnyObject {
    func viewDidLoad()
    func transitionToExternalSource()
}

class CouponPresenter: CouponPresenterProtocol {
    
    let interactor: CouponInteractorProtocol
    let router: CouponRouterProtocol
    weak var viewController: CouponViewControllerProtocol?
    
    var transitionUrl: String?
    
    init(interactor: CouponInteractorProtocol, router: CouponRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        makeDataRequest()
    }
    
    private func makeDataRequest() {
        interactor.getCouponData {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let couponModel):
                self.viewController?.setCode(text: couponModel.code)
                self.transitionUrl = couponModel.sourceUrl
                if let _ = self.transitionUrl {
                    self.viewController?.setTransitionToExternalResource()
                }
            case .failure(_):
                print("ops smth went wrong!")
            }
        }
    }
    
    func transitionToExternalSource() {
        if let transitionUrl, let url = URL(string: transitionUrl) {
            router.openExternalSource(with: url)
        }
    }
}
