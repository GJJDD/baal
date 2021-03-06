#ifndef Baal_ConfigurationDefine_h
#define Baal_ConfigurationDefine_h


#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

#pragma mark - weak / strong
#define Baal_WeakSelf        @Baal_Weakify(self);
#define Baal_StrongSelf      @Baal_Strongify(self);

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@Baal_Weakify`实现弱引用转换，`@Baal_Strongify`实现强引用转换
 *
 * 示例：
 * @Baal_Weakify
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef Baal_Weakify
#if DEBUG
#if __has_feature(objc_arc)
#define Baal_Weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define Baal_Weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define Baal_Weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define Baal_Weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@Baal_Weakify(object)`实现弱引用转换，`@Baal_Strongify(object)`实现强引用转换
 *
 * 示例：
 * @Baal_Weakify(object)
 * [obj block:^{
 * @Baal_Strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef Baal_Strongify
#if DEBUG
#if __has_feature(objc_arc)
#define Baal_Strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define Baal_Strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define Baal_Strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define Baal_Strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/*! 获取sharedApplication */
#define Baal_SharedApplication    [UIApplication sharedApplication]

// 操作系统版本号
#define Baal_IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

/*! 主线程同步队列 */
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
/*! 主线程异步队列 */
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


#pragma mark - runtime
#import <objc/runtime.h>
/*! runtime set */
#define Baal_Objc_setObj(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC)

/*! runtime setCopy */
#define Baal_Objc_setObjCOPY(key, value) objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY)

/*! runtime get */
#define Baal_Objc_getObj objc_getAssociatedObject(self, _cmd)

/*! runtime exchangeMethod */
#define Baal_Objc_exchangeMethodAToB(originalSelector,swizzledSelector) { \
Method originalMethod = class_getInstanceMethod(self, originalSelector); \
Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector); \
if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) { \
class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)); \
} else { \
method_exchangeImplementations(originalMethod, swizzledMethod); \
} \
}

#pragma mark - 简单警告框
/*! view 用 Baal_ShowAlertWithMsg */
#define Baal_ShowAlertWithMsg(msg) [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:(msg) delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil] show];
/*! VC 用 Baal_ShowAlertWithMsg */
#define Baal_ShowAlertWithMsg_ios8(msg) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];

#pragma mark - color
CG_INLINE UIColor *
Baal_Color_RGBA_pod(u_char r,u_char g, u_char b, u_char a) {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];
}

CG_INLINE UIColor *
Baal_Color_RGB_pod(u_char r,u_char g, u_char b) {
    return Baal_Color_RGBA_pod(r, g, b, 1.0);
}

CG_INLINE UIColor *
Baal_Color_RGBValue_pod(UInt32 rgbValue){
    return [UIColor colorWithRed:((rgbValue & 0xff0000) >> 16) / 255.0f
                           green:((rgbValue & 0xff00) >> 8) / 255.0f
                            blue:(rgbValue  & 0xff) / 255.0f
                           alpha:1.0f];
}

CG_INLINE UIColor *
Baal_Color_RGBAValue_pod(UInt32 rgbaValue){
    return [UIColor colorWithRed:((rgbaValue & 0xff000000) >> 24) / 255.0f
                           green:((rgbaValue & 0xff0000) >> 16) / 255.0f
                            blue:((rgbaValue & 0xff00) >> 8) / 255.0f
                           alpha:(rgbaValue  & 0xff) / 255.0f];
}

CG_INLINE UIColor *
Baal_Color_RandomRGB_pod(){
    return Baal_Color_RGBValue_pod(arc4random_uniform(0xffffff));
}

CG_INLINE UIColor *
Baal_Color_RandomRGBA_pod(){
    return Baal_Color_RGBAValue_pod(arc4random_uniform(0xffffffff));
}


