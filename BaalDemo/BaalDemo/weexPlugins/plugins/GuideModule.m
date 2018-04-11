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

- (void)greeting:(NSString *)params callback:(WXModuleKeepAliveCallback)callback
{
    [BaalHandlerFactory weexModuleParams:params callback:callback];
}


@end
