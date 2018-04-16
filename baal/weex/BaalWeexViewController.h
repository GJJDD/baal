//
//  BaalWeexViewController.h
//  BaalDemo
//
//  Created by dianwoda on 2018/3/20.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+BaalBase.h"
@interface BaalWeexViewController : UIViewController

- (instancetype)initWithSourceURL:(NSURL *)sourceURL andParams:(NSDictionary *)params;

/**
 * @abstract initializes the viewcontroller with bundle url.
 *
 * @param sourceURL The url of bundle rendered to a weex view.
 *
 * @return a object the class of WXBaseViewController.
 *
 */
- (instancetype)initWithSourceURL:(NSURL *)sourceURL;
/**
 * @abstract refreshes the weex view in controller.
 */
- (void)refreshWeex;


@end
