//
//  BaalRouteHandlerImpl.m
//  BaalDemo
//
//  Created by dianwoda on 2018/4/3.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "BaalRouteHandlerDefaultImpl.h"

@implementation BaalRouteHandlerDefaultImpl


- (NSDictionary *)routeConfig
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"routeConfig" ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end
