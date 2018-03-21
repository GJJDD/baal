//
//  UIViewController+BaalBase.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BaalBase)
@property (nonatomic, copy) NSString *pageId;
@property (nonatomic, strong) NSDictionary *params;

@end
