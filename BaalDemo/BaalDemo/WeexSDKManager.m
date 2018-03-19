//
//  WeexSDKManager.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "WeexSDKManager.h"
#import <WeexSDK/WeexSDK.h>
#import "WeexPluginManager.h"
@implementation WeexSDKManager
+ (void)weexSDK
{
    [WXAppConfiguration setAppGroup:@"dianwoda"];
    [WXAppConfiguration setAppName:@"baal"];
    [WXAppConfiguration setExternalUserAgent:@"ExternalUA"];
    [WXSDKEngine initSDKEnvironment];
    [self setWeexPlugin];
    [self startWeexLog];
}
+ (void)setWeexPlugin
{
    [WeexPluginManager registerWeexPlugin];
}
+ (void)startWeexLog
{
#ifdef DEBUG
    [WXLog setLogLevel:WXLogLevelAll];
#endif
}
@end
