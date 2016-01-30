//
//  ViewController.swift
//  CLOAuth2ViewController
//
//  Created by clee on 16/1/26.
//  Copyright © 2016年 cleexiang. All rights reserved.
//

import UIKit

let clientId: String = "Your client id"
let clientSecret: String = "Your client secret"

class ViewController: UIViewController, CLOAuthViewControllerDelegate {

    var lblStatus: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let loginBtn = UIButton(type: .System)
        loginBtn.frame = CGRectMake(100, 100, 200, 20)
        self.view.addSubview(loginBtn)
        loginBtn.setTitle("Login", forState: .Normal)
        loginBtn.addTarget(self, action: Selector("btnAction:"), forControlEvents: .TouchUpInside)

        self.lblStatus = UILabel(frame: CGRectMake(20, 140, 400, 20))
        self.lblStatus.textColor = UIColor.blackColor()
        self.view.addSubview(self.lblStatus)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func btnAction(sender: AnyObject) {
        let oauthVC = CLOAuthViewController(baseURL: "https://www.github.com",
            path: "login/oauth/authorize",
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: ["user", "repo", "notifications"],
            redirectUri: "http://www.github.com")
        oauthVC.delegate = self
        let nav = UINavigationController(rootViewController: oauthVC)
        self.presentViewController(nav, animated: true) { () -> Void in

        }
    }

    func oauthSuccess(viewController: CLOAuthViewController, accessToken: String) {
        self.lblStatus.text = "Success!" + accessToken
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }

    func oauthFail(viewController: CLOAuthViewController, error: NSError?) {
        NSLog("%@", (error?.localizedDescription)!)
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
