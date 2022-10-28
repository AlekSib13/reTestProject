//
//  RateProductContainerViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 27.10.2022.
//

import Foundation
import UIKit
import SnapKit

protocol RateProductContainerViewControllerProtocol: AnyObject {
    var pageViewController: RateProductPageViewControllerProtocol {get}
    func showNoDataCover()
    func showErrorCover()
    func handleImageInfoApperanceState(forceHideRequired: Bool)
}

class RateProductContainerViewController: UIViewController, RateProductContainerViewControllerProtocol, ManagementBarViewDelegate, InfoTopBarViewDelegate {
    
  
    let presenter: RateProductPresenterProtocol
    let pageViewController: RateProductPageViewControllerProtocol = RateProductPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    lazy var managementBar: ManagementBarViewProtocol = ManagementBarView(delegate: self)
    lazy var infoBar: InfoTopBarViewProtocol = InfoTopBarView(delegate: self)
    
    
    init(presenter: RateProductPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
//        guard let window = UIApplication.shared.delegate?.window else {return}
//        print("the window is \(window)")
//        window?.rootViewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        configureView()
        setUpConstraints()
        presenter.viewDidLoad()
    }
    
    
    private func configureView() {
        let pageVC = pageViewController as UIPageViewController
        view.addSubview(pageVC.view)
        view.addSubview(managementBar)
        view.addSubview(infoBar)
        
        infoBar.isHidden = true
        
        pageViewController.setDelegate(delegate: presenter)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        refreshConstraints()
    }
    
    private func setUpConstraints() {
        let pageVC = pageViewController as UIPageViewController
        
        pageVC.view.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
        
        managementBar.snp.makeConstraints {make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(view.safeAreaInsets.bottom + GeneralConstants.Size.sizeOf60)
            
        }
        
        infoBar.snp.makeConstraints {make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(view.safeAreaInsets.top + GeneralConstants.Size.sizeOf50)
        }
    }
    
    private func refreshConstraints () {
        infoBar.snp.updateConstraints {make in
            make.height.equalTo(view.safeAreaInsets.top + GeneralConstants.Size.sizeOf50)
        }
        
        managementBar.snp.updateConstraints {make in
            make.height.equalTo(view.safeAreaInsets.bottom + GeneralConstants.Size.sizeOf60)
        }
        
        infoBar.frame.origin.y -= view.safeAreaInsets.top + GeneralConstants.Size.sizeOf50
    }
    
    
    func infoTapped() {}
    
    func showNoDataCover() {}
    
    func showErrorCover() {}
    
    func liked() {}
    
    func disliked() {}
    
    func skip() {}
    
    
    func handleImageInfoApperanceState(forceHideRequired: Bool) {
        if forceHideRequired {
            if !infoBar.isHidden {
                animateInfoDisappearance()}
            return
        }
        
        if infoBar.isHidden {
            animateInfoAppearance()
        } else {
            animateInfoDisappearance()
        }
    }
    
    
    private func animateInfoAppearance() {
        infoBar.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0.0) {[weak self] in
            guard let self = self else {return}
            self.infoBar.frame.origin.y += self.view.safeAreaInsets.top + GeneralConstants.Size.sizeOf50
        }
    }
    
    private func animateInfoDisappearance() {
        UIView.animate(withDuration: 0.5, delay: 0.0) {[weak self] in
            guard let self = self else {return}
            self.infoBar.frame.origin.y -= self.view.safeAreaInsets.top + GeneralConstants.Size.sizeOf50
        } completion: {[weak self] completed in
            guard let self = self else {return}
            if completed {
                self.infoBar.isHidden = true
            }
        }
    }
}
