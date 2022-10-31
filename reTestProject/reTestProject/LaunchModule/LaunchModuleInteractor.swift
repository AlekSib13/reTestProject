//
//  LaunchModuleInteractor.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit

protocol LaunchModuleInteractorProtocol {
    func getData(by index: Int) -> (title: String, attachment: UIImage?)
}

class LaunchModuleInteractor: LaunchModuleInteractorProtocol {
    
    let manager: LaunchModuleManagerProtocol
    weak var presenter: LaunchModulePresenterProtocol?
    
    var attachmentsList = [UIImage?]()
    var logoFullTitleNamesList = [String]()
    
    init(manager: LaunchModuleManagerProtocol) {
        self.manager = manager
        setData()
    }
    
    func getData(by index: Int) -> (title: String, attachment: UIImage?) {
        (title: logoFullTitleNamesList[index], attachment: attachmentsList[index])
    }
    
    private func setData() {
        self.attachmentsList = [UIImage.Other.idea, UIImage.Other.create, UIImage.Other.world]
        self.logoFullTitleNamesList = [DefaultStrings.LaunchModule.invent, DefaultStrings.LaunchModule.create, DefaultStrings.LaunchModule.live]
    }
}
