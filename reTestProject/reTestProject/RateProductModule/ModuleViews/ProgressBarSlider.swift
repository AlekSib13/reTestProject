//
//  ProgressBarView.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 28.10.2022.
//

import Foundation
import UIKit
import SnapKit


protocol SliderBarProtocol where Self: UISlider {
    func setSliderValues(currentValue: Float, maxValue: Float)
}

class ProgressBarSlider: UISlider, SliderBarProtocol {
    
    private let baseLayer = CALayer()
    private let trackLayer = CAGradientLayer()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configure()
    }
    
    private func configure() {
       clearDefault()
       setup()
    }
    
    private func clearDefault() {
        tintColor = .clear
        maximumTrackTintColor = .clear
        backgroundColor = .clear
        thumbTintColor = .clear
    }
    
    private func setup() {
        configureBaseLayer()
        configureTrackLayer()
      
        setThumbImage(UIImage.RateProduct.coupon, for: .normal)
        setThumbImage(UIImage.RateProduct.coupon, for: .highlighted)
        setThumbImage(UIImage.RateProduct.coupon, for: .application)
        setThumbImage(UIImage.RateProduct.coupon, for: .disabled)
        setThumbImage(UIImage.RateProduct.coupon, for: .focused)
        setThumbImage(UIImage.RateProduct.coupon, for: .reserved)
        setThumbImage(UIImage.RateProduct.coupon, for: .selected)
        
        addTarget(self, action: #selector(thumbValueChanged(_:)), for: .valueChanged)
        minimumValue = 0
    }
    
    private func configureBaseLayer() {
        baseLayer.borderWidth = GeneralConstants.Size.sizeOf1
        baseLayer.borderColor = UIColor.BaseColours.turquoiseBlueKrayola.cgColor
        baseLayer.masksToBounds = true
        baseLayer.backgroundColor = UIColor.BaseColours.turquoiseBlueKrayola10PercentOpaqued.cgColor
        baseLayer.backgroundColor = UIColor.white.cgColor
        baseLayer.frame = CGRect(x: 0, y: frame.height / 4, width: frame.width, height:  frame.height / 2)
        baseLayer.cornerRadius = baseLayer.frame.height / 2
        layer.insertSublayer(baseLayer, at: 0)
    }
    
    private func configureTrackLayer() {
        trackLayer.colors = [UIColor.BaseColours.turquoiseBlueKrayola30PercentOpaqued.cgColor,
                             UIColor.BaseColours.fireOrange.cgColor]
        trackLayer.startPoint = CGPoint(x: 0, y: 0.5)
        trackLayer.endPoint = CGPoint(x: 1, y: 0.5)
        trackLayer.frame = CGRect(x: 0, y: frame.height / 4, width: 0, height: frame.height / 2)
        trackLayer.cornerRadius = trackLayer.frame.height / 2
        layer.insertSublayer(trackLayer, at: 1)
    }
    
    @objc private func thumbValueChanged(_ sender: ProgressBarSlider) {
        let thumbR = thumbRect(forBounds: bounds, trackRect: trackRect(forBounds: bounds), value: sender.value)
        trackLayer.frame = CGRect(x: 0, y: frame.height / 4, width: thumbR.maxX, height:  frame.height / 2)
    }
    
    func setSliderValues(currentValue: Float, maxValue: Float) {
        maximumValue = maxValue
        value = currentValue
        thumbValueChanged(self)
    }
}
