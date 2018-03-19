//
//  BaalWeexWebViewController.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/7.
//  Copyright © 2018年 dianwoda. All rights reserved.
//


#import "BaalWeexWebViewController.h"
#import "BaalHandlerFactory.h"
#import "BaalWeexOrHtmlHandlerProtocol.h"
#import "BaalWeexOrHtmlHandlerImpl.h"
@interface BaalWeexWebViewController ()

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) WKWebViewConfiguration *webConfig;
@property(nonatomic, strong) UIProgressView *progressView;

@property(nonatomic, strong) NSURL *ba_web_currentUrl;

@end

@implementation BaalWeexWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI
{
    self.view.backgroundColor = Baal_Color_White_pod;
    self.webView.hidden = NO;
//    [self registerNativeHelperJS];
//    [self configBackItem];
//    [self configMenuItem];
    
    Baal_WeakSelf;
    self.webView.ba_web_didStartBlock = ^(WKWebView *webView, WKNavigation *navigation) {
        
        //        Baal_StrongSelf
        NSLog(@"开始加载网页");
    };
    
    self.webView.ba_web_didFinishBlock = ^(WKWebView *webView, WKNavigation *navigation) {
        Baal_StrongSelf;

        
    };
    
    self.webView.ba_web_isLoadingBlock = ^(BOOL isLoading, CGFloat progress) {
        
        Baal_StrongSelf
        [self ba_web_progressShow];
        self.progressView.progress = progress;
        if (self.progressView.progress == 1.0f)
        {
            [self ba_web_progressHidder];
        }
    };
    
    self.webView.ba_web_getTitleBlock = ^(NSString *title) {
        
        Baal_StrongSelf
        // 获取当前网页的 title
        self.title = title;
    };
    
    self.webView.ba_web_getCurrentUrlBlock = ^(NSURL * _Nonnull currentUrl) {
        Baal_StrongSelf
        self.ba_web_currentUrl = currentUrl;
    };
}

#pragma mark - 修改 navigator.userAgent
- (void)changeNavigatorUserAgent
{
    Baal_WeakSelf
    [self.webView ba_web_stringByEvaluateJavaScript:@"navigator.userAgent" completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
        Baal_StrongSelf
        NSLog(@"old agent ----- :%@", result);
        NSString *userAgent = result;
        
        NSString *customAgent = @" native_iOS";
        if ([userAgent hasSuffix:customAgent])
        {
            NSLog(@"navigator.userAgent已经修改过了");
        }
        else
        {
            NSString *customUserAgent = [userAgent stringByAppendingString:[NSString stringWithFormat:@"%@", customAgent]]; // 这里加空格是为了好看
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:customUserAgent, @"UserAgent", nil];
            [Baal_NSUserDefaults registerDefaults:dictionary];
            [Baal_NSUserDefaults synchronize];
            
            [self.webView setCustomUserAgent:customUserAgent];
            [self ba_reload];
        }
        
    }];
}

- (void)ba_reload
{
    [self.webView ba_web_reload];
    //    [self changeNavigatorUserAgent];
}

- (void)ba_web_progressShow
{
    // 开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    // 开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    // 防止progressView被网页挡住
    [self.navigationController.view bringSubviewToFront:self.progressView];
}

- (void)ba_web_progressHidder
{
    /*
     *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
     *动画时长0.25s，延时0.3s后开始动画
     *动画结束后将progressView隐藏
     */
    [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
    } completion:^(BOOL finished) {
        self.progressView.hidden = YES;
        
    }];
}

/**
 *  加载一个 webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *)request
{
    [self.webView ba_web_loadRequest:request];
}

/**
 *  加载一个 webview
 *
 *  @param URL 请求的 URL
 */
- (void)ba_web_loadURL:(NSURL *)URL
{
    [self.webView ba_web_loadURL:URL];
}

/**
 *  加载一个 webview
 *
 *  @param URLString 请求的 URLString
 */
- (void)ba_web_loadURLString:(NSString *)URLString
{
    [self.webView ba_web_loadURLString:URLString];
}

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地 HTML 文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName
{
    [self.webView ba_web_loadHTMLFileName:htmlName];
}

/**
 *  加载本地 htmlString
 *
 *  @param htmlString 请求的本地 htmlString
 */
- (void)ba_web_loadHTMLString:(NSString *)htmlString
{
    [self.webView ba_web_loadHTMLString:htmlString];
}

/**
 *  加载 js 字符串，例如：高度自适应获取代码：
 // webView 高度自适应
 [self ba_web_stringByEvaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
 // 获取页面高度，并重置 webview 的 frame
 self.ba_web_currentHeight = [result doubleValue];
 CGRect frame = webView.frame;
 frame.size.height = self.ba_web_currentHeight;
 webView.frame = frame;
 }];
 *
 *  @param javaScriptString js 字符串
 */
- (void)ba_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler
{
    [self.webView ba_web_stringByEvaluateJavaScript:javaScriptString completionHandler:completionHandler];
}

