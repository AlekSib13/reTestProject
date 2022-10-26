//
//  RateProductViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage


protocol RateProductViewControllerDelegate {
}

protocol RateProductViewControllerProtocol {
    var pageIndex: Int {get set}
}

class RateProductViewController: BaseViewController, UIScrollViewDelegate, RateProductViewControllerProtocol {
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var pageIndex: Int
    let delegate: RateProductViewControllerDelegate
    let data: RateProductModel
    
    init(pageIndex: Int, delegate: RateProductViewControllerDelegate, data: RateProductModel) {
        self.pageIndex = pageIndex
        self.delegate = delegate
        self.data = data
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
        
        scrollView.delegate = self
        configure(with: data)
    }
    
    override func viewDidLayoutSubviews() {
        adjustConstraints()
    }
    
    private func configureView() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
  
    
    private func setConstraints() {
        scrollView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configure(with data: RateProductModel) {
        imageView.sd_setImage(with: URL(string: data.productImage)) {[weak self] view,_,_,_ in
            guard let self = self, let view = view else {return}
            self.scrollView.contentSize = view.size
            self.scaleScrollViewSubviews()
        }
    }
    
    private func scaleScrollViewSubviews() {
        setMaxAndMinZoomScale()
    }
    
    private func setMaxAndMinZoomScale() {
        guard let imageViewBoundsSize = imageView.image?.size else {return}
        
        let xScale = UIScreen.main.bounds.width / imageViewBoundsSize.width
        let yScale = UIScreen.main.bounds.height / imageViewBoundsSize.height
        let minScale = min(xScale, yScale)
        
        let maxScale: CGFloat = 4
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
        
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    private func adjustConstraints() {
        guard let imageViewBoundsSize = imageView.image?.size else {return}
        let scrollViewBoundsSize = scrollView.bounds.size
        let sidesRationResult = imageViewBoundsSize.width > imageViewBoundsSize.height
        let offsetCoeff = sidesRationResult ? 0.5 : 1
        if sidesRationResult {
            imageView.snp.remakeConstraints {make in
                make.top.equalToSuperview().offset(scrollViewBoundsSize.width * offsetCoeff)
                make.left.right.bottom.equalToSuperview()
            }
        } else {
            imageView.snp.remakeConstraints {make in
                make.edges.equalToSuperview()
            }
        }
    }
}
