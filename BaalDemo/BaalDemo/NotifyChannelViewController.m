//
//  NotifyChannelViewController.m
//  BaalDemo
//
//  Created by dianwoda on 2018/3/19.
//  Copyright © 2018年 dianwoda. All rights reserved.
//

#import "NotifyChannelViewController.h"
#import "Baal.h"

@interface NotifyChannelViewController ()

@end

@implementation NotifyChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)notifyClick:(UIButton *)sender {
    
    [BaalManager postMessage:@"A" andData:@{@"name":@"123"}];
    
//    NSLog(@"pageName=%@, params=%@", self.pageName, self.params);
}


@end
