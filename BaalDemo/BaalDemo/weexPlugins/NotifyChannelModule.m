//
//  NotifyChannelModule.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "NotifyChannelModule.h"
#import "NotifyChannelManager.h"
#import "Baal_ConfigurationDefine.h"
@implementation NotifyChannelModule
@synthesize weexInstance;
WX_EXPORT_METHOD(@selector(registerMessage:andMessageChannelCallback:))
WX_EXPORT_METHOD(@selector(unregisterMessage:))
WX_EXPORT_METHOD(@selector(postMessage:))
WX_EXPORT_METHOD(@selector(unregisterMessageCallBack:))

- (void)registerMessage:(nonnull NSString *)params andMessageChannelCallback:(nonnull NotifyChannelCallback)messageChannelCallback
{
    
    NSDictionary *dict = dictionaryToJson(params);
    [[NotifyChannelManager shared] registerMessage:dict[@"params"][@"name"] andMessageChannelCallback:messageChannelCallback andPointAddress:[NSString stringWithFormat:@"%p",weexInstance.viewController]];
}
- (void)unregisterMessage:(nonnull NSString *)params
{
    NSDictionary *dict = dictionaryToJson(params);
    [[NotifyChannelManager shared] unregisterMessage:dict[@"params"][@"name"]];
}


- (void)unregisterMessageCallBack:(NSString * _Nonnull)params
{
    NSDictionary *dict = dictionaryToJson(params);
    [[NotifyChannelManager shared] unregisterMessage:dict[@"params"][@"name"] andPointAddress:[NSString stringWithFormat:@"%p",weexInstance.viewController]];
}


- (void)postMessage:(nonnull NSString *)params
{
    NSDictionary *dict = dictionaryToJson(params);
    [[NotifyChannelManager shared] postMessage:dict[@"params"][@"name"] andData:dict[@"params"][@"messageData"]];
}
@end
