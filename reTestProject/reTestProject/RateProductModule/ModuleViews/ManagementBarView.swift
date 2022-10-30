//
//  ManagementBarView.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 27.10.2022.
//

import Foundation
import UIKit
import SnapKit


protocol ManagementBarViewProtocol where Self: UIView{
    func setStateForButtons(state: ProductRatingRange?)
}

protocol ManagementBarViewDelegate {
    func liked()
    func disliked()
    func skip()
}


class ManagementBarView: UIView, ManagementBarViewProtocol {
    
    
    let hBarStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = GeneralConstants.Spacing.offsetOf20
        stack.alignment = .center
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Buttons.likeButton?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.BaseColours.baseGray
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return button
    }()
    
    let dislikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Buttons.dislikeButton?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.BaseColours.baseGray
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return button
    }()
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Buttons.skip, for: .normal)
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return button
    }()
    
    let delegate: ManagementBarViewDelegate
    
    init(delegate: ManagementBarViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        configureView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = UIColor.BaseColours.turquoiseBlueKrayola30PercentOpaqued
        layer.borderWidth = GeneralConstants.Size.sizeOf1
        layer.borderColor = UIColor.BaseColours.turquoiseBlueKrayola.cgColor
        layer.cornerRadius = GeneralConstants.Size.sizeOf20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(hBarStack)
        hBarStack.addArrangedSubview(likeButton)
        hBarStack.addArrangedSubview(dislikeButton)
        hBarStack.addArrangedSubview(skipButton)
        
        likeButton.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(dislikeTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }
    
    private func setUpConstraints() {
        hBarStack.snp.makeConstraints {make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(GeneralConstants.Spacing.offsetOf15)
        }
    }
    
    @objc private func likeTapped() {
        changeButtonColour(button: dislikeButton, newColour: UIColor.BaseColours.baseGray)
        animateActionButton(button: likeButton)
        delegate.liked()
        
    }
    
    @objc private func dislikeTapped() {
        changeButtonColour(button: likeButton, newColour: UIColor.BaseColours.baseGray)
        animateActionButton(button: dislikeButton)
        delegate.disliked()
    }
    
    @objc private func skipTapped() {
        delegate.skip()
    }
    
    private func animateActionButton<T: UIButton>(button: T) {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.0, options: .curveLinear) {
            button.center.y += 1
        } completion: {[weak self] completed in
            if completed {
                guard let self = self else {return}
                self.changeButtonColour(button: button, newColour: UIColor.BaseColours.persiaGreen)
                button.center.y -= 1
            }
        }
    }
    
    func setStateForButtons(state: ProductRatingRange?) {
        switch state {
        case .liked:
            changeButtonColour(button: likeButton, newColour: UIColor.BaseColours.persiaGreen)
            changeButtonColour(button: dislikeButton, newColour: UIColor.BaseColours.baseGray)
        case .disliked:
            changeButtonColour(button: dislikeButton, newColour: UIColor.BaseColours.persiaGreen)
            changeButtonColour(button: likeButton, newColour: UIColor.BaseColours.baseGray)
        default:
            changeButtonColour(button: dislikeButton, newColour: UIColor.BaseColours.baseGray)
            changeButtonColour(button: likeButton, newColour: UIColor.BaseColours.baseGray)
        }
    }
    
    private func changeButtonColour<T: UIButton>(button: T, newColour: UIColor) {
        button.imageView?.tintColor = newColour
    }
}
