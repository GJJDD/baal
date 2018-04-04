//
//  WeexSDKManager.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalWeexPluginsManager.h"
#import <WeexSDK/WeexSDK.h>
#import "BaalNotifyChannelModule.h"
#import "BaalRouteModule.h"


@implementation BaalWeexPluginsManager

+ (void)setBaalWeexPlugin
{
    [WXSDKEngine registerModule:@"BaalNotifyChannel" withClass:[BaalNotifyChannelModule class]];
    [WXSDKEngine registerModule:@"BaalRouteModule" withClass:[BaalRouteModule class]];
}

@end
