//
//  WebViewController.swift
//  WorldTroter
//
//  Created by 黄家树 on 2018/3/18.
//  Copyright © 2018年 huangjs. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    var webView:WKWebView!
    override func loadView() {
        webView = WKWebView()
        webView.load(URLRequest(url: URL(string: "https://www.jianshu.com/")!))
        view = webView
    }
}
