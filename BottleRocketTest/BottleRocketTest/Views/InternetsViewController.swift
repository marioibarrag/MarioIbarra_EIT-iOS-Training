//
//  InternetsViewController.swift
//  BottleRocketTest
//
//  Created by Consultant on 5/8/22.
//

import UIKit
import WebKit

class InternetsViewController: UIViewController {

    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        loadWebView()
    }
    
    func setUp(){
        view.addSubview(webView)
        let safeArea = view.safeAreaLayoutGuide
        
        webView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
    }
    
    func loadWebView() {
        guard let url = URL(string: NetworkURLs.bottleRocket) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
}
extension InternetsViewController: WKUIDelegate {
    
}
