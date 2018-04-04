//
//  BaalManager+Route.h
//  BaalDemo
//
//  Created by dianwoda on 2018/4/3.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalManager.h"
#import "BaalViewControllerRouteManager.h"
@interface BaalManager (Route)
+ (void)pushRouteViewController:(NSString *)pageName andParams:(NSDictionary *)params;
@end
