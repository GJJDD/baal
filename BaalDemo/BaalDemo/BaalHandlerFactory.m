//
//  BaalHandlerFactory.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/16.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalHandlerFactory.h"
#import "BaalHandlerFactory.h"
#import "BaalWeexOrHtmlHandlerImpl.h"
@interface BaalHandlerFactory ()

@property (nonatomic, strong) NSMutableDictionary *handlers;

@end
@implementation BaalHandlerFactory
+ (instancetype)sharedInstance {
    static BaalHandlerFactory* _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
        _sharedInstance.handlers = [[NSMutableDictionary alloc] init];
    });
    return _sharedInstance;
}

+ (void)registerHandler:(id)handler withProtocol:(Protocol *)protocol
{
    [[BaalHandlerFactory sharedInstance].handlers setObject:handler forKey:NSStringFromProtocol(protocol)];
}

+ (id)handlerForProtocol:(Protocol *)protocol
{
    id handler = [[BaalHandlerFactory sharedInstance].handlers objectForKey:NSStringFromProtocol(protocol)];
    return handler;
}

+ (NSDictionary *)handlerConfigs {
    return [BaalHandlerFactory sharedInstance].handlers;
}


+ (void)weexModuleParams:(NSString *)params callback:(WXModuleKeepAliveCallback)callback
{
    
    NSError *err;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[params dataUsingEncoding:NSUTF8StringEncoding]
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
    
    BaalWeexOrHtmlHandlerImpl<BaalWeexOrHtmlHandlerProtocol> *impl = [BaalHandlerFactory handlerForProtocol:@protocol(BaalWeexOrHtmlHandlerProtocol)];
    NSArray *weexModule = [impl ba_web_registerModules:nil andWeexParams:params andCallback:callback];
    [weexModule enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *moduleName = dict[@"moduleName"];
        NSString *method = dict[@"methodName"];
        if ([obj[@"moduleName"] isEqualToString:moduleName]) {
            Baal_moduleMethodBlock block = obj[@"moduleMethod"][method];
            block(NULL, NULL);
        }
    }];
}
@end
