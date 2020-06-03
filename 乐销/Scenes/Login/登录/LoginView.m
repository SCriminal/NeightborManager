//
//  LoginView.m
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "LoginView.h"
#import "WebVC.h"
#import "YellowButton.h"

@implementation LoginPwdView
#pragma mark 懒加载
- (UIView *)phoneBG{
    if (_phoneBG == nil) {
        _phoneBG = [UIView new];
        _phoneBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _phoneBG.widthHeight = XY(W(295), W(50));
        [_phoneBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_phoneBG addTarget:self action:@selector(phoneClick)];
    }
    return _phoneBG;
}
- (UIView *)secondBG{
    if (_secondBG == nil) {
        _secondBG = [UIView new];
        _secondBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _secondBG.widthHeight = XY(W(295), W(50));
        [_secondBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_secondBG addTarget:self action:@selector(secondClick)];

    }
    return _secondBG;
}
- (UITextField *)tfPhone{
    if (_tfPhone == nil) {
        _tfPhone = [UITextField new];
        _tfPhone.font = [UIFont systemFontOfSize:F(14)];
        _tfPhone.textAlignment = NSTextAlignmentLeft;
        _tfPhone.textColor = COLOR_333;
        _tfPhone.borderStyle = UITextBorderStyleNone;
        _tfPhone.backgroundColor = [UIColor clearColor];
        _tfPhone.placeholder  = @"请输入手机号";
        _tfPhone.delegate = self;
        _tfPhone.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
        _tfPhone.keyboardType = UIKeyboardTypeNumberPad;
        NSString * strValue = [GlobalMethod readStrFromUser:LOCAL_PHONE exchange:false];
        if (isStr(strValue)) {
            _tfPhone.text = [self exchangePhone:strValue];
        }
    }
    return _tfPhone;
}
- (NSString *)exchangePhone:(NSString*)str{
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString * strReturn = [NSMutableString stringWithString:str];
    if (strReturn.length >= 11) {
        [strReturn insertString:@" " atIndex:7];
        [strReturn insertString:@" " atIndex:3];
        return strReturn;
    }
    return str;
}
- (UITextField *)tfSecond{
    if (_tfSecond == nil) {
        _tfSecond = [UITextField new];
        _tfSecond.font = [UIFont systemFontOfSize:F(14)];
        _tfSecond.textAlignment = NSTextAlignmentLeft;
        _tfSecond.textColor = COLOR_333;
        _tfSecond.borderStyle = UITextBorderStyleNone;
        _tfSecond.backgroundColor = [UIColor clearColor];
        _tfSecond.placeholder  = @"请输入密码";
        _tfSecond.delegate = self;
        _tfSecond.secureTextEntry = true;
    }
    return _tfSecond;
}
- (LoginAuthorityView *)authorityView{
    if (!_authorityView) {
        _authorityView = [LoginAuthorityView new];
    }
    return _authorityView;
}
- (YellowButton *)btn{
    if (!_btn) {
        _btn = [YellowButton new];
        [_btn resetViewWithWidth:W(295) :W(45) :@"登录"];
        WEAKSELF
        _btn.blockClick = ^{
            if (weakSelf.blockLoginClick) {
                weakSelf.blockLoginClick();
            }
        };
        
    }
    return _btn;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.phoneBG];
    [self addSubview:self.secondBG];
    [self addSubview:self.tfPhone];
    [self addSubview:self.tfSecond];
//    [self addSubview:self.authorityView];
    [self addSubview:self.btn];
    
    //初始化页面
    [self resetViewWithModel:nil];
}
#pragma mark click
- (void)phoneClick{
    [self.tfPhone becomeFirstResponder];
}
- (void)secondClick{
    [self.tfSecond becomeFirstResponder];
}
- ( BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.phoneBG.centerXTop = XY(SCREEN_WIDTH/2.0,0);

    self.secondBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.phoneBG.bottom+W(30));
    
    self.tfPhone.widthHeight = XY(self.phoneBG.width - W(30), self.tfPhone.font.lineHeight);
    self.tfPhone.leftCenterY = XY(self.phoneBG.left + W(15),self.phoneBG.centerY);
    
    self.tfSecond.widthHeight = XY(self.secondBG.width - W(30), self.tfSecond.font.lineHeight);
    self.tfSecond.leftCenterY = XY(self.secondBG.left + W(15),self.secondBG.centerY);
    
    self.authorityView.leftTop = XY(W(40), self.secondBG.bottom + W(25));

    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,self.secondBG.bottom+W(45));
    
    //设置总高度
    self.height = self.btn.bottom;
}
@end

