//
//  NotifyChannelManager.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalNotifyChannelManager.h"
@implementation BaalNotifyChannel

@end

@interface BaalNotifyChannelManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<BaalNotifyChannel *> *> *notifyQueue;
@property (nonatomic, strong) NSLock *notifyQueueLock;
@end


@implementation BaalNotifyChannelManager


+ (instancetype)shared {
    static BaalNotifyChannelManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BaalNotifyChannelManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    @synchronized(self) {
        self = [super init];
        if (self) {
            _notifyQueue = [NSMutableDictionary<NSString *,NSMutableArray<BaalNotifyChannel *> *> dictionary];
            _notifyQueueLock = [[NSLock alloc] init];
         
        }
    }
    return self;
}

- (void)registerMessage:(NSString *)message andMessageChannelCallback:(BaalNotifyChannelCallback)notifyChannelCallback andPointAddress:(NSString *)pointAddress
{
    [_notifyQueueLock lock];
    NSMutableArray<BaalNotifyChannel *> *notifyCallbackArray = [self.notifyQueue valueForKey:message];
    if (!notifyCallbackArray) {
        notifyCallbackArray = [NSMutableArray<BaalNotifyChannel *> array];
    }
    __block Boolean isExist = NO;
    [notifyCallbackArray enumerateObjectsUsingBlock:^(BaalNotifyChannel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.pointAddress isEqualToString:pointAddress]) {
            isExist = YES;
            return;
        }
    }];
    if (!isExist) {
        BaalNotifyChannel *notifyChannel = [[BaalNotifyChannel alloc] init];
        notifyChannel.callback = notifyChannelCallback;
        notifyChannel.pointAddress = pointAddress;
        [notifyCallbackArray addObject:notifyChannel];
        [self.notifyQueue setValue:notifyCallbackArray forKey:message];
    }
    [_notifyQueueLock unlock];
}

- (void)unregisterPointAddress:(NSString *)pointAddress
{
    [_notifyQueueLock lock];
    [self.notifyQueue enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray<BaalNotifyChannel *> * _Nonnull obj, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(BaalNotifyChannel * _Nonnull notifyChannel, NSUInteger idx, BOOL * _Nonnull stop) {
            if([pointAddress isEqualToString:notifyChannel.pointAddress]) {
                [obj removeObject:notifyChannel];
                return;
            }
        }];
    }];
    [_notifyQueueLock unlock];
}



- (void)unregisterMessage:(NSString *)message andPointAddress:(NSString *)pointAddress
{
    [_notifyQueueLock lock];
    NSMutableArray<BaalNotifyChannel *> *notifyCallbackArray = [self.notifyQueue valueForKeyPath:message];
    if (!notifyCallbackArray) {
        NSLog(@"未被注册");
        return;
    }
    for (BaalNotifyChannel *notifyChannel in notifyCallbackArray) {
        if ([notifyChannel.pointAddress isEqualToString:pointAddress]) {
            [notifyCallbackArray removeObject:notifyChannel];
            return;
        }
    }
    [_notifyQueueLock unlock];
}


- (void)unregisterMessage:(NSString *)message
{
    [_notifyQueueLock lock];
    [self.notifyQueue removeObjectForKey:message];
    [_notifyQueueLock unlock];
}


- (void)postMessage:(NSString *)message andData:(id)data
{
    [_notifyQueueLock lock];
    NSMutableArray<BaalNotifyChannel *> *notifyCallbackArray = [self.notifyQueue valueForKeyPath:message];
    
    if (notifyCallbackArray && notifyCallbackArray.count>0) {
        [notifyCallbackArray enumerateObjectsUsingBlock:^(BaalNotifyChannel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.callback(data,true);
        }];
    }
    [_notifyQueueLock unlock];
}

@end
