//
//  BaalViewControllerRouteManager.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalViewControllerRouteManager.h"
#import "UIViewController+BaalBase.h"
#import "BaalWeexViewController.h"
#import "BaalWeexWebViewController.h"

@implementation BaalViewControllerRouteManager

+ (instancetype)shared {
    static BaalViewControllerRouteManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BaalViewControllerRouteManager alloc] init];
    });
    return manager;
}

- (void)ba_pushNativeViewController:(NSString * _Nullable)name andParams:(NSDictionary *)params
{

}


- (void)ba_pushWeexH5ViewController:(NSString *)url params:(NSDictionary *)params
{
    BaalWeexWebViewController *vc = [[BaalWeexWebViewController alloc] init];
//    [self keyValueStringandUrl:url andParams:@{@"name":@"xxxx", @"age":@"年龄"}];
    
    [vc ba_web_loadHtmlWithModulesAndUrl:url];
    [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:YES];
}

- (void)ba_pushWeexViewController:(NSString *)url Params:(NSDictionary *)params
{
  
}







@end
