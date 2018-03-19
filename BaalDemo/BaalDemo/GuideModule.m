//
//  GuideModule.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "GuideModule.h"
#import "BaalHandlerFactory.h"
#import "BaalWeexOrHtmlHandlerImpl.h"
#import "BaalWeexOrHtmlHandlerProtocol.h"
@implementation GuideModule
WX_EXPORT_METHOD(@selector(greeting:callback:))

- (void)greeting:(NSString *)params callback:(WXModuleCallback)callback
{
    BaalWeexOrHtmlHandlerImpl<BaalWeexOrHtmlHandlerProtocol> *impl = [BaalHandlerFactory handlerForProtocol:@protocol(BaalWeexOrHtmlHandlerProtocol)];
    NSArray *weexModule = [impl ba_web_registerModules:nil andWeexParams:params andCallback:callback];
    [weexModule enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *moduleName = [NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"Module" withString:@""];
        if ([obj[@"moduleName"] isEqualToString:moduleName]) {
            Baal_moduleMethodBlock block = obj[@"moduleMethod"][@"greeting"];
            block(NULL, NULL);
        }
    }];
}


@end
