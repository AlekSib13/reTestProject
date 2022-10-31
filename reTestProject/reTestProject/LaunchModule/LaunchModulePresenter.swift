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
    func showProductRateModule()
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
}
