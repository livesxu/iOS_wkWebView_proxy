//
//  SomeProxy.h
//  test1
//
//  Created by Xu小波 on 2020/3/24.
//  Copyright © 2020 Xu小波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SomeProxy : NSProxy<WKScriptMessageHandler>

-(instancetype)initObject:(id)obj;

@end

NS_ASSUME_NONNULL_END
