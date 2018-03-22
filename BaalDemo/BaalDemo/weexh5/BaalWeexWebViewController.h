//
//  BaalWeexWebViewController.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/7.
//  Copyright © 2018年 dianwoda. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Baal_WebView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaalWeexWebViewController : UIViewController

@property(nonatomic, strong) UIColor * _Nullable ba_web_progressTintColor;
@property(nonatomic, strong) UIColor *ba_web_progressTrackTintColor;

// 在NavigationBarHidden隐藏的情况下是否需要满屏
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
/**
 *  加载一个 webview
 *
 *  @param request 请求的 NSURL URLRequest
 */
- (void)ba_web_loadRequest:(NSURLRequest *)request;

/**
 *  加载一个 webview
 *
 *  @param URL 请求的 URL
 */
- (void)ba_web_loadURL:(NSURL *)URL;

/**
 *  加载一个 webview
 *
 *  @param URLString 请求的 URLString
 */
- (void)ba_web_loadURLString:(NSString *)URLString;

/**
 *  加载本地网页
 *
 *  @param htmlName 请求的本地 HTML 文件名
 */
- (void)ba_web_loadHTMLFileName:(NSString *)htmlName;

/**
 *  加载本地 htmlString
 *
 *  @param htmlString 请求的本地 htmlString
 */
- (void)ba_web_loadHTMLString:(NSString *)htmlString;

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
- (void)ba_web_stringByEvaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))completionHandler;
/**
 * js交互方法注册以及对应实现
 * @param messageNameScripts 注册的消息名称以及对应需要执行的block
 */
- (void)ba_scriptMessageHandler:(NSDictionary<NSString *,Baal_webView_userContentControllerDidReceiveScriptMessageBlock> *)messageNameScripts;
/*
 * 注册扩展以及加载对应的weex-h5 url
 * @param modules 注册的扩展给weex的模块以及对应方法
 * @param url     webpack打包生成的url
 */
- (void)ba_web_loadHtmlWithModules:(NSArray *)modules andWeexHtmlJs:(NSString *)url;

- (void)ba_web_loadHtmlWithModulesAndUrl:(NSString *)weexHtmlJs;
/**
 * 加载weex-h5 url
 * @param url     webpack打包生成的url
 * @param params     需要携带的参数
 */
- (void)ba_web_loadHtmlWithModulesAndUrl:(NSString *)weexHtmlJs andParams:(NSDictionary *)params;
@end
NS_ASSUME_NONNULL_END

