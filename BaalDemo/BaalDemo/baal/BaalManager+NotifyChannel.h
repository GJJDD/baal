//
//  BaalManager+NotifyChannel.h
//  BaalDemo
//
//  Created by dianwoda on 2018/4/3.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalManager.h"
#import "BaalNotifyChannelManager.h"
@interface BaalManager (NotifyChannel)

+ (void)registerMessage:(NSString * _Nonnull)message andMessageChannelCallback:(BaalNotifyChannelCallback _Nonnull)notifyChannelCallback andPagePointAddress:(NSString * _Nonnull)pagepointAddress;
+ (void)unregisterMessage:(NSString * _Nonnull)message;
+ (void)unregisterMessage:(NSString * _Nonnull)message andPagePointAddress:(NSString * _Nonnull)pagePointAddress;
+ (void)postMessage:(NSString * _Nonnull)message andData:(id _Nonnull)data;
@end
