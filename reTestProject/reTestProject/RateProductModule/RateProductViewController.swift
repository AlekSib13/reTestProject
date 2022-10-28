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



protocol RateProductViewControllerProtocol {
    var pageIndex: Int {get set}
}

protocol RateProductViewControllerDelegate {
    func showImageInfo()
    func forceHideImageInfo()
}

class RateProductViewController: BaseViewController, UIScrollViewDelegate, RateProductViewControllerProtocol {
    
    struct Constants {
        static let maxScaleFactor: CGFloat = 4
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.contentInset = UIEdgeInsets(top: .zero, left: GeneralConstants.Spacing.offsetOf5, bottom: .zero, right: GeneralConstants.Spacing.offsetOf5)
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var pageIndex: Int
    let data: RateProductModel
    let delegate: RateProductViewControllerDelegate
    
    init(pageIndex: Int, data: RateProductModel, delegate: RateProductViewControllerDelegate) {
        self.pageIndex = pageIndex
        self.data = data
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpConstraints()
        
        scrollView.delegate = self
        configure(with: data)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideImageInfo()
    }
    
    private func configureView() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onImageTapped)))
    }
    
    private func setUpConstraints() {
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
    
   override func viewDidLayoutSubviews() {
       super.viewDidLayoutSubviews()
       adjustConstraints()
    }
    
    private func scaleScrollViewSubviews() {
        setMaxAndMinZoomScale()
    }
    
    private func setMaxAndMinZoomScale() {
        guard let imageViewBoundsSize = imageView.image?.size else {return}
        
        let xScale = (UIScreen.main.bounds.width - GeneralConstants.Spacing.offsetOf10) / imageViewBoundsSize.width
        let yScale = UIScreen.main.bounds.height / imageViewBoundsSize.height
        let minScale = min(xScale, yScale)
        
        let maxScale = Constants.maxScaleFactor
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
        
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, animations: {[weak self] in
            guard let self = self else {return}
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale
        })
    }
    
    private func adjustConstraints() {
        guard let imageViewBoundsSize = imageView.image?.size else {return}
        let scrollViewBoundsSize = scrollView.bounds
        
        let offset = (scrollViewBoundsSize.height - scrollView.zoomScale * imageViewBoundsSize.height) / 2
        imageView.snp.remakeConstraints {make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(offset)
            make.bottom.equalToSuperview().inset(offset)
        }
    }
    
    @objc private func onImageTapped() {
        delegate.showImageInfo()
    }
    
    private func hideImageInfo() {
        delegate.forceHideImageInfo()
    }
}
