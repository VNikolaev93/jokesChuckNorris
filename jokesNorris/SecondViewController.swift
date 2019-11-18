//
//  SecondViewController.swift
//  jokesNorris
//
//  Created by Вячеслав Николаев on 18.11.2019.
//  Copyright © 2019 Вячеслав Николаев. All rights reserved.
//

import UIKit
import WebKit

class SecondViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://www.icndb.com/api")
        webView.load(URLRequest(url: url!))
    }
}
