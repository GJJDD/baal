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
    Class class = NSClassFromString(name);
    if (class) {
        UIViewController *vc = (UIViewController *)[[class alloc] init];
        vc.params = params;
        [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:YES];
    }
}


- (void)ba_pushWeexH5ViewController:(NSString *)url params:(NSDictionary *)params
{
    BaalWeexWebViewController *vc = [[BaalWeexWebViewController alloc] init];
    [vc ba_web_loadHtmlWithModulesAndUrl:url andParams:params];
    [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:YES];
}

- (void)ba_pushWeexViewController:(NSString *)url Params:(NSDictionary *)params
{
    BaalWeexViewController *vc = [[BaalWeexViewController alloc] initWithSourceURL:[NSURL URLWithString:url] andParams:params];
    [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:YES];
}


@end
