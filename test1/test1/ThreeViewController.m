//
//  ThreeViewController.m
//  test1
//
//  Created by Xu小波 on 2020/5/22.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "ThreeViewController.h"
#import <WebKit/WebKit.h>

#import "SomeProxy.h"

@interface ThreeViewController ()<WKNavigationDelegate,WKUIDelegate/*,WKScriptMessageHandler*/>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ThreeViewController

- (void)dealloc {
    
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"btnClick"];
    
    NSLog(@"%@-%@",NSStringFromClass(self.class),NSStringFromSelector(_cmd));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    
    //加载HTML
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"HtmlFile" ofType:@"html"];
    [self.webView loadRequest:[[NSURLRequest alloc]initWithURL:[NSURL fileURLWithPath:htmlPath]]];
    
    // 注入JS对象名称btnClick，当JS通过btnClick来调用时， 可以在WKScriptMessageHandler代理中接收到
    // addScriptMessageHandler 很容易导致循环引用。1. 控制器 强引用了WKWebView, WKWebView copy configuration， configuration copy  userContentController 。2.userContentController 强引用了 self （控制器）
    [self.webView.configuration.userContentController addScriptMessageHandler:[[SomeProxy alloc]initObject:self] name:@"btnClick"];
    
}

- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        // web内容处理池
        config.processPool = [[WKProcessPool alloc] init];
        // 通过JS与webview内容交互
        config.userContentController = [[WKUserContentController alloc] init];
        //        // 注入JS对象名称xxx，当JS通过xxx来调用时，
        //        // 可以在WKScriptMessageHandler代理中接收到
        //        [config.userContentController addScriptMessageHandler:self name:@"xxx"];
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                      configuration:config];
        //        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.backgroundColor = [UIColor yellowColor];
    }
    return _webView;
}

//#pragma mark - WKScriptMessageHandler
//
///*! @abstract Invoked when a script message is received from a webpage.
// @param userContentController The user content controller invoking the
// delegate method.
// @param message The script message received.
// */
//- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message; {
//     if ([message.name isEqualToString:@"btnClick"]) {
//            NSDictionary *jsData = message.body;
//            NSLog(@"%@ - %@", message.name, jsData);
//
//
//         NSString *jsCallBack = @"var demo  = document.getElementById(\"demo\");\
//                              demo.innerHTML = \"test2222222222222222222Data\";";
//         //执行回调
//         [self.webView evaluateJavaScript:jsCallBack completionHandler:^(id _Nullable result, NSError * _Nullable error) {
//             if (error) {
//                 NSLog(@"err is %@", error.domain);
//             }
//         }];
//       }
//}
#pragma mark - delegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSString *jsCallBack = @"var demo  = document.getElementById(\"demo\");\
                         demo.innerHTML = \"testData\";";
    //执行回调
    [self.webView evaluateJavaScript:jsCallBack completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"err is %@", error.domain);
        }
    }];

}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");

}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandle {
//    decisionHandler(WKNavigationActionPolicyAllow);
//}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}




@end