#pragma mark - custom Method
/*
#pragma mark 导航栏的返回按钮
- (void)configBackItem:(NSString *)leftImageName
{
    UIImage *backImage = [UIImage imageNamed:leftImageName];
    backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *backBtn = [[UIButton alloc] init];
    //    [backBtn setTintColor:Baal_ColorOrange];
    [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn sizeToFit];
    
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = colseItem;
}

#pragma mark 导航栏的右侧按钮
- (void)configRightItem:(NSString *)rightImageName
{
    // navigationbar_more
    UIImage *rightImage = [UIImage imageNamed:rightImageName];
    rightImage = [rightImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *rightImageBtn = [[UIButton alloc] init];
    //    [menuBtn setTintColor:Baal_ColorOrange];
    [rightImageBtn setImage:rightImage forState:UIControlStateNormal];
    [rightImageBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightImageBtn sizeToFit];
    
    UIBarButtonItem *rightImageItem = [[UIBarButtonItem alloc] initWithCustomView:rightImageBtn];
    self.navigationItem.rightBarButtonItem = rightImageItem;
}


#pragma mark - 按钮点击事件
#pragma mark 返回按钮点击
- (void)backBtnAction:(UIButton *)sender
{
    if (self.webView.ba_web_canGoBack)
    {
        [self.webView ba_web_goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark 右侧按钮点击
- (void)rightBtnAction:(UIButton *)sender
{
    
}
*/


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect webViewRect;
    CGRect progressViewRect = CGRectMake(0, Baal_getNavBarHeight(), Baal_SCREEN_WIDTH, 20);
    if(self.navigationController.navigationBarHidden) {
        webViewRect = CGRectMake(0, Baal_getNavBarHeight(), Baal_SCREEN_WIDTH, Baal_SCREEN_HEIGHT-Baal_getNavBarHeight());
    } else {
        webViewRect = CGRectMake(0, 0, Baal_SCREEN_WIDTH, Baal_SCREEN_HEIGHT);
    }
    self.webView.frame = webViewRect;
    self.progressView.frame = progressViewRect;
}

#pragma mark - setter / getter

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:self.webConfig];
        //  添加 WKWebView 的代理，注意：用此方法添加代理
        Baal_WeakSelf
        [self.webView ba_web_initWithDelegate:weak_self.webView uIDelegate:weak_self.webView];
        _webView.ba_web_isAutoHeight = NO;
        self.webView.multipleTouchEnabled = YES;
        self.webView.autoresizesSubviews = YES;
        //        self.wkWebView.scrollView.alwaysBounceVertical = YES;
        
        [self.view addSubview:self.webView];
        
        //        [self changeNavigatorUserAgent];
    }
    return _webView;
}

- (WKWebViewConfiguration *)webConfig
{
    if (!_webConfig) {
        
        // 创建并配置WKWebView的相关参数
        // 1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
        // 2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
        // 3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
        
        _webConfig = [[WKWebViewConfiguration alloc] init];
        _webConfig.allowsInlineMediaPlayback = YES;
        
        //        _webConfig.allowsPictureInPictureMediaPlayback = YES;
        
        // 通过 JS 与 webView 内容交互
        // 注入 JS 对象名称 senderModel，当 JS 通过 senderModel 来调用时，我们可以在WKScriptMessageHandler 代理中接收到
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        //        [userContentController addScriptMessageHandler:self name:@"BAShare"];
        _webConfig.userContentController = userContentController;
        
        // 初始化偏好设置属性：preferences
//        _webConfig.preferences = [WKPreferences new];
        // The minimum font size in points default is 0;
//        _webConfig.preferences.minimumFontSize = 40;
        // 是否支持 JavaScript
        _webConfig.preferences.javaScriptEnabled = YES;
        // 不通过用户交互，是否可以打开窗口
        _webConfig.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    }
    return _webConfig;
}

- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        _progressView = [UIProgressView new];
        _progressView.tintColor = Baal_Color_Orange_pod;
        _progressView.trackTintColor = Baal_Color_Gray_8_pod;
        
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        
        [self.view addSubview:_progressView];
    }
    return _progressView;
}

- (void)setBa_web_progressTintColor:(UIColor *)ba_web_progressTintColor
{
    _ba_web_progressTintColor = ba_web_progressTintColor;
    
    self.progressView.progressTintColor = ba_web_progressTintColor;
}

- (void)setBa_web_progressTrackTintColor:(UIColor *)ba_web_progressTrackTintColor
{
    _ba_web_progressTrackTintColor = ba_web_progressTrackTintColor;
    
    self.progressView.trackTintColor = ba_web_progressTrackTintColor;
}

- (void)dealloc
{
    [self.webView removeFromSuperview];
    [self.progressView removeFromSuperview];
    self.webView = nil;
    self.webConfig = nil;
    self.progressView = nil;
    self.ba_web_currentUrl = nil;
}

- (BOOL)willDealloc
{
    return NO;
}


