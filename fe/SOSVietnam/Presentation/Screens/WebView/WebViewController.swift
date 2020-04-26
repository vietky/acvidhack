//
//  WebViewController.swift
//  SOSVietnam
//
//  Created by Ecko Huynh on 26/04/2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    var webView: WKWebView!
    var url:URL?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initWebView()
        if let url = url {
            self.webView.load(URLRequest(url:url))
        }
    }

    
    func initWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        setupWebView()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: webView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: webView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, let scheme = url.scheme {
            // Handle phone and email links
            if (scheme.contains("mailto") || scheme.contains("tel")) {
//                openAppUrl.onNext(url)
//                decisionHandler(.cancel)
                return
            }
            // Handle target="_blank"
            if navigationAction.targetFrame == nil {
//                openAppUrl.onNext(url)
//                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    }
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    }
}
