//
//  WebViewController.swift
//  Demo
//
//  Created by 王韬 on 2021/11/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var webView: WKWebView = {
        let view = WKWebView(frame: UIScreen.main.bounds)
        return view
    }()
    
    private func loadWeb(url: String) {
        self.webView.load(URLRequest(url: URL(string: url)!))
        view.addSubview(webView)
    }
}

extension WebViewController: RouterProtocol {
    static func targetWith(pa: [String : Any]) -> RouterProtocol? {
        let vc = WebViewController()
        if let url = pa["url"] as? String {
            vc.loadWeb(url: url)
        }
        return vc
    }
}