@implementation LoginCodeView
#pragma mark 懒加载
- (UIView *)phoneBG{
    if (_phoneBG == nil) {
        _phoneBG = [UIView new];
        _phoneBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _phoneBG.widthHeight = XY(W(295), W(50));
        [_phoneBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_phoneBG addTarget:self action:@selector(phoneClick)];

    }
    return _phoneBG;
}
- (UIView *)secondBG{
    if (_secondBG == nil) {
        _secondBG = [UIView new];
        _secondBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _secondBG.widthHeight = XY(W(295), W(50));
        [_secondBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_secondBG addTarget:self action:@selector(secondClick)];

    }
    return _secondBG;
}
- (UITextField *)tfPhone{
    if (_tfPhone == nil) {
        _tfPhone = [UITextField new];
        _tfPhone.font = [UIFont systemFontOfSize:F(14)];
        _tfPhone.textAlignment = NSTextAlignmentLeft;
        _tfPhone.textColor = COLOR_333;
        _tfPhone.borderStyle = UITextBorderStyleNone;
        _tfPhone.backgroundColor = [UIColor clearColor];
        _tfPhone.placeholder  = @"请输入手机号";
        _tfPhone.delegate = self;
        _tfPhone.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
        _tfPhone.keyboardType = UIKeyboardTypeNumberPad;
        NSString * strValue = [GlobalMethod readStrFromUser:LOCAL_PHONE exchange:false];
        if (isStr(strValue)) {
            _tfPhone.text = [self exchangePhone:strValue];
        }
    }
    return _tfPhone;
}
- (NSString *)exchangePhone:(NSString*)str{
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString * strReturn = [NSMutableString stringWithString:str];
    if (strReturn.length >= 11) {
        [strReturn insertString:@" " atIndex:7];
        [strReturn insertString:@" " atIndex:3];
        return strReturn;
    }
    return str;
}
- (UITextField *)tfSecond{
    if (_tfSecond == nil) {
        _tfSecond = [UITextField new];
        _tfSecond.font = [UIFont systemFontOfSize:F(14)];
        _tfSecond.textAlignment = NSTextAlignmentLeft;
        _tfSecond.textColor = COLOR_333;
        _tfSecond.borderStyle = UITextBorderStyleNone;
        _tfSecond.backgroundColor = [UIColor clearColor];
        _tfSecond.placeholder  = @"请输入验证码";
        _tfSecond.delegate = self;
    }
    return _tfSecond;
}
- (LoginAuthorityView *)authorityView{
    if (!_authorityView) {
        _authorityView = [LoginAuthorityView new];
    }
    return _authorityView;
}
- (YellowButton *)btn{
    if (!_btn) {
        _btn = [YellowButton new];
        [_btn resetViewWithWidth:W(295) :W(45) :@"登录"];
        WEAKSELF
        _btn.blockClick = ^{
            if (weakSelf.blockLoginClick) {
                weakSelf.blockLoginClick();
            }
        };
        
    }
    return _btn;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = [UIColor colorWithHexString:@"#D9D9D9"];
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
- (UIControl *)controlResendCode{
    if (!_controlResendCode) {
        _controlResendCode = [UIControl new];
        [_controlResendCode addTarget:self action:@selector(sendCodeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _controlResendCode;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.phoneBG];
    [self addSubview:self.secondBG];
    [self addSubview:self.tfPhone];
    [self addSubview:self.tfSecond];
    [self addSubview:self.authorityView];
    [self addSubview:self.btn];
    [self addSubview:self.time];
    [self addSubview:self.controlResendCode];
    //初始化页面
    [self resetViewWithModel:nil];
}
#pragma mark click
- (void)phoneClick{
    [self.tfPhone becomeFirstResponder];
}
- (void)secondClick{
    [self.tfSecond becomeFirstResponder];
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.phoneBG.centerXTop = XY(SCREEN_WIDTH/2.0,0);
    
    self.secondBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.phoneBG.bottom+W(30));
    
    self.tfPhone.widthHeight = XY(self.phoneBG.width - W(30), self.tfPhone.font.lineHeight);
    self.tfPhone.leftCenterY = XY(self.phoneBG.left + W(15),self.phoneBG.centerY);
    
    [self.time fitTitle:@"获取验证码" variable:0];
    self.time.rightCenterY = XY(self.secondBG.right - W(15), self.secondBG.centerY);
    self.controlResendCode.frame = CGRectInset(self.time.frame, -W(20), -W(20));
    
    self.tfSecond.widthHeight = XY(self.secondBG.width - W(110), self.tfSecond.font.lineHeight);
    self.tfSecond.leftCenterY = XY(self.secondBG.left + W(15),self.secondBG.centerY);
    
    self.authorityView.leftTop = XY(W(40), self.secondBG.bottom + W(25));
    
    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,self.authorityView.bottom+W(45));
    
    //设置总高度
    self.height = self.btn.bottom;
}
- ( BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        self.numTime = 60;
        [self timerRun];
    }
}

