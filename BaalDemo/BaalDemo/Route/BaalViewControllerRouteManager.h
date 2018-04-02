//
//  BaalViewControllerRouteManager.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaalViewControllerRouteManager : NSObject
+ (instancetype)shared;
- (void)ba_pushRouteViewController:(NSString *)pageName andParams:(NSDictionary *)params;
@end
