//
//  CLOAuthViewController.swift
//  CLOAuth2ViewController
//
//  Created by clee on 16/1/26.
//  Copyright © 2016年 cleexiang. All rights reserved.
//

import UIKit
import WebKit

class CLOAuthViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView?

    var baseURL: NSString
    var path: String
    var clientId: String
    var scope: String?
    var redirectUri: String?
    var code: String?

    init(baseURL: String, path: String, clientId: String, scopes: Array<String>, redirectUri: String) {
        self.baseURL = baseURL
        self.path = path
        self.clientId = clientId
        self.scope = scopes.joinWithSeparator(",")
        self.redirectUri = redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel,
            target: self, action: Selector("cancelAction"))

        self.webView = WKWebView(frame: self.view.bounds)
        self.webView?.navigationDelegate = self;
        view.addSubview(webView!)

        var queryStr = self.baseURL.stringByAppendingPathComponent(self.path).stringByAppendingFormat("?client_id=%@", self.clientId)
        if let scope = self.scope {
            queryStr = queryStr.stringByAppendingFormat("&scope=%@", scope)
        }
        if let redirectUri = self.redirectUri {
            queryStr = queryStr.stringByAppendingFormat("&redirect_uri=%@", redirectUri)
        }
        if let url: NSURL = NSURL(string: queryStr) {
            self.webView?.loadRequest(NSURLRequest(URL:url))
        }
    }

    func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        NSLog("%@", navigationAction.request.URL!)

        if let urlString = navigationAction.request.URL?.absoluteString {
            if urlString.containsString("code=") {
                let comps = urlString.componentsSeparatedByString("code=")
                if comps.count == 2 {
                    self.code = comps.last
                }
            }
        }
        decisionHandler(.Allow)
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        NSLog("%@", navigation)
    }

    func webView(webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        NSLog("%@", navigation)
    }

    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {

        NSLog("%@", navigationResponse)
        decisionHandler(.Allow)
    }

}

