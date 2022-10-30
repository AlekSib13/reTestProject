//
//  ExternalBrowserPresenter.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import WebKit


protocol ExternalBrowserPresenterProtocol: AnyObject, WKNavigationDelegate {
    func didLoad()
}

class ExternalBrowserPresenter: NSObject, ExternalBrowserPresenterProtocol {
    
    let interactor: ExternalBrowserInteractorProtocol
    let router: ExternalBrowserRouterProtocol
    weak var viewController: ExternalBrowserViewControllerProtocol?
    
    init(interactor: ExternalBrowserInteractorProtocol, router: ExternalBrowserRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func didLoad() {
        let url = interactor.getUrl()
        viewController?.loadUrl(url: url)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        .allow
    }
}
