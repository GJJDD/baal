//
//  BaalWeexOrHtmlHandlerImpl.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/16.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalWeexOrHtmlHandlerImpl.h"


@implementation BaalWeexOrHtmlHandlerImpl

- (NSArray *)ba_registerModules:(WKWebView *)webView andWeexParams:(NSString *)weexParamsJson andCallback:(WXModuleKeepAliveCallback)callback
{
    
    Baal_moduleMethodBlock block = ^(WKUserContentController *userContentController, WKScriptMessage *message){
        NSDictionary *dict = dictionaryToJson(message?message.body:weexParamsJson);
        NSDictionary *params = dict[@"params"];
        if (message) {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":@"zh"};
            [webView ba_web_stringByEvaluateJavaScript:ba_web_callJs(dict[@"callbackJsMethod"], returnData) completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
                
            }];
        } else {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":@"zh"};
            callback(returnData,false);
        }
    };
    Baal_moduleMethodBlock block1 = ^(WKUserContentController *userContentController, WKScriptMessage *message){
        
    };
    NSArray *modules  = @[@{@"moduleName":@"Guide",@"moduleMethod":@{@"greeting":block,@"greeting1":block1}}];
    return modules;
}


@end