#define Baal_Color_Translucent_pod    [UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:0.5f]
#define Baal_Color_White_pod          [UIColor whiteColor]
#define Baal_Color_Clear_pod          [UIColor clearColor]
#define Baal_Color_Black_pod          [UIColor blackColor]
#define Baal_Color_White_pod          [UIColor whiteColor]
#define Baal_Color_Red_pod            [UIColor redColor]
#define Baal_Color_Green_pod          [UIColor greenColor]
#define Baal_Color_Orange_pod         [UIColor orangeColor]
#define Baal_Color_Yellow_pod         [UIColor yellowColor]


/*! 灰色 */
#define Baal_Color_Gray_1_pod  Baal_Color_RGB_pod(53, 60, 70)
#define Baal_Color_Gray_2_pod  Baal_Color_RGB_pod(73, 80, 90)
#define Baal_Color_Gray_3_pod  Baal_Color_RGB_pod(93, 100, 110)
#define Baal_Color_Gray_4_pod  Baal_Color_RGB_pod(113, 120, 130)
#define Baal_Color_Gray_5_pod  Baal_Color_RGB_pod(133, 140, 150)
#define Baal_Color_Gray_6_pod  Baal_Color_RGB_pod(153, 160, 170)
#define Baal_Color_Gray_7_pod  Baal_Color_RGB_pod(173, 180, 190)
#define Baal_Color_Gray_8_pod  Baal_Color_RGB_pod(196, 200, 208)
#define Baal_Color_Gray_9_pod  Baal_Color_RGB_pod(216, 220, 228)
#define Baal_Color_Gray_10_pod Baal_Color_RGB_pod(240, 240, 240)
#define Baal_Color_Gray_11_pod Baal_Color_RGB_pod(248, 248, 248)

#pragma mark - Margin
#define Baal_Margin_1_pod       Baal_Flat_pod(1)
#define Baal_Margin_2_pod       Baal_Flat_pod(2)
#define Baal_Margin_5_pod       Baal_Flat_pod(5)
#define Baal_Margin_10_pod      Baal_Flat_pod(10)
#define Baal_Margin_15_pod      Baal_Flat_pod(15)
#define Baal_Margin_20_pod      Baal_Flat_pod(20)
#define Baal_Margin_25_pod      Baal_Flat_pod(25)
#define Baal_Margin_30_pod      Baal_Flat_pod(30)
#define Baal_Margin_35_pod      Baal_Flat_pod(35)
#define Baal_Margin_40_pod      Baal_Flat_pod(40)
#define Baal_Margin_44_pod      Baal_Flat_pod(44)
#define Baal_Margin_50_pod      Baal_Flat_pod(50)
#define Baal_Margin_100_pod     Baal_Flat_pod(100)
#define Baal_Margin_150_pod     Baal_Flat_pod(150)


#define Baal_ImageName(imageName) [UIImage imageNamed:imageName]

#pragma mark - NotiCenter other
#define Baal_NotiCenter [NSNotificationCenter defaultCenter]

#define Baal_NSUserDefaults [NSUserDefaults standardUserDefaults]

/*! 获取sharedApplication */
#define Baal_SharedApplication    [UIApplication sharedApplication]

/*! 用safari打开URL */
#define Baal_OpenUrl(urlStr)      [Baal_SharedApplication openURL:[NSURL URLWithString:urlStr]]

/*! 复制文字内容 */
#define Baal_CopyContent(content) [[UIPasteboard generalPasteboard] setString:content]


/*!
 *  获取屏幕宽度和高度
 */
#define Baal_SCREEN_WIDTH ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define Baal_SCREEN_HEIGHT ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define Baal_BaseScreenWidth   320.0f
#define Baal_BaseScreenHeight  568.0f

/*! 屏幕适配（5S标准屏幕：320 * 568） */
// iPhone 7 屏幕：375 * 667
//376/320 =
//667/568 =
#define Baal_ScaleXAndWidth    Baal_SCREEN_WIDTH/Baal_BaseScreenWidth
#define Baal_ScaleYAndHeight   Baal_SCREEN_HEIGHT/Baal_BaseScreenHeight

#define Baal_ScreenScale ([[UIScreen mainScreen] scale])

