//
//  BindPhoneAlertView.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "BindPhoneAlertView.h"
//request
#import "RequestApi+Neighbor.h"

@interface BindPhoneAlertView ()

@end

@implementation BindPhoneAlertView
#pragma mark 懒加载
- (LoadingView *)loadingView{
    if (_loadingView == nil) {
        _loadingView = [LoadingView new];
    }
    return _loadingView;
}

- (UIView *)phoneBG{
    if (_phoneBG == nil) {
        _phoneBG = [UIView new];
        _phoneBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _phoneBG.widthHeight = XY(W(250), W(41));
        [_phoneBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_phoneBG addTarget:self action:@selector(phoneClick)];

    }
    return _phoneBG;
}
- (UIView *)secondBG{
    if (_secondBG == nil) {
        _secondBG = [UIView new];
        _secondBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _secondBG.widthHeight = XY(W(250), W(41));
        [_secondBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        [_secondBG addTarget:self action:@selector(secondClick)];

    }
    return _secondBG;
}
- (UILabel *)title{
    if (!_title) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"绑定手机" variable:0];
        _title = l;
    }
    return _title;
}
- (UIImageView *)close{
    if (!_close) {
        UIImageView * iv = [UIImageView new];
        iv.backgroundColor = [UIColor clearColor];
        iv.image = [UIImage imageNamed:@"inputClose"];
        iv.widthHeight = XY(W(25),W(25));
        _close = iv;
    }
    return _close;
}
- (UITextField *)tfPhone{
    if (_tfPhone == nil) {
        _tfPhone = [UITextField new];
        _tfPhone.font = [UIFont systemFontOfSize:F(15)];
        _tfPhone.textAlignment = NSTextAlignmentLeft;
        _tfPhone.textColor = COLOR_333;
        _tfPhone.borderStyle = UITextBorderStyleNone;
        _tfPhone.backgroundColor = [UIColor clearColor];
        _tfPhone.placeholder  = @"请输入手机号";
        _tfPhone.delegate = self;
        _tfPhone.numericFormatter = [AKNumericFormatter formatterWithMask:@"*** **** ****" placeholderCharacter:'*'];
        _tfPhone.keyboardType = UIKeyboardTypeNumberPad;
        [_tfPhone addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
        NSString * strValue = [GlobalMethod readStrFromUser:LOCAL_PHONE exchange:false];
        if (isStr(strValue)) {
            _tfPhone.text = [self exchangePhone:strValue];
            self.time.textColor = COLOR_BLUE;
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
        _tfSecond.font = [UIFont systemFontOfSize:F(15)];
        _tfSecond.textAlignment = NSTextAlignmentLeft;
        _tfSecond.textColor = COLOR_333;
        _tfSecond.borderStyle = UITextBorderStyleNone;
        _tfSecond.backgroundColor = [UIColor clearColor];
        _tfSecond.placeholder  = @"请输入验证码";
        _tfSecond.delegate = self;
    }
    return _tfSecond;
}
- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.widthHeight = XY(W(290), W(55));
        [_btn setBackgroundColor:[UIColor clearColor]];
        _btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_btn setTitle:@"绑定" forState:UIControlStateNormal];
        [_btn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(bindClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = [UIColor colorWithHexString:@"#D9D9D9"];
        _time.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
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
- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(W(290), W(323));
        _viewBG.centerXCenterY = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor clearColor]];
    }
    return _viewBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_BLACK_ALPHA_PER60;
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.title];
    [self addSubview:self.close];
    [self addSubview:self.phoneBG];
    [self addSubview:self.secondBG];
    [self addSubview:self.tfPhone];
    [self addSubview:self.tfSecond];
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
    
    self.title.centerXTop = XY(SCREEN_WIDTH/2.0, self.viewBG.top + W(25));
    
    self.close.rightTop = XY(SCREEN_WIDTH - W(58.5), self.viewBG.top + W(21));
    [self addControlFrame:CGRectInset(self.close.frame, -W(10), -W(10)) belowView:self.close target:self action:@selector(closeClick)];

    self.phoneBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.viewBG.top + W(77));
    
    self.secondBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.phoneBG.bottom+W(20));
    
    self.tfPhone.widthHeight = XY(self.phoneBG.width - W(30), self.tfPhone.font.lineHeight);
    self.tfPhone.leftCenterY = XY(self.phoneBG.left + W(15),self.phoneBG.centerY);
    
    [self.time fitTitle:@"获取验证码" variable:0];
    self.time.rightCenterY = XY(self.secondBG.right - W(15), self.secondBG.centerY);
    self.controlResendCode.frame = CGRectInset(self.time.frame, -W(20), -W(20));
    
    self.tfSecond.widthHeight = XY(self.secondBG.width - W(110), self.tfSecond.font.lineHeight);
    self.tfSecond.leftCenterY = XY(self.secondBG.left + W(15),self.secondBG.centerY);
            
    CGFloat top = self.secondBG.bottom;
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(5);
        [l fitTitle:@"· 您可以使用此手机号找回密码及登录" variable:W(271)];
        l.leftTop = XY(W(65), top + W(20));
        [self addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(5);
        [l fitTitle:@"· 请勿随意泄露手机号，以防不法分子利用账号信息" variable:W(271)];
        l.leftTop = XY(W(65), top + W(10));
        [self addSubview:l];
        top = l.bottom;
    }
    
    self.btn.centerXBottom = XY(SCREEN_WIDTH/2.0,self.viewBG.bottom );
    [self addLineFrame:CGRectMake(self.viewBG.left, self.btn.top, self.viewBG.width, 1)];
}
- ( BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
#pragma mark textfild change
- (void)textFileAction:(UITextField *)textField {
    if (self.timer) {
        return;
    }
    NSString * strPhone = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.time.textColor = strPhone.length>=11?COLOR_BLUE:[UIColor colorWithHexString:@"#D9D9D9"];
}
#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        self.numTime = 60;
        self.time.textColor = [UIColor colorWithHexString:@"#D9D9D9"];
        [self timerRun];
    }
}

