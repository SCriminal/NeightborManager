//
//  LoginBottomView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "LoginBottomView.h"

@interface LoginBottomView ()

@end

@implementation LoginBottomView

#pragma mark 懒加载
-(UIButton *)btnWechat{
    if (_btnWechat == nil) {
        _btnWechat = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnWechat.tag = ENUM_LOGIN_BTN_WECHAT;
        [_btnWechat addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnWechat.backgroundColor = [UIColor clearColor];
        [_btnWechat setBackgroundImage:[UIImage imageNamed:@"login_wechat"] forState:UIControlStateNormal];
        _btnWechat.widthHeight = XY(W(67),W(67));
    }
    return _btnWechat;
}
-(UIButton *)btnPwd{
    if (_btnPwd == nil) {
        _btnPwd = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPwd.tag = ENUM_LOGIN_BTN_PWD;
        [_btnPwd addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnPwd.backgroundColor = [UIColor clearColor];
        [_btnPwd setBackgroundImage:[UIImage imageNamed:@"login_pwd"] forState:UIControlStateNormal];
        _btnPwd.widthHeight = XY(W(67),W(67));
    }
    return _btnPwd;
}
-(UIButton *)btnForget{
    if (_btnForget == nil) {
        _btnForget = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnForget.tag = ENUM_LOGIN_BTN_FORGET;
        [_btnForget addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnForget.backgroundColor = [UIColor clearColor];
        [_btnForget setBackgroundImage:[UIImage imageNamed:@"login_forget"] forState:UIControlStateNormal];
        _btnForget.widthHeight = XY(W(67),W(67));
    }
    return _btnForget;
}
-(UIButton *)btnCode{
    if (_btnCode == nil) {
        _btnCode = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCode.tag = ENUM_LOGIN_BTN_CODE;
        [_btnCode addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnCode.backgroundColor = [UIColor clearColor];
        [_btnCode setBackgroundImage:[UIImage imageNamed:@"login_code"] forState:UIControlStateNormal];
        _btnCode.widthHeight = XY(W(67),W(67));
    }
    return _btnCode;
}
- (UILabel *)wechat{
    if (_wechat == nil) {
        _wechat = [UILabel new];
        _wechat.textColor = COLOR_999;
        _wechat.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _wechat.numberOfLines = 1;
        _wechat.lineSpace = 0;
        [_wechat fitTitle:@"微信登录" variable:0];
    }
    return _wechat;
}
- (UILabel *)pwd{
    if (_pwd == nil) {
        _pwd = [UILabel new];
        _pwd.textColor = COLOR_999;
        _pwd.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _pwd.numberOfLines = 1;
        _pwd.lineSpace = 0;
        [_pwd fitTitle:@"密码登录" variable:0];

    }
    return _pwd;
}
- (UILabel *)forget{
    if (_forget == nil) {
        _forget = [UILabel new];
        _forget.textColor = COLOR_999;
        _forget.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _forget.numberOfLines = 1;
        _forget.lineSpace = 0;
        [_forget fitTitle:@"忘记密码" variable:0];

    }
    return _forget;
}
- (UILabel *)code{
    if (_code == nil) {
        _code = [UILabel new];
        _code.textColor = COLOR_999;
        _code.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _code.numberOfLines = 1;
        _code.lineSpace = 0;
        [_code fitTitle:@"验证码登录" variable:0];

    }
    return _code;
}

-(void)setType:(ENUM_LOGIN_BTN_TYPE)type{
    _type = type;
    [self reconfig];
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = self.code.height + self.btnCode.height-W(3);
        [self addSubView];
        self.type = ENUM_LOGIN_BTN_PWD;
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.btnWechat];
    [self addSubview:self.btnPwd];
    [self addSubview:self.btnForget];
    [self addSubview:self.btnCode];
    [self addSubview:self.wechat];
    [self addSubview:self.pwd];
    [self addSubview:self.forget];
    [self addSubview:self.code];
    
   
}

- (void)reconfig{
    if (self.type == ENUM_LOGIN_BTN_FORGET) {
        return;
    }
    for (UIView * subView in self.subviews) {
        subView.hidden = false;
    }
    self.btnWechat.hidden= true;
    switch (self.type) {
        case ENUM_LOGIN_BTN_PWD:
            {
                self.btnCode.centerX = SCREEN_WIDTH/2.0;
                self.btnCode.right = SCREEN_WIDTH/2.0-W(47)/2.0;

                self.btnWechat.right = self.btnCode.left - W(47);
                self.btnForget.left = self.btnCode.right + W(47);
                self.btnPwd.hidden = true;
            }
            break;
        case ENUM_LOGIN_BTN_CODE:
        {
            self.btnPwd.centerX = SCREEN_WIDTH/2.0;
            self.btnPwd.right = SCREEN_WIDTH/2.0-W(47)/2.0;

            self.btnWechat.right = self.btnPwd.left - W(47);
            self.btnForget.left = self.btnPwd.right + W(47);
            self.btnCode.hidden = true;
        }
            break;
        case ENUM_LOGIN_BTN_FORGET:
        {
//            self.btnPwd.centerX = SCREEN_WIDTH/2.0;
//            self.btnPwd.right = SCREEN_WIDTH/2.0-W(47)/2.0;
//
//            self.btnWechat.right = self.btnPwd.left - W(47);
//            self.btnCode.left = self.btnPwd.right + W(47);
//            self.btnForget.hidden = true;
        }
            break;
        default:
            break;
    }
    self.pwd.hidden = self.btnPwd.hidden;
    self.code.hidden = self.btnCode.hidden;
    self.forget.hidden = self.btnForget.hidden;
    self.wechat.hidden = self.btnWechat.hidden;
    self.pwd.centerXBottom = XY(self.btnPwd.centerX, self.height);
    self.code.centerXBottom = XY(self.btnCode.centerX, self.height);
    self.forget.centerXBottom = XY(self.btnForget.centerX, self.height);
    self.wechat.centerXBottom = XY(self.btnWechat.centerX, self.height);

}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case ENUM_LOGIN_BTN_PWD:
        {
            self.type = sender.tag;
        }
            break;
        case ENUM_LOGIN_BTN_CODE:
        {
            self.type = sender.tag;

        }
            break;
        case ENUM_LOGIN_BTN_FORGET:
        {
            self.type = sender.tag;

        }
            break;
        case ENUM_LOGIN_BTN_WECHAT:
        {
            
        }
            break;
        default:
            break;
    }
    if (self.blockClick) {
        self.blockClick(sender.tag);
    }
}

@end