CG_INLINE BOOL
Baal_stringIsBlank_pod(NSString *string) {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < string.length; ++i) {
        unichar c = [string characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
Baal_FlatSpecificScale_pod(CGFloat floatValue, CGFloat scale) {
    scale = scale == 0 ? Baal_ScreenScale : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
Baal_Flat_pod(CGFloat floatValue) {
    return Baal_FlatSpecificScale_pod(floatValue, 0);
}

/// 将一个CGSize像素对齐
CG_INLINE CGSize
Baal_CGSizeFlatted_pod(CGSize size) {
    return CGSizeMake(Baal_Flat_pod(size.width), Baal_Flat_pod(size.height));
}

/// 创建一个像素对齐的CGRect
CG_INLINE CGRect
Baal_CGRectFlatMake_pod(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return CGRectMake(Baal_Flat_pod(x), Baal_Flat_pod(y), Baal_Flat_pod(width), Baal_Flat_pod(height));
}

/**
 计算列数【根据 array.count、每行多少个 item，计算列数】
 
 @param array array
 @param rowCount 每行多少个 item
 @return 列数
 */
CG_INLINE NSInteger
Baal_getColumnCountWithArrayAndRowCount_pod(NSArray *array, NSInteger rowCount){
    NSUInteger count = array.count;
    
    NSUInteger i = 0;
    if (count % rowCount == 0)
    {
        i = count / rowCount;
    }
    else
    {
        i = count / rowCount + 1;
    }
    return i;
}

CG_INLINE NSInteger Baal_getNavBarHeight() {
    CGSize result = [[UIScreen mainScreen] currentMode].size;
    CGFloat scale = [UIScreen mainScreen].scale;
    result = CGSizeMake(result.width * scale, result.height * scale);
    if(result.height >= 7308) {
        return 88;
    } else {
        return 64;
    }
}


CG_INLINE NSString * ba_web_callJs(NSString *method, NSDictionary *data)
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    NSString *paramsJson = nil;
    if (error) {
        paramsJson = @"";
    } else {
        paramsJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSString *jsmethod = [method stringByAppendingString:@"()"];
    if ([paramsJson isKindOfClass:[NSString class]]){
        jsmethod = [NSString stringWithFormat:@"%@(%@)",method,paramsJson];
    }
    return jsmethod;
}

CG_INLINE NSDictionary * dictionaryToJson(NSString *json){
    if (![json isKindOfClass:[NSString class]]) {
        return NULL;
    }
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    if (err) {
        return NULL;
    }
    return dict;
}

CG_INLINE NSMutableDictionary* ba_getURLParameters(NSString *url) {
    NSRange range = [url rangeOfString:@"?"];
    if(range.location==NSNotFound) {
        return nil;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *parametersString = [url substringFromIndex:range.location+1];
    if([parametersString containsString:@"&"]) {
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];
        for(NSString *keyValuePair in urlComponents) {
            //生成key/value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString*value = [pairComponents.lastObject stringByRemovingPercentEncoding];
            //key不能为nil
            if(key==nil|| value ==nil) {
                continue;
            }
            id existValue = [params valueForKey:key];
            if(existValue !=nil) {
                //已存在的值，生成数组。
                if([existValue isKindOfClass:[NSArray class]]) {
                    //已存在的值生成数组
                    NSMutableArray*items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];
                    [params setValue:items forKey:key];
                }else{
                    //非数组
                    [params setValue:@[existValue,value]forKey:key];
                }
            }else{
                //设置值
                [params setValue:value forKey:key];
            }
        }
    }else{
        //单个参数生成key/value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];
        if(pairComponents.count==1) {
            return nil;
        }
        //分隔值
        NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];
        //key不能为nil
        if(key ==nil|| value ==nil) {
            return nil;
        }
        //设置值
        [params setValue:value forKey:key];
    }
    return params;
}

CG_INLINE NSString* baal_encodeUrl(NSString *url) {
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    return encodeUrl;
}
#import <WebKit/WebKit.h>
typedef void (^Baal_moduleMethodBlock)(WKUserContentController *userContentController, WKScriptMessage *message);

#endif /* Baal_ConfigurationDefine_h */
