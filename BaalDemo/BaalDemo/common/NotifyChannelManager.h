//
//  NotifyChannelManager.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^NotifyChannelCallback)(id _Nullable result, BOOL keepAlive);

@interface NotifyChannel : NSObject
@property (nonatomic, copy) NSString *pointAddress;
@property (nonatomic, copy) NotifyChannelCallback callback;
@end;
@interface NotifyChannelManager : NSObject
+ (instancetype _Nonnull)shared;

- (void)registerMessage:(NSString * _Nonnull)message andMessageChannelCallback:(NotifyChannelCallback _Nonnull)messageChannelCallback andPointAddress:(NSString * _Nonnull)pointAddress;
- (void)unregisterMessage:(NSString * _Nonnull)message;
- (void)unregisterMessage:(NSString * _Nonnull)message andPointAddress:(NSString * _Nonnull)pointAddress;
- (void)postMessage:(NSString * _Nonnull)message andData: (id)data;
@end
