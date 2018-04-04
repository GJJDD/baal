//
//  BaalHandlerFactory.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/16.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WeexSDK/WeexSDK.h>
@interface BaalHandlerFactory : NSObject

/**
 * @abstract Register a handler for a given handler instance and specific protocol
 *
 * @param handler The handler instance to register
 *
 * @param protocol The protocol to confirm
 *
 */
+ (void)registerHandler:(id)handler withProtocol:(Protocol *)protocol;

/**
 * @abstract Returns the handler for a given protocol
 *
 **/
+ (id)handlerForProtocol:(Protocol *)protocol;

/**
 * @abstract Returns the registered handlers.
 */
+ (NSDictionary *)handlerConfigs;

+ (void)weexModuleParams:(NSString *)params callback:(WXModuleKeepAliveCallback)callback;
@end
