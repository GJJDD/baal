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
#import "BaalRoute.h"


@implementation BaalViewControllerRouteManager

+ (instancetype)shared {
    static BaalViewControllerRouteManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BaalViewControllerRouteManager alloc] init];
    });
    return manager;
}

- (NSDictionary *)readRouteConfig:(NSString *)path
{
    NSString *absolutePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    if (absolutePath) {
        return [NSDictionary dictionaryWithContentsOfFile:absolutePath];
    }
    return @{};
    
}

- (void)ba_pushRouteViewController:(NSString *)pageName andParams:(NSDictionary  *)params
{
    NSDictionary *routes = [self readRouteConfig:@"routeConfig.json"];
    NSDictionary *route = [routes objectForKey:pageName];
    BaalRoute *baalroute = [BaalRoute provinceWithDictionary:route];
    if ([baalroute.pageSwitch isEqualToString:@"native"]) {
        [self ba_pushNativeViewController:baalroute.nativeClassName andParams:params];
    } else if ([baalroute.pageSwitch isEqualToString:@"H5"]) {
        [self ba_pushWeexH5ViewController:baalroute.weexh5jsUrl params:params];
    } else if ([baalroute.pageSwitch isEqualToString:@"weex"]) {
        [self ba_pushWeexViewController:baalroute.weexjsUrl Params:params];
    }
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
