//
//  LaunchModulePresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit

enum LogoState: Int {
    case stateOne = 0
    case stateTwo
    case stateThree
}

protocol LaunchModulePresenterProtocol: AnyObject {
    func getText(for state: LogoState) -> NSMutableAttributedString
    func loginWithCredentials(login: String, password: String)
    func showProductRateModule()
    func didLoad()
}

class LaunchModulePresenter: LaunchModulePresenterProtocol {
    
    let interactor: LaunchModuleInteractorProtocol
    let router: LaunchModuleRouterProtocol
    weak var viewController: LaunchModuleViewControllerProtocol?
    
    init(interactor: LaunchModuleInteractorProtocol, router: LaunchModuleRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func getText(for state: LogoState) -> NSMutableAttributedString {
        let currentState = interactor.getData(by: state.rawValue)
        
        let title = NSMutableAttributedString(string: DefaultStrings.LaunchModule.firstPartOfLogo)
        title.addAttributes([.font: UIFont.systemFont(ofSize: GeneralConstants.Size.sizeOf30, weight: .bold), .foregroundColor: UIColor.BaseColours.baseGray], range: NSRange.init(location: 0, length: 2))
        
        let attachment = NSTextAttachment()
        attachment.image = currentState.attachment
        let attrStrWithAttachment = NSMutableAttributedString(attachment: attachment)
        
        let titleAttrAddition = NSMutableAttributedString(string: currentState.title)
        titleAttrAddition.addAttributes([.font: UIFont.systemFont(ofSize: GeneralConstants.Size.sizeOf30, weight: .bold), .foregroundColor: UIColor.BaseColours.baseGray], range: NSRange.init(location: 0, length: currentState.title.count))
            
        attrStrWithAttachment.append(titleAttrAddition)
        title.append(attrStrWithAttachment)
        
        return title
    }
    
    func showProductRateModule() {
        router.openProductRateModule()
    }
    
    func didLoad() {
        makeLogin()
    }
    
    func loginWithCredentials(login: String, password: String) {
        makeLogin(login: login, password: password)
    }
    
    private func makeLogin(login: String? = nil, password: String? = nil) {
        interactor.getAccess(login: login, password: password) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let result):
                if result {
                    self.router.openProductRateModule()
                } else {
                    self.viewController?.showLoginAndPassword()
                }
            case .failure(let error):
                if let authError = error as? BaseErrors, authError.errorType == .serverAccessDenied {
                    self.viewController?.showAccessDeniedView()
                } else {
                    self.viewController?.showSmthWentWrongView()
                }
            }
        }
    }
    
   
}
