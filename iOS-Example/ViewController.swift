//
//  ViewController.swift
//  CLOAuth2ViewController
//
//  Created by clee on 16/1/26.
//  Copyright © 2016年 cleexiang. All rights reserved.
//

import UIKit
import CLOAuth2ViewController

let instagram_api = "https://api.instagram.com"
let instagram_clientId = "8eb739684b704d5bbe3dc62c1ec59a2d"
let instagram_clientSecret = "dda032d1545b42a7801c02fac663a545"
let instagram_scopes = ["basic"]

let github_api = "https://github.com/login"
let github_clientId = "266557c55a627b37fb47"
let github_clientSecret = "48ae5061eb68c5a03d00e81e09046b21fd98092d"
let github_scopes = ["user", "repo", "notifications"]

class ViewController: UIViewController, CLOAuthViewControllerDelegate {

    var lblStatus: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let loginBtn = UIButton(type: .system)
        loginBtn.frame = CGRect(x: 100, y: 100, width: 200, height: 20)
        self.view.addSubview(loginBtn)
        loginBtn.setTitle("Login", for: UIControlState())
        loginBtn.addTarget(self, action: #selector(ViewController.btnAction(_:)), for: .touchUpInside)

        self.lblStatus = UILabel(frame: CGRect(x: 20, y: 140, width: 400, height: 20))
        self.lblStatus.textColor = UIColor.black
        self.view.addSubview(self.lblStatus)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func btnAction(_ sender: AnyObject) {
//        let oauthVC = CLOAuthViewController(baseURL: github_api,
//                                            clientId: github_clientId,
//                                            clientSecret: github_clientSecret,
//                                            scopes: github_scopes,
//                                            redirectUri: "http://cleexiang.github.io/")

        let oauthVC = CLOAuthViewController(baseURL: instagram_api,
                                            clientId: instagram_clientId,
                                            clientSecret: instagram_clientSecret,
                                            scopes: instagram_scopes,
                                            redirectUri: "http://cleexiang.github.io/")

        oauthVC.delegate = self
        let nav = UINavigationController(rootViewController: oauthVC)
        self.present(nav, animated: true, completion: nil)
    }

    func oauthSuccess(_ viewController: CLOAuthViewController, accessToken: String) {
        self.lblStatus.text = "Success!" + accessToken
        viewController.dismiss(animated: true, completion: nil)
    }

    func oauthFail(_ viewController: CLOAuthViewController, error: NSError?) {
        self.lblStatus.text = "Fail!" + (error?.localizedDescription)!
        viewController.dismiss(animated: true, completion: nil)
    }
}
