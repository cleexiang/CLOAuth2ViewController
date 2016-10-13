###  CLOAuth2ViewController
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

####  可用于实现OAuth2.0认证

####  使用方法
~~~
let oauthVC = CLOAuthViewController(baseURL: instagram_api,
                                            clientId: instagram_clientId,
                                            clientSecret: instagram_clientSecret,
                                            scopes: instagram_scopes,
                                            redirectUri: "your redirect uri")


        
~~~
