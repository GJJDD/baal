//
//  UIViewController+BaalBase.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "UIViewController+BaalBase.h"
#import <objc/runtime.h>
#import "BaalNotifyChannelManager.h"

static void *pageNameKey = &pageNameKey;
static void *paramsKey = &paramsKey;
@implementation UIViewController (BaalBase)

-(void)setParams:(NSString *)params
{
    objc_setAssociatedObject(self, & paramsKey, params, OBJC_ASSOCIATION_COPY);
}

-(NSString *)params
{
    return objc_getAssociatedObject(self, &paramsKey);
}


-(void)setPageName:(NSString *)pageName
{
    objc_setAssociatedObject(self, & pageNameKey, pageName, OBJC_ASSOCIATION_COPY);
}

-(NSString *)pageName
{
    return objc_getAssociatedObject(self, &pageNameKey);
}
- (BOOL)currentPage:(NSString *)name
{
    UIViewController *vc = [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController topViewController];
    if ([vc.pageName isEqualToString:name]) {
        return YES;
    }
    return NO;
}

- (void)dealloc
{
    [[BaalNotifyChannelManager shared] unregisterPointAddress:[NSString stringWithFormat:@"%p",self]];
}


@end
