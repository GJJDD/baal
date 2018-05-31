//
//  BaalRouteModule.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/28.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalRouteModule.h"
#import "BaalViewControllerRouteManager.h"
#import "Baal_ConfigurationDefine.h"
@implementation BaalRouteModule
WX_EXPORT_METHOD(@selector(pushRouteViewController:))
- (void)pushRouteViewController:(nonnull NSString *)params
{
    NSDictionary *dict = dictionaryToJson(params);
    [BaalViewControllerRouteManager  ba_pushRouteViewController:dict[@"params"][@"pageName"] andParams:dict[@"params"][@"params"]];
}
@end
