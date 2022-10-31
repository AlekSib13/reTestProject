//
//  LaunchModuleViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit
import SnapKit

protocol LaunchModuleViewControllerProtocol: AnyObject {}

class LaunchModuleViewController: BaseViewController, LaunchModuleViewControllerProtocol {
    
    let mainLogo: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage.Logo.defaultMainLogo
        return logo
    }()
    
    let mainTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    let presenter: LaunchModulePresenterProtocol
    
    init(presenter: LaunchModulePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setLogo()
    }
    
    private func configureView() {
        view.addSubview(mainLogo)
        view.addSubview(mainTitle)
    }
    
    private func setConstraints() {
        mainLogo.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(GeneralConstants.Spacing.offsetOf150)
        }
        
        mainTitle.snp.makeConstraints {make in
            make.centerX.equalTo(mainLogo)
            make.top.equalTo(mainLogo.snp.bottom).offset(GeneralConstants.Spacing.offsetOf30)
        }
    }
    
    private func setLogo() {
        UIView.transition(with: mainTitle, duration: 2, options: [.transitionCrossDissolve]) {[weak self] in
            guard let self = self else {return}
            self.mainTitle.attributedText = self.presenter.getText(for: .stateOne)
        } completion: {[weak self] _ in
            guard let self = self else {return}
            UIView.transition(with: self.mainTitle, duration: 3, options: [.transitionCrossDissolve]) {[weak self] in
                guard let self = self else {return}
                self.mainTitle.attributedText = self.presenter.getText(for: .stateTwo)
            } completion: { _ in
                UIView.transition(with: self.mainTitle, duration: 3, options: [.transitionCrossDissolve]) {
                    self.mainTitle.attributedText = self.presenter.getText(for: .stateThree)
                } completion: { _ in
                    self.showNextModule()
                }
            }
        }
    }
    
    private func showNextModule() {
        presenter.showProductRateModule()
    }
}
