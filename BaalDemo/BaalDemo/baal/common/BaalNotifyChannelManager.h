//
//  NotifyChannelManager.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^BaalNotifyChannelCallback)(id _Nullable result, BOOL keepAlive);

@interface BaalNotifyChannel : NSObject
@property (nonatomic, copy) NSString * _Nonnull pointAddress;
@property (nonatomic, copy) BaalNotifyChannelCallback _Nonnull callback;
@end;
@interface BaalNotifyChannelManager : NSObject
+ (instancetype _Nonnull)shared;

- (void)registerMessage:(NSString * _Nonnull)message andMessageChannelCallback:(BaalNotifyChannelCallback _Nonnull)notifyChannelCallback andPointAddress:(NSString * _Nonnull)pointAddress;
- (void)unregisterMessage:(NSString * _Nonnull)message;
- (void)unregisterPointAddress:(NSString * _Nonnull)pointAddress;
- (void)unregisterMessage:(NSString * _Nonnull)message andPointAddress:(NSString * _Nonnull)pointAddress;
- (void)postMessage:(NSString * _Nonnull)message andData: (id _Nonnull)data;
@end
