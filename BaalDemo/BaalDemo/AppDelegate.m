//
//  AppDelegate.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/7.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "AppDelegate.h"
#import "Baal.h"
#import "BaalWeexOrHtmlHandlerImpl.h"
#import "BaalRouteHandlerImpl.h"
#import "WeexPluginManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self weexSDK];

    [self baalEnvironment];
    BaalWeexWebViewController *vc = [[BaalWeexWebViewController alloc] init];
//    [vc setBa_web_progressTintColor:[UIColor redColor]];
//    vc.fullScreen = YES;
    [vc ba_web_loadHtmlWithModulesAndUrl:@"http://192.168.101.204:8081/dist/pages/index.web.js" andParams:@{@"name":@"xxxx", @"age":@"年龄"}];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)baalEnvironment
{
    [BaalManager registerHandler:[BaalWeexOrHtmlHandlerImpl new] withProtocol:@protocol(BaalWeexOrHtmlHandlerProtocol)];
    [BaalManager registerHandler:[BaalRouteHandlerImpl new] withProtocol:@protocol(BaalRouteHandlerProtocol)];
    [BaalManager initBaalEnvironment];
}


- (void)weexSDK
{
    [WXAppConfiguration setAppGroup:@"dianwoda"];
    [WXAppConfiguration setAppName:@"baal"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    [WXSDKEngine initSDKEnvironment];
    [WeexPluginManager registerWeexPlugin];
#ifdef DEBUG
    [WXLog setLogLevel:WXLogLevelAll];
#endif
}



@end
