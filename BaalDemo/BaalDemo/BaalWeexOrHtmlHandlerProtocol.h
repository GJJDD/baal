//
//  BaalWeexOrHtmlHandlerProtocol.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/16.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baal_WebView.h"
#import <WeexSDK/WeexSDK.h>

@protocol BaalWeexOrHtmlHandlerProtocol <NSObject>
- (NSArray *)ba_web_registerModules:(WKWebView *)webView andWeexParams:(NSString *)weexParamsJson andCallback:(WXModuleKeepAliveCallback)callback;
@end

