//
//  BaalWeexOrHtmlHandlerImpl.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/16.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalWeexOrHtmlHandlerImpl.h"


@implementation BaalWeexOrHtmlHandlerImpl

- (NSArray *)ba_web_registerModules:(WKWebView *)webView andWeexParams:(NSString *)weexParamsJson andCallback:(WXModuleCallback)callback
{
    
    Baal_moduleMethodBlock block = ^(WKUserContentController *userContentController, WKScriptMessage *message){
        NSError *err;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[message?message.body:weexParamsJson dataUsingEncoding:NSUTF8StringEncoding]
                                                             options:NSJSONReadingMutableContainers
                                                               error:&err];
        NSDictionary *params = dict[@"params"];
        if (message) {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":@"zh"};
            [self ba_web_callJs:dict[@"callbackJsMethod"] andData:returnData andWebView:webView];
        } else {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":@"zh"};
            callback(returnData);
        }
    };
    Baal_moduleMethodBlock block1 = ^(WKUserContentController *userContentController, WKScriptMessage *message){
        
    };
    NSArray *modules  = @[@{@"moduleName":@"Guide",@"moduleMethod":@{@"greeting":block,@"greeting1":block1}}];
    
    
    return modules;
}


- (void)ba_web_callJs:(NSString *)method andData:(NSDictionary *)data andWebView:(WKWebView *)webView
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    NSString *paramsJson = nil;
    if (error) {
        paramsJson = @"";
    } else {
        paramsJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSString *jsmethod = [method stringByAppendingString:@"()"];
    if ([paramsJson isKindOfClass:[NSString class]]){
        jsmethod = [NSString stringWithFormat:@"%@(%@)",method,paramsJson];
    }
    [webView ba_web_stringByEvaluateJavaScript:jsmethod completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
        
    }];
}
@end
