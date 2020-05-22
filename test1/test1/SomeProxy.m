//
//  SomeProxy.m
//  test1
//
//  Created by Xu小波 on 2020/3/24.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import "SomeProxy.h"
#import <WebKit/WebKit.h>

@interface SomeProxy ()

@property (nonatomic, weak) id obj;

@end

@implementation SomeProxy

- (void)dealloc {
    
    NSLog(@"SomeProxy - dealloc");
}

-(instancetype)initObject:(id)obj {
    
    self.obj = obj;
    
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation;{
    
    if ([self.obj respondsToSelector:invocation.selector]) {
        
        [invocation invokeWithTarget:self.obj];
    }
}
- (nullable NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    
    return [self.obj methodSignatureForSelector:sel];
}

#pragma mark - WKScriptMessageHandler

/*! @abstract Invoked when a script message is received from a webpage.
 @param userContentController The user content controller invoking the
 delegate method.
 @param message The script message received.
 */
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message; {
     if ([message.name isEqualToString:@"btnClick"]) {
            NSDictionary *jsData = message.body;
            NSLog(@"%@ - %@", message.name, jsData);
           
       }
}

@end
