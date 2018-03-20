//
//  AppDelegate.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/7.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "AppDelegate.h"
#import "BaalWeexWebViewController.h"
#import "BaalHandlerFactory.h"
#import "BaalWeexOrHtmlHandlerImpl.h"
#import "BaalWeexOrHtmlHandlerProtocol.h"
#import "WeexSDKManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [WeexSDKManager weexSDK];
    [BaalHandlerFactory registerHandler:[BaalWeexOrHtmlHandlerImpl new] withProtocol:@protocol(BaalWeexOrHtmlHandlerProtocol)];
    BaalWeexWebViewController *vc = [[BaalWeexWebViewController alloc] init];
    [vc setBa_web_progressTintColor:[UIColor redColor]];
    vc.fullScreen = YES;
    [vc ba_web_loadHtmlWithModulesAndUrl:@"http://192.168.103.70:8080/dist/web/views/setting/ModifyAccountView.js"];
//    WXBaseViewController *vc = [[WXBaseViewController alloc] initWithSourceURL:[NSURL URLWithString:@"http://192.168.103.70:8080/dist/weex/views/setting/ModifyAccountView.js"]];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
//    [rootViewController setNavigationBarHidden:YES];
    
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    return YES;
}






@end
