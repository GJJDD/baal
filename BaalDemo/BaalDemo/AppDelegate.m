//
//  AppDelegate.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/7.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "AppDelegate.h"
#import "BaalWeexWebViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    

    
    BaalWeexWebViewController *vc = [[BaalWeexWebViewController alloc] init];
    [vc setBa_web_progressTintColor:[UIColor redColor]];
    [vc ba_web_loadURL:[NSURL URLWithString:@"http://m.baidu.com"]];

    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
