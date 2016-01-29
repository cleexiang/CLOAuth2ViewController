//
//  ViewController.swift
//  CLOAuth2ViewController
//
//  Created by clee on 16/1/26.
//  Copyright © 2016年 cleexiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let loginBtn = UIButton(type: .System)
        loginBtn.frame = CGRectMake(100, 100, 200, 20)
        self.view.addSubview(loginBtn)
        loginBtn.setTitle("Login", forState: .Normal)
        loginBtn.addTarget(self, action: Selector("btnAction:"), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func btnAction(sender: AnyObject) {
        let oauthVC = CLOAuthViewController(baseURL: "https://www.github.com", path: "login/oauth/authorize",
            clientId: "97c3ec6cf4d92c7ba7bf", scopes: ["user", "repo", "notifications"], redirectUri: "http://cleexiang.github.io")
        let nav = UINavigationController(rootViewController: oauthVC)
        self.presentViewController(nav, animated: true) { () -> Void in

        }
    }
}
