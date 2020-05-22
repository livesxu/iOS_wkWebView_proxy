# iOS_wkWebView_proxy
示例wkwebview与js交互
注意点：！！！！！
addScriptMessageHandler 很容易导致循环引用。使用NSProxy处理
1. 控制器 强引用了WKWebView, WKWebView copy configuration， configuration copy  userContentController 。
2.userContentController 强引用了self
