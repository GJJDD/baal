//
//  UIViewController+BaalBase.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BaalBase)
@property (nonatomic, copy) NSString *pageName;
@property (nonatomic, strong) NSDictionary *params;
// 判断是否是当前的页面
- (BOOL)currentPage:(NSString *)name;
@end