- (void)timerRun{
    //每秒的动作
    if (_numTime <=0) {
        //刷新按钮 开始
        [self timerStop];
        [self.time fitTitle:@"重新发送" variable:0];
        self.controlResendCode.userInteractionEnabled = true;
        self.time.right = self.secondBG.right - W(15);
        return;
    }
    _numTime --;
    [self.time fitTitle:[NSString stringWithFormat:@"%.lf秒以后重新获取",_numTime] variable:0];
    self.time.right = self.secondBG.right - W(15);
    self.controlResendCode.userInteractionEnabled = false;
}

- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}

#pragma mark click
- (void)sendCodeClick{
    if (self.blockSendCodeClick) {
        self.blockSendCodeClick();
    }
}
@end

@implementation LoginForgetView
#pragma mark 懒加载
- (UIView *)phoneBG{
    if (_phoneBG == nil) {
        _phoneBG = [UIView new];
        _phoneBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _phoneBG.widthHeight = XY(W(295), W(50));
        [_phoneBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_phoneBG addTarget:self action:@selector(phoneClick)];

    }
    return _phoneBG;
}
- (UIView *)secondBG{
    if (_secondBG == nil) {
        _secondBG = [UIView new];
        _secondBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _secondBG.widthHeight = XY(W(295), W(50));
        [_secondBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_secondBG addTarget:self action:@selector(secondClick)];

    }
    return _secondBG;
}
- (UIView *)thirdBG{
    if (_thirdBG == nil) {
        _thirdBG = [UIView new];
        _thirdBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _thirdBG.widthHeight = XY(W(295), W(50));
        [_thirdBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_thirdBG addTarget:self action:@selector(thirdClick)];

    }
    return _thirdBG;
}

- (UITextField *)tfPhone{
    if (_tfPhone == nil) {
        _tfPhone = [UITextField new];
        _tfPhone.font = [UIFont systemFontOfSize:F(14)];
        _tfPhone.textAlignment = NSTextAlignmentLeft;
        _tfPhone.textColor = COLOR_333;
        _tfPhone.borderStyle = UITextBorderStyleNone;
        _tfPhone.backgroundColor = [UIColor clearColor];
        _tfPhone.placeholder  = @"请输入手机号";
        _tfPhone.delegate = self;
        _tfPhone.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
        _tfPhone.keyboardType = UIKeyboardTypeNumberPad;



    }
    return _tfPhone;
}
- (UITextField *)tfSecond{
    if (_tfSecond == nil) {
        _tfSecond = [UITextField new];
        _tfSecond.font = [UIFont systemFontOfSize:F(14)];
        _tfSecond.textAlignment = NSTextAlignmentLeft;
        _tfSecond.textColor = COLOR_333;
        _tfSecond.borderStyle = UITextBorderStyleNone;
        _tfSecond.backgroundColor = [UIColor clearColor];
        _tfSecond.placeholder  = @"请输入验证码";
        _tfSecond.delegate = self;
    }
    return _tfSecond;
}
- (UITextField *)tfThird{
    if (_tfThird == nil) {
        _tfThird = [UITextField new];
        _tfThird.font = [UIFont systemFontOfSize:F(14)];
        _tfThird.textAlignment = NSTextAlignmentLeft;
        _tfThird.textColor = COLOR_333;
        _tfThird.borderStyle = UITextBorderStyleNone;
        _tfThird.backgroundColor = [UIColor clearColor];
        _tfThird.placeholder  = @"请输入新密码";
        _tfThird.delegate = self;
    }
    return _tfThird;
}

