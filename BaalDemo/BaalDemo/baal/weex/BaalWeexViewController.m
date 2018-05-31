//
//  BaalWeexViewController.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalWeexViewController.h"
#import <WeexSDK/WeexSDK.h>
#import "Baal_ConfigurationDefine.h"
@interface BaalWeexViewController ()
@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, strong) NSURL *sourceURL;
@end

@implementation BaalWeexViewController
{
    NSString *_paramsUrlTag;
}

- (void)dealloc
{
    [_instance destroyInstance];
    [self _removeObservers];
}

- (instancetype)initWithSourceURL:(NSURL *)sourceURL
{
    return [self initWithSourceURL:sourceURL andParams:nil];
}

- (instancetype)initWithSourceURL:(NSURL *)sourceURL andParams:(NSDictionary *)params
{
    if ((self = [super init])) {
        self.sourceURL = sourceURL;
        self.hidesBottomBarWhenPushed = YES;
        self.params = params;
        if (params && [params allKeys].count) {
            [self configureParamsUrlTag:params];
        }
        [self _addObservers];
    }
    return self;
}

- (void)configureParamsUrlTag:(NSDictionary *)paramsDict
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:paramsDict];
    [params setObject:[NSString stringWithFormat:@"%d", arc4random()] forKey:@"random"];
    
    NSString *params_url_string = @"";
    
    for (NSString *key in [params allKeys]) {
        if ([params[key] isKindOfClass:[NSString class]]
            || [params[key] isKindOfClass:[NSNumber class]]
            || [params[key] isKindOfClass:[NSArray class]]
            || [params[key] isKindOfClass:[NSDictionary class]]) {
            NSString *lastTagString = [[[params allKeys] lastObject] isEqualToString:key] ? @"" : @"&";
            params_url_string = [NSString stringWithFormat:@"%@%@=%@%@", params_url_string, key, params[key], lastTagString];
        }
    }
    
    if (params_url_string.length) {
        params_url_string = [params_url_string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        _sourceURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", [_sourceURL absoluteString], params_url_string]];
    }
}

/**
 *  After setting the navbar hidden status , this function will be called automatically. In this function, we
 *  set the height of mainView equal to screen height, because there is something wrong with the layout of
 *  page content.
 */

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if ([self.navigationController isKindOfClass:[WXRootViewController class]]) {
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        frame.size.height = [UIScreen mainScreen].bounds.size.height;
        self.view.frame = frame;
    }
}

/**
 *  We assume that the initial state of viewController's navigtionBar is hidden.  By setting the attribute of
 *  'dataRole' equal to 'navbar', the navigationBar hidden will be NO.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self _renderWithURL:_sourceURL];
    if ([self.navigationController isKindOfClass:[WXRootViewController class]]) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_instance fireGlobalEvent:WX_APPLICATION_WILL_RESIGN_ACTIVE params:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_instance fireGlobalEvent:WX_APPLICATION_DID_BECOME_ACTIVE params:nil];
    [self _updateInstanceState:WeexInstanceAppear];
    
}

- (void)weexNotificationPopBack:(NSNotification *)notification
{
    NSLog(@"---接收到通知---");
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self _updateInstanceState:WeexInstanceDisappear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self _updateInstanceState:WeexInstanceMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWeex
{
    [self _renderWithURL:_sourceURL];
}


- (void)_renderWithURL:(NSURL *)sourceURL
{
    if (!sourceURL) {
        return;
    }
    
    [_instance destroyInstance];
    if([WXPrerenderManager isTaskReady:[self.sourceURL absoluteString]]){
        _instance = [WXPrerenderManager instanceFromUrl:self.sourceURL.absoluteString];
    }
    
    _instance = [[WXSDKInstance alloc] init];
    _instance.frame = CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    _instance.pageObject = self;
    _instance.pageName = sourceURL.absoluteString;
    _instance.viewController = self;
    
    [_instance renderWithURL:sourceURL options:@{@"bundleUrl":sourceURL.absoluteString} data:nil];
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        
    };
    
    _instance.renderFinish = ^(UIView *view) {
        [weakSelf _updateInstanceState:WeexInstanceAppear];
    };
    
    if([WXPrerenderManager isTaskReady:[self.sourceURL absoluteString]]){
        WX_MONITOR_INSTANCE_PERF_START(WXPTJSDownload, _instance);
        WX_MONITOR_INSTANCE_PERF_END(WXPTJSDownload, _instance);
        WX_MONITOR_INSTANCE_PERF_START(WXPTFirstScreenRender, _instance);
        WX_MONITOR_INSTANCE_PERF_START(WXPTAllRender, _instance);
        [WXPrerenderManager renderFromCache:[self.sourceURL absoluteString]];
        return;
    }
}

- (void)_updateInstanceState:(WXState)state
{
    if (_instance && _instance.state != state) {
        _instance.state = state;
        
        if (state == WeexInstanceAppear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewappear" params:nil domChanges:nil];
        } else if (state == WeexInstanceDisappear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewdisappear" params:nil domChanges:nil];
        }
    }
}

- (void)_appStateDidChange:(NSNotification *)notify
{
    if ([notify.name isEqualToString:@"UIApplicationDidBecomeActiveNotification"]) {
        [self _updateInstanceState:WeexInstanceForeground];
    } else if([notify.name isEqualToString:@"UIApplicationDidEnterBackgroundNotification"]) {
        [self _updateInstanceState:WeexInstanceBackground]; ;
    }
}

- (void)_addObservers
{
    for (NSString *name in @[UIApplicationDidBecomeActiveNotification,
                             UIApplicationDidEnterBackgroundNotification]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_appStateDidChange:)
                                                     name:name
                                                   object:nil];
    }
}

- (void)_removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
