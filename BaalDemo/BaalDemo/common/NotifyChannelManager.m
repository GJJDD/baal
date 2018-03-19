//
//  NotifyChannelManager.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "NotifyChannelManager.h"
@implementation NotifyChannel

@end

@interface NotifyChannelManager ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<NotifyChannel *> *> *notifyQueue;
@property (nonatomic, strong) NSLock *notifyQueueLock;
@end


@implementation NotifyChannelManager


+ (instancetype)shared {
    static NotifyChannelManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NotifyChannelManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    @synchronized(self) {
        self = [super init];
        if (self) {
            _notifyQueue = [NSMutableDictionary<NSString *,NSMutableArray<NotifyChannel *> *> dictionary];
            _notifyQueueLock = [[NSLock alloc] init];
         
        }
    }
    return self;
}




- (void)registerMessage:(NSString *)message andMessageChannelCallback:(NotifyChannelCallback)messageChannelCallback andPointAddress:(NSString *)pointAddress
{
    [_notifyQueueLock lock];
    NSMutableArray<NotifyChannel *> *notifyCallbackArray = [self.notifyQueue valueForKey:message];
    if (!notifyCallbackArray) {
        notifyCallbackArray = [NSMutableArray<NotifyChannel *> array];
    }
    NotifyChannel *notifyChannel = [[NotifyChannel alloc] init];
    notifyChannel.callback = messageChannelCallback;
    notifyChannel.pointAddress = pointAddress;
    [notifyCallbackArray addObject:notifyChannel];
    [self.notifyQueue setValue:notifyCallbackArray forKey:message];
    [_notifyQueueLock unlock];
}

- (void)unregisterMessage:(NSString *)message andPointAddress:(NSString *)pointAddress
{
    [_notifyQueueLock lock];
    NSMutableArray<NotifyChannel *> *notifyCallbackArray = [self.notifyQueue valueForKeyPath:message];
    if (!notifyCallbackArray) {
        NSLog(@"未被注册");
        return;
    }
    for (NotifyChannel *notifyChannel in notifyCallbackArray) {
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
    NSMutableArray<NotifyChannel *> *notifyCallbackArray = [self.notifyQueue valueForKeyPath:message];
    
    if (notifyCallbackArray && notifyCallbackArray.count>0) {
        [notifyCallbackArray enumerateObjectsUsingBlock:^(NotifyChannel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.callback(data,true);
        }];
    }
    [_notifyQueueLock unlock];
}

@end
