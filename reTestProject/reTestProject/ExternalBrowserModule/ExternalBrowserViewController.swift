//
//  ExternalBrowserViewController.swift
//  reTestProject
//
//  Created by Aleksandr Malinin on 25.10.2022.
//

import Foundation
import UIKit
import WebKit
import SnapKit

protocol ExternalBrowserViewControllerProtocol: AnyObject {
    func loadUrl(url: URL)
}

class ExternalBrowserViewController: BaseViewController, ExternalBrowserViewControllerProtocol {
    
    let presenter: ExternalBrowserPresenterProtocol
    
    let webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .white
        return view
    }()
    
    init(presenter: ExternalBrowserPresenterProtocol) {
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
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.navigationDelegate = presenter
    }
    
    private func setUpConstraints() {
        webView.snp.makeConstraints {make in
            make.edges.equalToSuperview()
        }
    }
    
    func loadUrl(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
