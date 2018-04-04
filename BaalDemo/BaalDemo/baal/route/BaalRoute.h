//
//  BaalRoute.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/27.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaalRoute : NSObject
@property (nonatomic, copy) NSString *nativeClassName;
@property (nonatomic, copy) NSString *weexjsUrl;
@property (nonatomic, copy) NSString *weexh5jsUrl;
@property (nonatomic, copy) NSString *pageSwitch; // 1:native 2:weexjs 3:weexh5js
- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)provinceWithDictionary:(NSDictionary *)dict;
@end
