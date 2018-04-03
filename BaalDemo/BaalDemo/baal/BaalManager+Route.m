//
//  BaalManager+Route.m
//  BaalDemo
//
//  Created by dianwoda on 2018/4/3.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalManager+Route.h"

@implementation BaalManager (Route)
+ (void)pushRouteViewController:(NSString *)pageName andParams:(NSDictionary *)params
{
    [BaalViewControllerRouteManager ba_pushRouteViewController:pageName andParams:params];
}
@end
