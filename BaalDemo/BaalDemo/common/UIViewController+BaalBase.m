//
//  UIViewController+BaalBase.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "UIViewController+BaalBase.h"
#import <objc/runtime.h>
static void *pageIdKey = &pageIdKey;
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


-(void)setPageId:(NSString *)pageId
{
    objc_setAssociatedObject(self, & pageIdKey, pageId, OBJC_ASSOCIATION_COPY);
}

-(NSString *)pageId
{
    return objc_getAssociatedObject(self, &pageIdKey);
}
- (BOOL)currentPage:(NSString *)name
{
    UIViewController *vc = [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController topViewController];
    if ([vc.pageId isEqualToString:name]) {
        return YES;
    }
    return NO;
}




@end
