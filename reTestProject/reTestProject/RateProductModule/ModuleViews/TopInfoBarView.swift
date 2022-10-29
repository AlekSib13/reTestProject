//
//  TopInfoBar.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 28.10.2022.
//

import Foundation


import UIKit
import SnapKit


protocol InfoTopBarViewProtocol where Self: UIView{
    func setInfoBarText(text: String?)
}

protocol InfoTopBarViewDelegate {
    func infoTapped()
}


class InfoTopBarView: UIView, InfoTopBarViewProtocol {
    
    struct Constants {
        static let defaultNumOfLines = 2
    }
    
    let hBarStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = GeneralConstants.Spacing.offsetOf20
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let descriptionLabel: UILabel = {
        let label = BaseUILabel()
        label.font = UIFont.systemFont(ofSize: GeneralConstants.Size.sizeOf15, weight: .regular)
        label.tintColor = UIColor.BaseColours.baseGray
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = Constants.defaultNumOfLines
        label.layer.cornerRadius = GeneralConstants.Size.sizeOf5
        label.layer.backgroundColor = UIColor.white.cgColor
        label.layer.borderColor = UIColor.BaseColours.turquoiseBlueKrayola.cgColor
        label.layer.borderWidth = GeneralConstants.Size.sizeOf1
        
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage.Buttons.info, for: .normal)
        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    
    let delegate: InfoTopBarViewDelegate
    
    init(delegate: InfoTopBarViewDelegate) {
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
        layer.cornerRadius = GeneralConstants.Spacing.offsetOf20
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        addSubview(hBarStack)
        hBarStack.addArrangedSubview(descriptionLabel)
        hBarStack.addArrangedSubview(infoButton)
        
        infoButton.addTarget(self, action: #selector(infoTapped), for: .touchUpInside)
        
        descriptionLabel.isHidden = true
    }
    
    private func setUpConstraints() {
        hBarStack.snp.makeConstraints {make in
            make.bottom.equalToSuperview().inset(GeneralConstants.Spacing.offsetOf5)
            make.left.right.equalToSuperview().inset(GeneralConstants.Spacing.offsetOf15)
        }
        
        infoButton.snp.makeConstraints {make in
            make.width.equalTo(GeneralConstants.Size.sizeOf60)
        }
    }
    
 
    
    @objc private func infoTapped() {
        delegate.infoTapped()
    }
    
    func setInfoBarText(text: String?) {
        if let text {
            descriptionLabel.text = text
            descriptionLabel.isHidden = false
        } else {
            descriptionLabel.isHidden = true
            descriptionLabel.text = nil
        }
    }
}
