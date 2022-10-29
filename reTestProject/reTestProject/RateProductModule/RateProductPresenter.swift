//
//  RateProductPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit

protocol RateProductPresenterProtocol: AnyObject, RateProductPageViewControllerDelegate, RateProductViewControllerDelegate {
    func viewDidLoad()
    func openExternalInfoSource()
}

class RateProductPresenter: NSObject, RateProductPresenterProtocol {
 
    let interactor: RateProductInteractorProtocol
    let router: RateProductRouterProtocol
    weak var viewController: RateProductContainerViewControllerProtocol?
    
    var nextIndex: Int?
    var currentIndex: Int?
    
    init(interactor: RateProductInteractorProtocol, router: RateProductRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        makeInitialDataRequest()
    }
    
    private func makeInitialDataRequest() {
        interactor.getData(offset: GeneralConstants.APIGeneralConstants.requestDefaultOffset, limit: GeneralConstants.APIGeneralConstants.requestDefaultLimit) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if let data = data, let firstElement = data.first {
                    self.setInitialVC(with: firstElement)
                } else {
                    self.viewController?.showNoDataCover()
                }
            case .failure(_):
                self.viewController?.showErrorCover()
            }
        }
    }
    
    private func setInitialVC(with data: RateProductModel) {
        guard let vc = viewController else {return}
        let pageVC = vc.pageViewController as UIPageViewController
        currentIndex = 0
        let initialVC = RateProductViewController(pageIndex: 0, data: data, delegate: self)
        setItemDescription(text: data.interestingInfo)
        pageVC.setViewControllers([initialVC], direction: .forward, animated: true)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? RateProductViewController else {return nil}
        let currentIndex = currentVC.pageIndex
        let previousIndex = currentIndex - 1
        
        if previousIndex >= 0 {
            let data = interactor.getLoadedItemsList()[previousIndex]
            let previousVC = RateProductViewController(pageIndex: previousIndex, data: data, delegate: self)
            return previousVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? RateProductViewController else {return nil}
        let currentIndex = currentVC.pageIndex
        let nextIndex = currentIndex + 1
        
        if nextIndex <= interactor.getCountedLoadedItems() - 1 {
            let data = interactor.getLoadedItemsList()[nextIndex]
            let nextVC = RateProductViewController(pageIndex: nextIndex, data: data, delegate: self)
            return nextVC
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let vc = pendingViewControllers.first as? RateProductViewController else {return}
        nextIndex = vc.pageIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = nextIndex
            nextIndex = nil
            if let currentIndex {
                setItemDescription(text: interactor.getLoadedItemsList()[currentIndex].interestingInfo)
            }
        }
    }
    
    func showImageInfo() {
        viewController?.handleImageInfoApperanceState(forceHideRequired: false)
    }
    
    func forceHideImageInfo() {
        viewController?.handleImageInfoApperanceState(forceHideRequired: true)
    }
    
    func openExternalInfoSource() {
        if let currentIndex {
            let item = interactor.getLoadedItemsList()[currentIndex]
            guard let link = item.productLink, let url = URL(string: link) else {return}
            router.openSource(viaLink: url)
        }
    }
    
    private func setItemDescription(text: String?) {
        viewController?.fillDescription(text: text)
    }
}
