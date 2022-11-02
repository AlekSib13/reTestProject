//
//  LaunchModuleViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 24.10.2022.
//

import Foundation
import UIKit
import SnapKit

protocol LaunchModuleViewControllerProtocol: AnyObject {
    func showSmthWentWrongView()
    func showLoginAndPassword()
    func showAccessDeniedView()
}

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
    
    let loginPasswordStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.distribution = .equalSpacing
        stack.spacing = GeneralConstants.Spacing.offsetOf20
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    lazy var loginField: UITextField = {
        let field = UITextField()
        field.placeholder = DefaultStrings.LaunchModule.placeholderTextLogin
        field.backgroundColor = .white
        field.textColor = UIColor.BaseColours.baseGray
        field.font = UIFont.systemFont(ofSize: GeneralConstants.Size.sizeOf20, weight: .medium)
        field.layer.borderWidth = GeneralConstants.Size.sizeOf1
        field.layer.cornerRadius = GeneralConstants.Size.sizeOf5
        field.layer.borderColor = UIColor.BaseColours.baseGray.cgColor
        return field
    }()
    
    lazy var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = DefaultStrings.LaunchModule.placeholderTextParrword
        field.backgroundColor = .white
        field.textColor = UIColor.BaseColours.baseGray
        field.font = UIFont.systemFont(ofSize: GeneralConstants.Size.sizeOf20, weight: .medium)
        field.layer.borderWidth = GeneralConstants.Size.sizeOf1
        field.layer.cornerRadius = GeneralConstants.Size.sizeOf5
        field.layer.borderColor = UIColor.BaseColours.baseGray.cgColor
        return field
    }()
    
    lazy var goButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = GeneralConstants.Size.sizeOf20
        button.layer.borderWidth = GeneralConstants.Size.sizeOf1
        button.layer.borderColor = UIColor.BaseColours.baseGray.cgColor
        button.isUserInteractionEnabled = false
        button.backgroundColor = UIColor.BaseColours.baseGray.withAlphaComponent(0.5)
        button.setTitle(DefaultStrings.LaunchModule.enter, for: .normal)
        return button
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
        presenter.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setLogo()
    }
    
    private func configureView() {
        view.addSubview(mainLogo)
        view.addSubview(mainTitle)
        view.addSubview(loginPasswordStack)
        
        loginPasswordStack.isHidden = true
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
        
        loginPasswordStack.snp.makeConstraints {make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainTitle.snp.bottom).offset(GeneralConstants.Spacing.offsetOf30)
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
                }
            }
        }
    }
    
    func showSmthWentWrongView() {
        assertionFailure("show smth went wrong")
        //here will be smth went wrong view call
    }
    
    func showLoginAndPassword() {
        loginPasswordStack.addArrangedSubview(loginField)
        loginPasswordStack.addArrangedSubview(passwordField)
        loginPasswordStack.addArrangedSubview(goButton)
        
        loginPasswordStack.setCustomSpacing(GeneralConstants.Spacing.offsetOf30, after: passwordField)
        
        loginField.snp.makeConstraints {make in
            make.width.equalTo(GeneralConstants.Spacing.offsetOf150)
        }
        
        passwordField.snp.makeConstraints {make in
            make.width.equalTo(GeneralConstants.Spacing.offsetOf150)
        }
        
        goButton.snp.makeConstraints {make in
            make.width.height.equalTo(GeneralConstants.Size.sizeOf40)
        }
        
        UIView.transition(with: loginPasswordStack, duration: 1, animations: {[weak self] in
            guard let self = self else {return}
            self.loginPasswordStack.isHidden = false
        })
        
        goButton.addTarget(self, action: #selector(loginIn), for: .touchUpInside)
        goButton.isUserInteractionEnabled = true
    }
    
    @objc private func loginIn() {
        if let login = loginField.text, !login.isEmpty, let password = passwordField.text, !password.isEmpty {
            presenter.loginWithCredentials(login: login, password: password)
        }
    }
    
    func showAccessDeniedView() {
        assertionFailure("show access denied view")
        //here will be access denied view
    }
}
