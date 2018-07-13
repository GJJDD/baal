//
//  BaalWeexOrHtmlHandlerImpl.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/16.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalWeexOrHtmlHandlerImpl.h"
#import "NotifyChannelViewController.h"
#import "BaalWeexViewController.h"
#import "AppDelegate.h"
@implementation BaalWeexOrHtmlHandlerImpl

- (NSMutableArray *)ba_registerModules:(WKWebView *)webView andWeexParams:(NSString *)weexParamsJson andCallback:(WXModuleKeepAliveCallback)callback
{
    
    Baal_moduleMethodBlock block = ^(WKUserContentController *userContentController, WKScriptMessage *message){
        NSDictionary *dict = dictionaryToJson(message?message.body:weexParamsJson);
        NSDictionary *params = dict[@"params"];
        if (message) {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":params[@"params"][@"aa"]};
            [webView ba_web_stringByEvaluateJavaScript:ba_web_callJs(dict[@"callbackJsMethod"], returnData) completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
                
            }];
        } else {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":params[@"params"][@"aa"]};
            callback(returnData,false);
        }
    };
    
    Baal_moduleMethodBlock block1 = ^(WKUserContentController *userContentController, WKScriptMessage *message){
        NSDictionary *dict = dictionaryToJson(message?message.body:weexParamsJson);
        NSDictionary *params = dict[@"params"];
        if (message) {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":@"zh"};
            
            //            NotifyChannelViewController *v = [[NotifyChannelViewController alloc] initWithNibName:@"NotifyChannelViewController" bundle:nil];
            
            
            BaalWeexViewController *v = [[BaalWeexViewController alloc] initWithSourceURL:[NSURL URLWithString:@"http://192.168.103.70:8080/dist/weex/views/account/BindAlipayView.js"] andParams:@{@"name":@"zhansan"}];
            [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:v animated:YES];
            
            
            
        } else {
            /* 核心业务逻辑 */
            NSDictionary *returnData = @{@"name":@"zh"};
            callback(returnData,false);
        }
    };
    NSArray *modules  = @[@{@"moduleName":@"Guide",@"moduleMethod":@{@"greeting":block,@"pushNotify":block1}}];
    
    return [NSMutableArray arrayWithArray:modules];
}
@end
