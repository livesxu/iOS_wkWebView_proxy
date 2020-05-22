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

@end
