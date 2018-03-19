//
//  WeexPluginManager.m
//  fojiasanbao
//
//  Created by dianwoda on 2017/12/30.
//  Copyright © 2017年 fojiasanbao. All rights reserved.
//

#import "WeexPluginManager.h"
#import "WeexPluginLoader.h"
#import <WeexSDK/WeexSDK.h>
@implementation WeexPluginManager
+ (void)registerWeexPlugin
{
    NSArray *pluginNames = [NSArray arrayWithArray:[WeexPluginLoader getPlugins]];
    if (!pluginNames) {
        return;
    }
    [pluginNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *pluginInfo = (NSDictionary *)obj;
        if ([pluginInfo[@"category"] isEqualToString:@"handler"] && pluginInfo[@"protocol"]) {
            
            [WXSDKEngine registerHandler:[NSClassFromString(pluginInfo[@"ios-package"]) new]
                            withProtocol:NSProtocolFromString(pluginInfo[@"protocol"])];
        }else if ([pluginInfo[@"category"] isEqualToString:@"component"] && pluginInfo[@"ios-package"]) {
            [WXSDKEngine registerComponent:pluginInfo[@"api"] withClass:NSClassFromString(pluginInfo[@"ios-package"])];
        }else if ([pluginInfo[@"category"] isEqualToString:@"module"] && pluginInfo[@"ios-package"]) {
            [WXSDKEngine registerModule:pluginInfo[@"api"] withClass:NSClassFromString(pluginInfo[@"ios-package"])];
        }
    }];
}
@end
