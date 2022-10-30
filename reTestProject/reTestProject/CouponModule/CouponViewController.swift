//
//  CouponViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit
import SnapKit

protocol CouponViewControllerProtocol: AnyObject {
    func setCode(text: String)
    func setTransitionToExternalResource()
}

class CouponViewController: UIViewController, CouponViewControllerProtocol {
    
    let blanckView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = GeneralConstants.Size.sizeOf20
        view.layer.borderWidth = GeneralConstants.Size.sizeOf1
        view.layer.borderColor = UIColor.BaseColours.turquoiseBlueKrayola.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowColor = UIColor.BaseColours.baseGray.cgColor
        view.layer.shadowRadius = GeneralConstants.Size.sizeOf20
        view.clipsToBounds = false
        return view
    }()
    
    let rewardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Coupon.coupon
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let couponCodeLabel: UILabel = {
        let label = BaseUILabel(topInset: .zero, bottomInset: .zero, leftInset: GeneralConstants.Spacing.offsetOf5, rightInset: GeneralConstants.Spacing.offsetOf5)
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: GeneralConstants.Size.sizeOf20, weight: .bold)
        label.textColor = UIColor.BaseColours.baseGray
        label.layer.cornerRadius = GeneralConstants.Size.sizeOf5
        label.layer.borderWidth = GeneralConstants.Size.sizeOf1
        label.layer.borderColor = UIColor.BaseColours.baseGray.withAlphaComponent(0.3).cgColor
        return label
    }()
    
    let externalResourceLabel: UILabel = {
        let label = UILabel()
        label.text = DefaultStrings.Coupon.goToWebSite
        label.font = UIFont.systemFont(ofSize: GeneralConstants.Size.sizeOf15, weight: .bold)
        label.textColor = UIColor.BaseColours.baseGray
        return label
    }()
    
    let externalResourceTransitionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = GeneralConstants.Size.sizeOf20
        button.layer.borderWidth = GeneralConstants.Size.sizeOf1
        button.layer.borderColor = UIColor.BaseColours.baseGray.cgColor
        button.setImage(UIImage.Coupon.externalSourceButton, for: .normal)
        return button
    }()
    
    let presenter: CouponPresenterProtocol
    
    init(presenter: CouponPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpConstraints()
        presenter.didLoad()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        view.backgroundColor = .clear
        view.addSubview(blanckView)
        blanckView.addSubview(rewardImage)
        blanckView.addSubview(couponCodeLabel)
        blanckView.addSubview(externalResourceLabel)
        blanckView.addSubview(externalResourceTransitionButton)
        
        externalResourceLabel.isHidden = true
        externalResourceTransitionButton.isHidden = true
        
        externalResourceTransitionButton.addTarget(self, action: #selector(transitionToExternalResourceButtonTapped), for: .touchUpInside)
    }
    
    private func setUpConstraints() {
        guard let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let screenWidth = scene.window?.bounds.width, let screenHeight = scene.window?.bounds.height else {
            blanckView.snp.makeConstraints {make in
                make.centerX.centerY.equalToSuperview()
                make.width.equalTo(GeneralConstants.Size.sizeOf300)
                make.height.equalTo(GeneralConstants.Size.sizeOf450)
            }
            return
        }
        blanckView.snp.makeConstraints {make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(screenWidth - GeneralConstants.Size.sizeOf40)
            make.height.equalTo(screenHeight - GeneralConstants.Size.sizeOf300)
        }
        
        rewardImage.snp.makeConstraints {make in
            make.top.equalToSuperview().offset(GeneralConstants.Spacing.offsetOf50)
            make.width.height.equalTo(GeneralConstants.Size.sizeOf150)
            make.centerX.equalToSuperview()
        }
        
        couponCodeLabel.snp.makeConstraints {make in
            make.top.equalTo(rewardImage.snp.bottom).offset(GeneralConstants.Spacing.offsetOf30)
            make.centerX.equalToSuperview()
        }
        
        externalResourceLabel.snp.makeConstraints {make in
            make.top.equalTo(couponCodeLabel.snp.bottom).offset(GeneralConstants.Spacing.offsetOf50)
            make.centerX.equalToSuperview()
        }
        
        externalResourceTransitionButton.snp.makeConstraints {make in
            make.top.equalTo(externalResourceLabel.snp.bottom).offset(GeneralConstants.Spacing.offsetOf10)
            make.centerX.equalTo(externalResourceLabel)
            make.width.height.equalTo(GeneralConstants.Size.sizeOf40)
        }
    }
    
    func setCode(text: String) {
        couponCodeLabel.text = text
    }
    
    func setTransitionToExternalResource() {
        externalResourceLabel.isHidden = false
        externalResourceTransitionButton.isHidden = false
    }
    
    @objc func transitionToExternalResourceButtonTapped() {
        presenter.transitionToExternalSource()
    }
}
