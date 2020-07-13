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
        //        [weakSelf.view addSubview:[CallingView new]];
        TopAlertView * top = [TopAlertView sharedInstance];
        top.model = ^(){
            ModelApns * modelAp = [ModelApns new];
            modelAp.type = 11;
            ModelRTC * model = [ModelRTC new];
            model.appID = @"phhs6mt3";
            model.userId = @"4";
            model.channelId = @"2";
            model.nonce = @"AK-470f12b0-2597-46fa-a47d-cec564986f58";
            model.timeStamp = @"1594689816";
            model.token = @"08556d8cff08a0fc3ed3f122279914dde4c60ed4ccdb1c33d317dc796ccf9256";
            model.gSLB = @[@"https://rgslb.rtc.aliyuncs.com"];
            modelAp.rtc = model;
            return modelAp;
        }();
        [top btnClick];
    }]];

    return;
}

@end



