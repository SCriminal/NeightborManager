//
//  TestVC.m
//  中车运 wreck
//  Created by 隋林栋 on 2016/12/22.
//  Copyright © 2016年 ping. All rights reserved.
//


/*
 
 */
#import "TestVC.h"
#import "TopAlertView.h"
//request
#import "RequestApi+Neighbor.h"
#import "CallingView.h"
@interface TestVC ()<UIWebViewDelegate,NSURLSessionDelegate>

@property (nonatomic, strong) UIWebView *web;
@property (nonatomic, strong) UILabel *labelShow;

@end

@implementation TestVC

- (UIWebView *)web{
    if (!_web) {
        _web = [UIWebView new];
        _web.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _web.delegate = self;
    }
    return _web;
}
- (UILabel *)labelShow{
    if (!_labelShow) {
        _labelShow = [UILabel new];
        _labelShow.fontNum = F(16);
        _labelShow.textColor = [UIColor blackColor];
        _labelShow.backgroundColor = [UIColor whiteColor];
        _labelShow.numberOfLines = 0;
    }
    return _labelShow;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"1" rightTitle:@"2" rightBlock:^{
        [[CallingView sharedInstance]playAudio];
    }]];

    return;
}

@end



