//
//  BaalRoute.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/27.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalRoute.h"

@implementation BaalRoute

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)provinceWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
    
}

@end
