//
//  BaalManager+NotifyChannel.m
//  BaalDemo
//
//  Created by dianwoda on 2018/4/3.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalManager+NotifyChannel.h"
#import "BaalNotifyChannelManager.h"
@implementation BaalManager (NotifyChannel)


- (void)registerMessage:(NSString * _Nonnull)message andMessageChannelCallback:(BaalNotifyChannelCallback _Nonnull)notifyChannelCallback andPagePointAddress:(NSString * _Nonnull)pagepointAddress
{
    [[BaalNotifyChannelManager shared] registerMessage:message andMessageChannelCallback:notifyChannelCallback andPointAddress:pagepointAddress];
}
- (void)unregisterMessage:(NSString * _Nonnull)message
{
    [[BaalNotifyChannelManager shared] unregisterMessage:message];
}

- (void)unregisterMessage:(NSString * _Nonnull)message andPagePointAddress:(NSString * _Nonnull)pagePointAddress
{
    [[BaalNotifyChannelManager shared] unregisterMessage:message andPointAddress:pagePointAddress];
}
- (void)postMessage:(NSString * _Nonnull)message andData: (id)data
{
    [[BaalNotifyChannelManager shared] postMessage:message andData:data];
}
@end
