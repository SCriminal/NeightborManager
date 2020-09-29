//
//  TestVC.m
//  中车运 wreck
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//


/*
 
 */
#import "TestVC.h"
#import "NoticeAlertView.h"

@interface TestVC ()

@end

@implementation TestVC

#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"1" rightTitle:@"2" rightBlock:^{
        [weakSelf navClick];
    }]];

    return;
}
- (void)navClick{
    [self.view addSubview:[NoticeAlertView new]];
}
@end



