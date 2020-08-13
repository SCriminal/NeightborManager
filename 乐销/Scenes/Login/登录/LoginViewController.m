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
@property (nonatomic, strong) LoginCodeView *codeView;
@property (nonatomic, strong) UIView *viewClick;

@end

@implementation LoginViewController
- (UIView *)viewClick{
    if (!_viewClick) {
        _viewClick = [UIView new];
        _viewClick.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _viewClick.backgroundColor = [UIColor whiteColor];
        [_viewClick addTarget:self action:@selector(hideKeyboard)];
    }
    return _viewClick;
}

- (LoginCodeView *)codeView{
    if (!_codeView) {
        _codeView = [LoginCodeView new];
        _codeView.top = self.titleView.bottom + W(50);
        _codeView.hidden = true;
        WEAKSELF
        _codeView.blockLoginClick = ^{
            [weakSelf requestCodeLogin];
        };
        _codeView.blockSendCodeClick = ^{
            [weakSelf requestSendCode];
        };
    }
    return _codeView;
}
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
        WEAKSELF
        _bottomView.blockClick = ^(ENUM_LOGIN_BTN_TYPE type) {
            switch (type) {
                case ENUM_LOGIN_BTN_PWD:
                {
                    weakSelf.pwdView.hidden = false;
                    weakSelf.codeView.hidden = true;
                }
                    break;
                case ENUM_LOGIN_BTN_CODE:
                {
                    weakSelf.pwdView.hidden = true;
                    weakSelf.codeView.hidden = false;
                }
                    break;
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
    [self.view addSubview:self.viewClick];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.pwdView];
    [self.view addSubview:self.codeView];
    [self addObserveOfKeyboard];
     
    
}
- (void)hideKeyboard{
    [GlobalMethod hideKeyboard];
}
//

#pragma mark request
- (void)requestSendCode{
    NSString * strPhone = [self.codeView.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (!isPhoneNum(strPhone)) {
        [GlobalMethod showAlert:@"请输入有效手机号"];
        return;
    }

    [RequestApi requestSendCodeWithCellPhone:strPhone smsType:3 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self.codeView timerStart];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}


- (void)requestCodeLogin{
    NSString * strPhone = [self.codeView.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (!isPhoneNum(strPhone)) {
        [GlobalMethod showAlert:@"请输入有效手机号"];
        return;
    }
    if (self.codeView.tfSecond.text.length == 0) {
        [GlobalMethod showAlert:@"请输入验证码"];
        return;
    }

    [RequestApi requestLoginWithCode:self.codeView.tfSecond.text cellPhone:strPhone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        //保存手机号
        [GlobalMethod writeStr:strPhone forKey:LOCAL_PHONE exchange:false];
    
        
        [GB_Nav popToRootViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestLoginWithPwd{
    NSString * strPhone = [self.pwdView.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (!isPhoneNum(strPhone)) {
        [GlobalMethod showAlert:@"请输入有效手机号"];
        return;
    }
    if (self.pwdView.tfSecond.text.length == 0) {
        [GlobalMethod showAlert:@"请输入密码"];
        return;
    }

    [RequestApi requestLoginWithAccount:strPhone password:self.pwdView.tfSecond.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod writeStr:strPhone forKey:LOCAL_PHONE exchange:false];
        [GlobalMethod createRootNav];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
