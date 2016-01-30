//
//  CLOAuthViewController.swift
//  CLOAuth2ViewController
//
//  Created by clee on 16/1/26.
//  Copyright © 2016年 cleexiang. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

protocol CLOAuthViewControllerDelegate: class {

    func oauthSuccess(viewController: CLOAuthViewController, accessToken: String)
    func oauthFail(viewController:CLOAuthViewController, error: NSError?)
}

class CLOAuthViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView?

    let baseURL: NSString
    let path: String
    let clientId: String
    let clientSecret: String
    let scope: String
    var redirectUri: String?
    var code: String?

    weak var delegate: CLOAuthViewControllerDelegate?

    init(baseURL: String, path: String, clientId: String, clientSecret: String, scopes: Array<String>, redirectUri: String) {
        self.baseURL = baseURL
        self.path = path
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.scope = scopes.joinWithSeparator(",")
        self.redirectUri = redirectUri.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.webView?.removeObserver(self, forKeyPath: "loading")
        self.webView?.navigationDelegate = nil
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
        queryStr = queryStr.stringByAppendingFormat("&scope=%@", scope)

        if let redirectUri = self.redirectUri {
            queryStr = queryStr.stringByAppendingFormat("&redirect_uri=%@", redirectUri)
        }
        if let url: NSURL = NSURL(string: queryStr) {
            self.webView?.loadRequest(NSURLRequest(URL:url))
        }

        self.webView?.addObserver(self, forKeyPath: "loading", options: NSKeyValueObservingOptions.New, context: nil)
    }

    func cancelAction() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath?.compare("loading") == NSComparisonResult.OrderedSame {
            let isLoading = change![NSKeyValueChangeNewKey]?.boolValue!
            if isLoading == false {
                if let code = self.code {
                    let params = ["client_id" : self.clientId, "client_secret" : self.clientSecret, "code" : code]
                    let headers = [
                        "Content-Type": "application/x-www-form-urlencoded",
                        "Accept": "application/json"
                    ]
                    Alamofire.request(.POST, "https://github.com/login/oauth/access_token", parameters: params, headers: headers).responseJSON{response in
                        if let json = response.result.value {
                            if let accessToken = json.objectForKey("access_token") {
                                self.delegate?.oauthSuccess(self, accessToken: accessToken as! String)
                            }
                        }
                        else
                        {
                            self.delegate?.oauthFail(self, error: nil)
                        }
                    }
                }
            }
        }
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

    func webView(webView: WKWebView, decidePolicyForNavigationResponse navigationResponse: WKNavigationResponse, decisionHandler: (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.Allow)
    }

    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        NSLog("")
    }
}

