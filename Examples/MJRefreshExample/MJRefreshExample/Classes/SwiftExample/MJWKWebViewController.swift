//
//  MJWKWebViewController.swift
//  MJRefreshExample
//
//  Created by Frank on 2021/3/3.
//  Copyright © 2021 小码哥. All rights reserved.
//

import UIKit
import WebKit
// 在实际的工程中, 使用以下 Import module 即可
//import MJRefresh

@objc
class MJWKWebViewController: UIViewController {
    var webView: WKWebView!
    
    func example41() {
        MJChiBaoZiHeader { [weak self] in
            self?.webView.reload()
        }.autoChangeTransparency(true)
        .link(to: webView.scrollView)
        
        webView.scrollView.mj_header?.beginRefreshing()
    }
}

// MARK: 🌈 无关例子的样式构建方法
extension MJWKWebViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constructViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        setNeedsStatusBarAppearanceUpdate()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    private func constructViews() {
        webView = WKWebView(frame: view.frame)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        let size = view.frame.size
        let warningLabel = UILabel(frame: CGRect(x: size.width - 210, y: size.height - 160, width: 200, height: 50))
        warningLabel.text = "注意，这不是原生界面，是个网页：http://weibo.com/excepptions"
        warningLabel.adjustsFontSizeToFitWidth = true
        warningLabel.textColor = .black
        warningLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        warningLabel.numberOfLines = 0
        let mask: UIView.AutoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        warningLabel.autoresizingMask = mask
        webView.addSubview(warningLabel)
        
        let backButton = UIButton(frame: CGRect(x: size.width - 210, y: size.height - 100, width: 200, height: 50))
        backButton.setTitle("回到上一页", for: .normal)
        backButton.backgroundColor = .red
        backButton.autoresizingMask = mask
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        webView.addSubview(backButton)
        
        webView.load(URLRequest(url: URL(string: "http://weibo.com/exceptions")!))
        example41()
    }
    
    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }
}


extension MJWKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.scrollView.mj_header?.endRefreshing()
    }
}