// name:block,name1:block1
- (void)ba_scriptMessageHandler:(NSMutableDictionary<NSString *,Baal_webView_userContentControllerDidReceiveScriptMessageBlock> *)messageNameScripts 
{
    [self.webView ba_web_addScriptMessageHandlerWithNameArray:[messageNameScripts allKeys]];
    self.webView.ba_web_userContentControllerDidReceiveScriptMessageBlock = ^(WKUserContentController * _Nonnull userContentController, WKScriptMessage * _Nonnull message) {
        Baal_moduleMethodBlock receiveScriptMessageBlock = [messageNameScripts valueForKey:message.name];
        if (receiveScriptMessageBlock) {
            receiveScriptMessageBlock(userContentController,message);

        }
    };
}





// 封装weex-h5 module
- (NSString *)weexHtmlHybridModules:(NSArray *)modules andWeexHtmlJs:(NSString *)url
{
    NSString *nativeHybrid = @"        <script>\n            var nativeHybrid = {}\n            if (weex.config.env.platform === 'Web') {\n                window.NativeHybrid = nativeHybrid\n                if (window.Vue) {\n                    window.Vue.use(nativeHybrid)\n                }\n            }\n        </script>\n        \n    \n";
    NSMutableString *weexhtmlModule = [NSMutableString string];
    [modules enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *weexhtmlMethod = [NSMutableString string];
        for (int i = 0;i<[obj[@"moduleMethod"] count];i++) {
            
            [weexhtmlMethod appendFormat:@"\n                                        %@ (params, callback) {\n                                          webkit.messageHandlers.%@.postMessage(params,callback);\n                                            nativeHybrid.%@ = function(data) {\n                                                callback(data);\n                                             }\n                                       },\n",obj[@"moduleMethod"][i],obj[@"moduleMethod"][i],obj[@"moduleMethod"][i]];
        }
        [weexhtmlModule appendFormat:@"\n<script>\n            %@ = {\n                init: function (weex) {\n                    weex.registerModule('%@', {%@                                        })\n                }\n            }\n        weex.install(%@);\n        </script>\n",obj[@"moduleName"],obj[@"moduleName"],weexhtmlMethod,obj[@"moduleName"]];
        weexhtmlMethod = nil;
        
    }];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *weexhtml = [NSString stringWithFormat:@"<!DOCTYPE html>\n<html>\n    <head>\n        <meta charset=\"utf-8\">\n            <title>%@</title>\n            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no\">\n                <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\n                    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\n                        <meta name=\"apple-touch-fullscreen\" content=\"yes\">\n                            <meta name=\"format-detection\" content=\"telephone=no, email=no\">\n                                <style>body::before { content: \"1\"; height: 0px; overflow: hidden; color: transparent; display: block; }body{margin:0;padding:0}</style>\n                                <script src=\"http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/vue/vue.min.js\"></script>\n                                <script src=\"http://prodwbbucket.oss-cn-hangzhou.aliyuncs.com/weex/rider/node_modules/weex-vue-render/index.min.js\"></script>\n    </head>    <body>\n        <div id=\"root\"></div>\n        %@%@\n        <script src=\"%@\"></script>\n    </body>\n</html>\n",app_Name?app_Name:@"baal",weexhtmlModule,nativeHybrid,url];
    return weexhtml;
}

- (void)ba_web_loadHtmlWithModules:(NSArray *)modules andWeexHtmlJs:(NSString *)url
{
    NSMutableDictionary *callHandler = [NSMutableDictionary dictionary];
    NSMutableArray *modulesArray = [NSMutableArray array];
    for (NSDictionary *module in modules) {
        [callHandler addEntriesFromDictionary:module[@"moduleMethod"]];
        NSDictionary *moduleDict = @{@"moduleName":module[@"moduleName"],@"moduleMethod":[module[@"moduleMethod"] allKeys]};
        [modulesArray addObject:moduleDict];
    }
    [self ba_scriptMessageHandler:callHandler];
    [self ba_web_loadHTMLString:[self weexHtmlHybridModules:modulesArray andWeexHtmlJs:url]];
}

//- (void)ba_web_callJs:(NSString *)method andData:(NSDictionary *)data
//{
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *paramsJson = nil;
//    if (error) {
//        paramsJson = @"";
//    } else {
//        paramsJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//    NSString *jsmethod = [method stringByAppendingString:@"()"];
//    if ([data isKindOfClass:[NSString class]]){
//        jsmethod = [NSString stringWithFormat:@"%@('%@')",method,data];
//    }
//    [self.webView ba_web_stringByEvaluateJavaScript:jsmethod completionHandler:^(id  _Nullable result, NSError * _Nullable error) {
//        
//    }];
//}


- (void)ba_web_loadHtmlWithModulesAndUrl:(NSString *)weexHtmlJs
{
    BaalWeexOrHtmlHandlerImpl<BaalWeexOrHtmlHandlerProtocol> *impl = [BaalHandlerFactory handlerForProtocol:@protocol(BaalWeexOrHtmlHandlerProtocol)];
    NSArray *modules = [impl ba_web_registerModules:self.webView andWeexParams:nil andCallback:nil];
    [self ba_web_loadHtmlWithModules:modules andWeexHtmlJs:weexHtmlJs];
}

@end
