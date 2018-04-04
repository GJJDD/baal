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
#import "BaalHandlerFactory.h"
#import "BaalRouteHandlerProtocol.h"
#import "BaalRouteHandlerDefaultImpl.h"

@implementation BaalViewControllerRouteManager



+ (void)ba_pushRouteViewController:(NSString *)pageName andParams:(NSDictionary *)params
{
    BaalRouteHandlerDefaultImpl<BaalRouteHandlerProtocol> *impl = [BaalHandlerFactory handlerForProtocol:@protocol(BaalRouteHandlerProtocol)];
    NSDictionary *routes = [impl routeConfig];
    NSDictionary *route = [routes objectForKey:pageName];
    BaalRoute *baalroute = [BaalRoute provinceWithDictionary:route];
    if ([baalroute.pageSwitch isEqualToString:@"native"]) {
        [self ba_pushNativeViewController:baalroute.nativeClassName andParams:params andPageName:pageName];
    } else if ([baalroute.pageSwitch isEqualToString:@"h5"]) {
        [self ba_pushWeexH5ViewController:baalroute.weexh5jsUrl params:params andPageName:pageName];
    } else if ([baalroute.pageSwitch isEqualToString:@"weex"]) {
        [self ba_pushWeexViewController:baalroute.weexjsUrl Params:params  andPageName:pageName];
    }
}


+ (void)ba_pushNativeViewController:(NSString * _Nullable)name andParams:(NSDictionary *)params andPageName:(NSString *)pageName
{
    Class class = NSClassFromString(name);
    if (class) {
        UIViewController *vc = (UIViewController *)[[class alloc] init];
        vc.params = params;
        vc.pageName = pageName;
        [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:YES];
    }
}


+ (void)ba_pushWeexH5ViewController:(NSString *)url params:(NSDictionary *)params andPageName:(NSString *)pageName
{
    BaalWeexWebViewController *vc = [[BaalWeexWebViewController alloc] init];
    vc.pageName = pageName;
    [vc ba_web_loadHtmlWithModulesAndUrl:url andParams:params];
    [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:YES];
}

+ (void)ba_pushWeexViewController:(NSString *)url Params:(NSDictionary *)params andPageName:(NSString *)pageName
{
    BaalWeexViewController *vc = [[BaalWeexViewController alloc] initWithSourceURL:[NSURL URLWithString:url] andParams:params];
    vc.pageName = pageName;
    [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController pushViewController:vc animated:YES];
}


@end
