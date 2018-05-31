//
//  BaalManager.m
//  BaalDemo
//
//  Created by dianwoda on 2018/4/3.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalManager.h"
#import "BaalHandlerFactory.h"
#import "BaalWeexPluginsManager.h"
@implementation BaalManager

+ (void)registerHandler:(id)handler withProtocol:(Protocol *)protocol
{
    [BaalHandlerFactory registerHandler:handler withProtocol:protocol];
}
+ (void)initBaalEnvironment
{
    [BaalWeexPluginsManager setBaalWeexPlugin];
}





@end
