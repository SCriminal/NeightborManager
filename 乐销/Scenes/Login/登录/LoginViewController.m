//
//  LoginViewController.m
//中车运
//
//  Created by mengxi on 16/11/18.
//  Copyright © 2016年 ping. All rights reserved.
//

#import "LoginViewController.h"
#import "SectionTitleView.h"
//bottomview
#import "LoginBottomView.h"
#import "LoginView.h"
//request
#import "RequestApi+Neighbor.h"

@interface LoginViewController ()
@property (nonatomic, strong) SectionTitleView *titleView;
@property (nonatomic, strong) LoginBottomView *bottomView;
@property (nonatomic, strong) LoginPwdView *pwdView;

@end

@implementation LoginViewController

- (LoginPwdView *)pwdView{
    if (!_pwdView) {
        _pwdView = [LoginPwdView new];
        _pwdView.top = self.titleView.bottom + W(50);
        _pwdView.hidden = false;
        WEAKSELF
        _pwdView.blockLoginClick = ^{
            [weakSelf requestLoginWithPwd];
        };
    }
    return _pwdView;
}
- (SectionTitleView *)titleView{
    if (!_titleView) {
        _titleView = [SectionTitleView new];
        [_titleView resetWithBigTitle:@"账号登录"];
        _titleView.top = NAVIGATIONBAR_HEIGHT + W(21);
    }
    return _titleView;
}
- (LoginBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [LoginBottomView new];
//        WEAKSELF
        _bottomView.blockClick = ^(ENUM_LOGIN_BTN_TYPE type) {
            switch (type) {
              
                case ENUM_LOGIN_BTN_FORGET:
                {
                    [GB_Nav pushVCName:@"ForgetPwdVC" animated:true];
                }
                    break;
                case ENUM_LOGIN_BTN_WECHAT:
                {
                }
                    break;
                default:
                    break;
            }
        };
        _bottomView.bottom = SCREEN_HEIGHT - iphoneXBottomInterval - W(70);
    }
    return _bottomView;
}
#pragma mark view did load
- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.pwdView];
    [self addObserveOfKeyboard];
     
    [self.view addTarget:self action:@selector(hideKeyboard)];
    
}

- (void)hideKeyboard{
    [GlobalMethod hideKeyboard];
}

//

#pragma mark request

- (void)requestLoginWithPwd{
    if (self.pwdView.tfPhone.text.length == 0) {
        [GlobalMethod showAlert:@"请输入手机号"];
        return;
    }
    if (self.pwdView.tfSecond.text.length == 0) {
        [GlobalMethod showAlert:@"请输入密码"];
        return;
    }
    NSString * strPhone = [self.pwdView.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    [RequestApi requestLoginWithAccount:strPhone password:self.pwdView.tfSecond.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod writeStr:strPhone forKey:LOCAL_PHONE exchange:false];

        [GB_Nav popToRootViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