- (YellowButton *)btn{
    if (!_btn) {
        _btn = [YellowButton new];
        [_btn resetViewWithWidth:W(295) :W(45) :@"重置"];
        WEAKSELF
        _btn.blockClick = ^{
            if (weakSelf.blockResetClick) {
                weakSelf.blockResetClick();
            }
        };
        
    }
    return _btn;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = [UIColor colorWithHexString:@"#D9D9D9"];
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
- (UIControl *)controlResendCode{
    if (!_controlResendCode) {
        _controlResendCode = [UIControl new];
        [_controlResendCode addTarget:self action:@selector(sendCodeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _controlResendCode;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.phoneBG];
    [self addSubview:self.secondBG];
    [self addSubview:self.thirdBG];
    [self addSubview:self.tfPhone];
    [self addSubview:self.tfSecond];
    [self addSubview:self.tfThird];
    [self addSubview:self.btn];
    [self addSubview:self.time];
    [self addSubview:self.controlResendCode];
    //初始化页面
    [self resetViewWithModel:nil];
}
#pragma mark click
- (void)phoneClick{
    [self.tfPhone becomeFirstResponder];
}
- (void)secondClick{
    [self.tfSecond becomeFirstResponder];
}
- (void)thirdClick{
    [self.tfThird becomeFirstResponder];
}
#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.phoneBG.centerXTop = XY(SCREEN_WIDTH/2.0,0);
    
    self.secondBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.phoneBG.bottom+W(30));
    
    self.thirdBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.secondBG.bottom+W(30));

    
    self.tfPhone.widthHeight = XY(self.phoneBG.width - W(30), self.tfPhone.font.lineHeight);
    self.tfPhone.leftCenterY = XY(self.phoneBG.left + W(15),self.phoneBG.centerY);
    
    [self.time fitTitle:@"获取验证码" variable:0];
    self.time.rightCenterY = XY(self.secondBG.right - W(15), self.secondBG.centerY);
    self.controlResendCode.frame = CGRectInset(self.time.frame, -W(20), -W(20));
    
    self.tfSecond.widthHeight = XY(self.secondBG.width - W(110), self.tfSecond.font.lineHeight);
    self.tfSecond.leftCenterY = XY(self.secondBG.left + W(15),self.secondBG.centerY);
    
    self.tfThird.widthHeight = XY(self.thirdBG.width - W(30), self.tfThird.font.lineHeight);
    self.tfThird.leftCenterY = XY(self.thirdBG.left + W(15),self.thirdBG.centerY);

    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,self.thirdBG.bottom+W(45));
    
    //设置总高度
    self.height = self.btn.bottom;
}
- ( BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        self.numTime = 60;
        [self timerRun];
    }
}

- (void)timerRun{
    //每秒的动作
    if (_numTime <=0) {
        //刷新按钮 开始
        [self timerStop];
        [self.time fitTitle:@"重新发送" variable:0];
        self.controlResendCode.userInteractionEnabled = true;
        self.time.right = self.secondBG.right - W(15);
        return;
    }
    _numTime --;
    [self.time fitTitle:[NSString stringWithFormat:@"%.lf秒以后重新获取",_numTime] variable:0];
    self.time.right = self.secondBG.right - W(15);
    self.controlResendCode.userInteractionEnabled = false;
}

- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}

#pragma mark click
- (void)sendCodeClick{
    if (self.blockSendCodeClick) {
        self.blockSendCodeClick();
    }
}
@end

@implementation LoginAuthorityView
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = false;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    CGFloat left = 0;
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_999;
        [label fitTitle:@"已阅并同意" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
    }
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_ORANGE;
        [label fitTitle:@"《用户协议》" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
        
        [self addControlFrame:CGRectInset(label.frame, 0, -W(20)) belowView:label target:self action:@selector(userContractClick)];
    }
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_999;
        [label fitTitle:@"&" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
    }
    {
        UILabel * label = [UILabel new];
        label.fontNum = F(12);
        label.textColor = COLOR_ORANGE;
        [label fitTitle:@"《隐私政策》" variable:0];
        label.left = left;
        left = label.right;
        [self addSubview:label];
        [self addControlFrame:CGRectInset(label.frame, 0, -W(20)) belowView:label target:self action:@selector(privacyContractClick)];
        
        self.widthHeight = XY(label.right, label.height);
    }
}

#pragma mark click
- (void)userContractClick{
    WebVC * vc = [WebVC new];
    vc.navTitle = @"用户协议";
    vc.url = @"https://www.zhongcheyun.cn/user/agreement";
    [GB_Nav pushViewController:vc animated:true];
}
- (void)privacyContractClick{
    WebVC * vc = [WebVC new];
    vc.navTitle = @"隐私政策";
    vc.url = @"https://www.zhongcheyun.cn/privacy";
    [GB_Nav pushViewController:vc animated:true];
}

@end
