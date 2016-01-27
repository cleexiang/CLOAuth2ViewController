//
//  CLOAuthViewController.swift
//  CLOAuth2ViewController
//
//  Created by clee on 16/1/26.
//  Copyright © 2016年 cleexiang. All rights reserved.
//

import UIKit
import WebKit

class CLOAuthViewController: UIViewController {

    var webView: WKWebView?

    var baseURL: NSString
    var path: String
    var clientId: String
    var scope: String
    var redirectUri: String

    init(baseURL: String, path: String, clientId: String, scopes: Array<String>, redirectUri: String) {
        self.baseURL = baseURL
        self.path = path
        self.clientId = clientId
        self.scope = scopes.joinWithSeparator(",")
        self.redirectUri = redirectUri

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.webView = WKWebView(frame: self.view.bounds)
        view.addSubview(webView!)

        let url: NSURL = NSURL(string: self.baseURL.stringByAppendingPathComponent(path).stringByAppendingFormat("?client_id=@&scope=%@&redirect_uri=%@", self.clientId, self.scope, self.redirectUri))!
        self.webView?.loadRequest(NSURLRequest(URL:url))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

