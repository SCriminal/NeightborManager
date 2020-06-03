//
//  ForgetPwdVC.m
//中车运
//
//  Created by mengxi on 16/11/18.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "ForgetPwdVC.h"
#import "SectionTitleView.h"
//bottomview
#import "LoginBottomView.h"
#import "LoginView.h"
//request
#import "RequestApi+Neighbor.h"

@interface ForgetPwdVC ()
@property (nonatomic, strong) SectionTitleView *titleView;
@property (nonatomic, strong) LoginForgetView *forgetView;

@end

@implementation ForgetPwdVC

- (LoginForgetView *)forgetView{
    if (!_forgetView) {
        _forgetView = [LoginForgetView new];
        _forgetView.top = self.titleView.bottom + W(50);
        WEAKSELF
        _forgetView.blockSendCodeClick = ^{
            [weakSelf requestResetPwdSendCode];
        };
        _forgetView.blockResetClick = ^{
            [weakSelf requestResetPwd];
        };
    }
    return _forgetView;
}
- (SectionTitleView *)titleView{
    if (!_titleView) {
        _titleView = [SectionTitleView new];
        [_titleView resetWithBigTitle:@"重置登录"];
        _titleView.top = NAVIGATIONBAR_HEIGHT + W(21);
    }
    return _titleView;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    [self addNav];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.forgetView];
    [self addObserveOfKeyboard];
}

- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"" rightView:nil]];
    
}
//

#pragma mark request

- (void)requestResetPwdSendCode{
    if (self.forgetView.tfPhone.text.length == 0) {
        [GlobalMethod showAlert:@"请输入手机号"];
        return;
    }
    NSString * strPhone = [self.forgetView.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [RequestApi requestSendForgetCodeAccount:strPhone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.forgetView timerStart];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)requestResetPwd{
    if (self.forgetView.tfPhone.text.length == 0) {
        [GlobalMethod showAlert:@"请输入手机号"];
        return;
    }
    if (self.forgetView.tfSecond.text.length == 0) {
        [GlobalMethod showAlert:@"请输入验证码"];
        return;
    }
    if (self.forgetView.tfThird.text.length == 0) {
        [GlobalMethod showAlert:@"请输入新密码"];
        return;
    }
    NSString * strPhone = [self.forgetView.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [RequestApi requestResetPwdWithAccount:strPhone password:self.forgetView.tfThird.text smsCode:self.forgetView.tfSecond.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"更改成功，请重新登录"];
        self.forgetView.tfSecond.text = @"";
        self.forgetView.tfThird.text = @"";
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
