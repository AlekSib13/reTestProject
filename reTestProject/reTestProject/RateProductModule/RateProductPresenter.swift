//
//  RateProductPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit

protocol RateProductPresenterProtocol: AnyObject, RateProductPageViewControllerDelegate, RateProductViewControllerDelegate {
    func didLoad()
    func openExternalInfoSource()
    func rateProduct(rated: ProductRatingRange)
    func showReward()
}

class RateProductPresenter: NSObject, RateProductPresenterProtocol {
    
    private enum PageSwitchDirection {
        case forward
        case backwards
    }
 
    let interactor: RateProductInteractorProtocol
    let router: RateProductRouterProtocol
    weak var viewController: RateProductContainerViewControllerProtocol?
    
    var nextIndex: Int?
    var currentIndex: Int?
    
    init(interactor: RateProductInteractorProtocol, router: RateProductRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func didLoad() {
        makeInitialDataRequest()
    }
    
    private func makeInitialDataRequest() {
        interactor.getProductsData(offset: GeneralConstants.APIGeneralConstants.requestDefaultOffset, limit: GeneralConstants.APIGeneralConstants.requestDefaultLimit) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                if let data = data, let firstElement = data.first {
                    self.setNewVC(with: firstElement)
                } else {
                    self.viewController?.showDataExceptionalSituation(situation: .noData)
                }
            case .failure(_):
                self.viewController?.showDataExceptionalSituation(situation: .errorOccured)
            }
        }
    }
    
    private func setNewVC(newIndex: Int = 0, with data: RateProductModel, direction: PageSwitchDirection = .forward) {
        guard let vc = viewController else {return}
        let pageVC = vc.pageViewController as UIPageViewController
        currentIndex = newIndex
        let initialVC = RateProductViewController(pageIndex: newIndex, data: data, delegate: self)
        setItemDescription(text: data.interestingInfo)
        switch direction {
        case .forward:
            pageVC.setViewControllers([initialVC], direction: .forward, animated: true)
        case .backwards:
            pageVC.setViewControllers([initialVC], direction: .reverse, animated: true)
        }
        updateManagementElements()
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
                updateManagementElements()
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
    
    func rateProduct(rated: ProductRatingRange) {
        guard let currentIndex = currentIndex else {return}
        
        interactor.sendProductRating(at: currentIndex, rating: rated) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let userScoreModel):
                if rated != .skipped {
                    self.updateUserRating(newScore: userScoreModel.currentScore, totalScore: userScoreModel.totalScore)
                }
            case .failure(_):
                assertionFailure("smth went wrong, try latter")
            }
        }
        
        switch rated {
        case .skipped:
            if interactor.getCountedLoadedItems() == 1 {
                viewController?.showDataExceptionalSituation(situation: .noDataToEvaluate)
                interactor.removeData(at: currentIndex)
            } else {
                interactor.removeData(at: currentIndex)
                if currentIndex > interactor.getCountedLoadedItems() - 1 {
                    setNewVC(newIndex: currentIndex - 1, with: interactor.getLoadedItemsList()[currentIndex - 1], direction: .backwards)
                } else {
                    setNewVC(newIndex: currentIndex, with: interactor.getLoadedItemsList()[currentIndex], direction: .forward)
                }
            }
        default:
            break
        }
    }
    
    func updateUserRating(newScore: Int, totalScore: Int) {
        viewController?.updateSliderBarState(currentValue: Float(newScore), maxVlue: Float(totalScore))
    }
    
    private func updateManagementElements() {
        guard let currentIndex = currentIndex else {return}
        let product = interactor.getLoadedItemsList()[currentIndex]
        
        if let rating = product.productRating {
            switch rating {
            case 0:
                viewController?.updateManagementBarState(state: .disliked)
            case 1:
                viewController?.updateManagementBarState(state: .liked)
            default:
                viewController?.updateManagementBarState(state: nil)
            }
            
        } else {
            viewController?.updateManagementBarState(state: nil)
        }
    }
    
    func showReward() {
        router.openRewardModule()
    }
}
