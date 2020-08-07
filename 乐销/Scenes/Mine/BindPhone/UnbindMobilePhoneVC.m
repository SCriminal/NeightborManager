//
//  UnbindMobilePhoneVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "UnbindMobilePhoneVC.h"
#import "BindPhoneView.h"
//request
#import "RequestApi+Neighbor.h"

@interface UnbindMobilePhoneVC ()
@property (nonatomic, strong) BindPhoneTitleView *titleView;
@property (nonatomic, strong) BindPhoneCodeView *codeView;
@property (nonatomic, strong) UIView *viewClick;

@end

@implementation UnbindMobilePhoneVC
- (BindPhoneTitleView *)titleView{
    if (!_titleView) {
        _titleView = [BindPhoneTitleView new];
        [_titleView resetWithBigTitle:@"解绑手机" subTitle:@"解绑后，您的账号可能面临安全风险。您将无法通过手机号找回密码及登录"];
        _titleView.top = NAVIGATIONBAR_HEIGHT + W(21);
    }
    return _titleView;
}
- (BindPhoneCodeView *)codeView{
    if (!_codeView) {
        _codeView = [BindPhoneCodeView new];
        _codeView.top = self.titleView.bottom + W(50);
        [_codeView.btn resetViewWithWidth:W(295) :W(45) :@"解绑"];
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

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.viewClick];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.codeView];
    [self addObserveOfKeyboard];
}
- (void)hideKeyboard{
    [GlobalMethod hideKeyboard];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"" rightView:nil]];
}

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
@end
