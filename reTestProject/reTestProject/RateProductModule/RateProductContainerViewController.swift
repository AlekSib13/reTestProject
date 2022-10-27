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
}

class RateProductContainerViewController: UIViewController, RateProductContainerViewControllerProtocol {
  
    let presenter: RateProductPresenterProtocol
    let pageViewController: RateProductPageViewControllerProtocol = RateProductPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    
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
        setConstraints()
        presenter.viewDidLoad()
    }
    
    
    private func configureView() {
        let pageVC = pageViewController as UIPageViewController
        view.addSubview(pageVC.view)
        
        pageViewController.setDelegate(delegate: presenter)
    }
    
    private func setConstraints() {
        let pageVC = pageViewController as UIPageViewController
        
        pageVC.view.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
    
    func showNoDataCover() {
    }
    
    func showErrorCover() {
    }
    
}
