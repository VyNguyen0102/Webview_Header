//
//  ViewController.swift
//  WebviewHeader
//
//  Created by Vy Nguyen on 9/21/19.
//  Copyright © 2019 VVLab. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webViewContainer: UIView!
    private var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()

    private var webViewHeader: WebViewHeader = WebViewHeader()

    override func viewDidLoad() {
        super.viewDidLoad()
        addWebViewToContainer()
        addHeaderToWebView()
        webView.load(URLRequest.init(url: URL.init(string: "https://apple.com")!))
    }
    private func addWebViewToContainer() {
        webView.navigationDelegate = self
        webViewContainer.addSubview(webView)
        BaseCustomView.addConstrainOverlay(childView: webView, toView: webViewContainer)
    }
    private func addHeaderToWebView() {
        // the trick is here
        // if you using UIWebView
        // if let webBrowserView = webView.scrollView.subviews.first(where: { String(describing: type(of: $0)) == "UIWebBrowserView" }) {
        guard let webBrowserView = webView.scrollView.subviews.first(where: { String(describing: type(of: $0)) == "WKContentView" }) else {
            return
        }
        webView.scrollView.contentInset = UIEdgeInsets.init(top: 70, left: 0, bottom: 0, right: 0)
        webView.scrollView.addSubview(webViewHeader)
        webViewHeader.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = webViewHeader.leadingAnchor.constraint(equalTo: webView.leadingAnchor)
        let trailingConstraint = webViewHeader.trailingAnchor.constraint(equalTo: webView.trailingAnchor)
        let bottomConstraint = webViewHeader.bottomAnchor.constraint(lessThanOrEqualTo: webBrowserView.topAnchor)
        let topConstraint = webViewHeader.topAnchor.constraint(lessThanOrEqualTo: webView.topAnchor)
        topConstraint.priority = .defaultLow
        let heightConstraint = webViewHeader.heightAnchor.constraint(equalToConstant: 70)
        webView.addConstraints([leadingConstraint, trailingConstraint, bottomConstraint,topConstraint , heightConstraint])
    }
}

extension ViewController: WKNavigationDelegate {

}
