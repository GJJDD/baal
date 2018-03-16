//
//  AppDelegate.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/7.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "AppDelegate.h"
#import "BaalWeexWebViewController.h"


//static NSString * const htmlStr = @"<!DOCTYPE html>\n<html>\n    <head>\n        <meta charset=\"utf-8\">\n            <title>点我达骑手</title>\n            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\n                <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\n                    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\n                        <meta name=\"apple-touch-fullscreen\" content=\"yes\">\n                            <meta name=\"format-detection\" content=\"telephone=no, email=no\">\n                                <style>body::before { content: \"1\"; height: 0px; overflow: hidden; color: transparent; display: block; }body{margin:0;padding:0}</style>\n                                <script src=\"http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/vue/vue.min.js\"></script>\n                                <script src=\"http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/weex-vue-render/index.min.js\"></script>\n    </head>    <body>\n        <div id=\"root\"></div>\n        <script>\n            module = {\n                init: function (weex) {\n                    weex.registerModule('guide', {\n                                        greeting () {\n                                          webkit.messageHandlers.pushVc.postMessage('xxx');\n                                        }\n                                        })\n                }\n            }\n        weex.install(module);\n        </script>\n        <script src=\"http://192.168.103.70:8080/dist/web/views/setting/ModifyAccountView.js\"></script>\n    </body>\n</html>\n";








@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    

    
    BaalWeexWebViewController *vc = [[BaalWeexWebViewController alloc] init];
    [vc setBa_web_progressTintColor:[UIColor redColor]];

    [vc ba_scriptMessageHandler:[NSMutableDictionary dictionary]];
//    [vc registerNativeHelperJS];
//    [vc ba_web_loadURL:[NSURL URLWithString:@"http://192.168.103.70:8080/html/setting/ModifyAccountView.html"]];
//    [vc ba_web_loadHTMLFileName:@"index"];
    
    
//    NSString *file = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//
//
//    NSString *js = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil];
//
//
//
//
//    [vc ba_web_loadHTMLString:js];
    
    NSArray *modules  = @[@{@"moduleName":@"guide",@"moduleMethod":@[@"greeting",@"greeting1"]}];
    NSString *htmlurl = @"http://192.168.103.70:8080/dist/web/views/setting/ModifyAccountView.js";
    NSString *weexHtml = [self weexHtmlHybridModules:modules andWeexHtmlJs:htmlurl];
    
    [vc ba_web_loadHTMLString:weexHtml];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (NSString *)weexHtmlHybridModules:(NSArray *)modules andWeexHtmlJs:(NSString *)url
{
    NSString *nativeHybrid = @"        <script>\n            var nativeHybrid = {}\n            if (weex.config.env.platform === 'Web') {\n                window.NativeHybrid = nativeHybrid\n                if (window.Vue) {\n                    window.Vue.use(nativeHybrid)\n                }\n            }\n        </script>\n        \n    \n";
    NSMutableString *weexhtmlModule = [NSMutableString string];
    [modules enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *weexhtmlMethod = [NSMutableString string];
        for (int i = 0;i<[obj[@"moduleMethod"] count];i++) {

            [weexhtmlMethod appendFormat:@"\n                                        %@ (params, callback) {\n                                          webkit.messageHandlers.%@.postMessage(params,callback);\n                                            nativeHybrid.%@ = function(data) {\n                                                callback(data);\n                                             }\n                                       },\n",obj[@"moduleMethod"][i],obj[@"moduleMethod"][i],obj[@"moduleMethod"][i]];
        }
        [weexhtmlModule appendFormat:@"\n<script>\n            %@ = {\n                init: function (weex) {\n                    weex.registerModule('%@', {%@                                        })\n                }\n            }\n        weex.install(%@);\n        </script>\n",obj[@"moduleName"],obj[@"moduleName"],weexhtmlMethod,obj[@"moduleName"]];
        weexhtmlMethod = nil;

    }];

    NSString *weexhtml = [NSString stringWithFormat:@"<!DOCTYPE html>\n<html>\n    <head>\n        <meta charset=\"utf-8\">\n            <title>点我达骑手</title>\n            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\n                <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\n                    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\n                        <meta name=\"apple-touch-fullscreen\" content=\"yes\">\n                            <meta name=\"format-detection\" content=\"telephone=no, email=no\">\n                                <style>body::before { content: \"1\"; height: 0px; overflow: hidden; color: transparent; display: block; }body{margin:0;padding:0}</style>\n                                <script src=\"http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/vue/vue.min.js\"></script>\n                                <script src=\"http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/weex-vue-render/index.min.js\"></script>\n    </head>    <body>\n        <div id=\"root\"></div>\n        %@%@\n        <script src=\"%@\"></script>\n    </body>\n</html>\n",weexhtmlModule,nativeHybrid,url];
    return weexhtml;
}

@end
