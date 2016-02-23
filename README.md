###  CLOAuth2ViewController
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

####  可用于实现OAuth2.0认证

####  使用方法
~~~
let oauthVC = CLOAuthViewController(baseURL: "https://www.github.com",
            path: "login/oauth/authorize",
            clientId: clientId,
            clientSecret: clientSecret,
            scopes: ["user", "repo", "notifications"],
            redirectUri: "http://www.github.com")
oauthVC.delegate = self
let nav = UINavigationController(rootViewController: oauthVC)
self.presentViewController(nav, animated: true) { () -> Void in

        
~~~
