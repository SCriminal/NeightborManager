//
//  BindMobilePhoneVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "BindMobilePhoneVC.h"
#import "BindPhoneView.h"
//request
#import "RequestApi+Neighbor.h"

@interface BindMobilePhoneVC ()
@property (nonatomic, strong) BindPhoneTitleView *titleView;
@property (nonatomic, strong) BindPhoneCodeView *codeView;
@property (nonatomic, strong) UIView *viewClick;

@end

@implementation BindMobilePhoneVC
- (BindPhoneTitleView *)titleView{
    if (!_titleView) {
        _titleView = [BindPhoneTitleView new];
        [_titleView resetWithBigTitle:@"绑定手机" subTitle:@"为了您的账号安全，需要验证绑定手机号"];
        _titleView.top = NAVIGATIONBAR_HEIGHT + W(21);
    }
    return _titleView;
}
- (BindPhoneCodeView *)codeView{
    if (!_codeView) {
        _codeView = [BindPhoneCodeView new];
        _codeView.top = self.titleView.bottom + W(50);
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
    [RequestApi requestSendBindPhoneCode:strPhone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
    [RequestApi requestBindPhone:strPhone code:self.codeView.tfSecond.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"绑定成功"];
        [GlobalData sharedInstance].GB_UserModel.cellPhone = strPhone;
        [GlobalData saveUserModel];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
