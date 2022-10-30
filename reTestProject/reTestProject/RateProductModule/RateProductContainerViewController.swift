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
    var  pageViewController: RateProductPageViewControllerProtocol {get}
    func showDataExceptionalSituation(situation: DataExceptionalSituation)
    func handleImageInfoApperanceState(forceHideRequired: Bool)
    func fillDescription(text: String?)
    func updateManagementBarState(state: ProductRatingRange?)
    func updateSliderBarState(currentValue: Float, maxVlue: Float)
}

class RateProductContainerViewController: BaseViewController, RateProductContainerViewControllerProtocol, ManagementBarViewDelegate, InfoTopBarViewDelegate {
    
  
    let presenter: RateProductPresenterProtocol
    let pageViewController: RateProductPageViewControllerProtocol = RateProductPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    lazy var managementBar: ManagementBarViewProtocol = ManagementBarView(delegate: self)
    lazy var infoBar: InfoTopBarViewProtocol = InfoTopBarView(delegate: self)
    lazy var sliderBar: SliderBarProtocol = ProgressBarSlider()
    
    
    init(presenter: RateProductPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setUpConstraints()
        presenter.didLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    private func configureView() {
        let pageVC = pageViewController as UIPageViewController
        view.addSubview(pageVC.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        view.addSubview(managementBar)
        view.addSubview(infoBar)
        view.addSubview(sliderBar)
        
        infoBar.isHidden = true
        
        pageViewController.setDelegate(delegate: presenter)
        
        view.bringSubviewToFront(noDataView)
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
        
        sliderBar.snp.makeConstraints {make in
            make.bottom.equalTo(managementBar.snp.top).inset(GeneralConstants.Spacing.offsetOf5)
            make.left.right.equalToSuperview().inset(GeneralConstants.Spacing.offsetOf5)
            make.height.equalTo(GeneralConstants.Size.sizeOf40)
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
    
    
    func infoTapped() {
        presenter.openExternalInfoSource()
    }
    
    func showDataExceptionalSituation(situation: DataExceptionalSituation) {
        showExceptionalSituationView(situation: situation)
    }
    
    func liked() {
        presenter.rateProduct(rated: .liked)
    }
    
    func disliked() {
        presenter.rateProduct(rated: .disliked)
    }
    
    func skip() {
        presenter.rateProduct(rated: .skipped)
    }
    
    
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
    
    func fillDescription(text: String?) {
        infoBar.setInfoBarText(text: text)
    }
    
    func updateManagementBarState(state: ProductRatingRange?) {
        managementBar.setStateForButtons(state: state)
    }
    
    func updateSliderBarState(currentValue: Float, maxVlue: Float) {
        sliderBar.setSliderValues(currentValue: currentValue, maxValue: maxVlue)
    }
}