- (void)timerRun{
    _numTime --;
    //每秒的动作
    if (_numTime <=0) {
        //刷新按钮 开始
        [self timerStop];
        [self.time fitTitle:@"重新发送" variable:0];
        self.time.textColor = COLOR_BLUE;
        self.controlResendCode.userInteractionEnabled = true;
        self.time.right = self.secondBG.right - W(15);
        return;
    }
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
- (void)closeClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)sendCodeClick{
    [self requestSendCode];
}
- (void)hideKeyboard{
    [GlobalMethod hideKeyboard];
}
- (void)bindClick{
    [self requestCodeLogin];
}
#pragma mark 请求过程回调
- (void)protocolWillRequest{
    [self showLoadingView];
}
//show loading view
- (void)showLoadingView{
    [self.loadingView hideLoading];
    [self.loadingView resetFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) viewShow:self];
}
- (void)protocolDidRequestSuccess{
    [self.loadingView hideLoading];
}
- (void)protocolDidRequestFailure:(NSString *)errorStr{
    [self.loadingView hideLoading];
    if ([self isShowInScreen]&&isStr(errorStr)) {
          [GlobalMethod showAlert:errorStr];
         }
}
#pragma mark request
- (void)requestSendCode{
    [GlobalMethod endEditing];

    NSString * strPhone = [self.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (!isPhoneNum(strPhone)) {
        [GlobalMethod showAlert:@"请输入有效手机号"];
        return;
    }
    [RequestApi requestSendBindPhoneCode:strPhone delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [self timerStart];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestCodeLogin{
    [GlobalMethod endEditing];

    NSString * strPhone = [self.tfPhone.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (!isPhoneNum(strPhone)) {
        [GlobalMethod showAlert:@"请输入有效手机号"];
        return;
    }
    if (self.tfSecond.text.length == 0) {
        [GlobalMethod showAlert:@"请输入验证码"];
        return;
    }
    [RequestApi requestBindPhone:strPhone code:self.tfSecond.text delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"绑定成功"];
        [GlobalData sharedInstance].GB_UserModel.cellPhone = strPhone;
        [GlobalData saveUserModel];
        [self removeFromSuperview];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
