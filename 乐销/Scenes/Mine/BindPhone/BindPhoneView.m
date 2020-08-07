//
//  BindPhoneView.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "BindPhoneView.h"

@implementation BindPhoneTitleView

#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor blackColor];
        _title.font =  [UIFont systemFontOfSize:F(18) weight:UIFontWeightMedium];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UIView *)yellowBlock{
    if (_yellowBlock == nil) {
        _yellowBlock = [UIView new];
        _yellowBlock.backgroundColor = [UIColor colorWithHexString:@"#D8E5FB"];
    }
    return _yellowBlock;
}
- (UIImageView *)arrowRight{
    if (_arrowRight == nil) {
        _arrowRight = [UIImageView new];
        _arrowRight.image = [UIImage imageNamed:@"arrow_right"];
        _arrowRight.widthHeight = XY(W(15),W(15));
    }
    return _arrowRight;
}
- (UILabel *)more{
    if (_more == nil) {
        _more = [UILabel new];
        _more.textColor = COLOR_666;
        _more.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _more.numberOfLines = 1;
        _more.lineSpace = 0;
    }
    return _more;
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
    [self addSubview:self.yellowBlock];
    [self addSubview:self.title];
    [self addSubview:self.arrowRight];
    [self addSubview:self.more];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:@"动态快报" variable:0];
    self.title.leftTop = XY(W(20),W(0));
    self.yellowBlock.widthHeight = XY(self.title.width+ W(6), W(7));
    self.yellowBlock.centerXBottom = XY(self.title.centerX,self.title.bottom+W(2));
    [self.yellowBlock addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight radius:self.yellowBlock.height/2.0];

    //设置总高度
    self.height = self.yellowBlock.bottom;
    
    self.arrowRight.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    [self.more fitTitle:@"更多" variable:0];
    self.more.rightCenterY = XY(self.arrowRight.left - W(3),self.arrowRight.centerY);
    
    [self addControlFrame:CGRectMake(self.more.left-W(20), 0, SCREEN_WIDTH - (self.more.left-W(20)), self.height) belowView:self.more target:self action:@selector(moreClick)];
}

#pragma mark 刷新view
- (void)resetWithBigTitle:(NSString *)title{
    self.title.fontNum = F(30);
    [self.title fitTitle:title variable:0];
    self.title.leftTop = XY(W(43),W(0));
    self.yellowBlock.widthHeight = XY(self.title.width+ W(6), W(7));
    self.yellowBlock.centerXBottom = XY(self.title.centerX,self.title.bottom+W(2));
    [self.yellowBlock addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight radius:self.yellowBlock.height/2.0];
    self.more.hidden = true;
    self.arrowRight.hidden = true;
    self.height = self.yellowBlock.bottom;

}

#pragma mark click
- (void)moreClick{
    if (self.blockClick) {
        self.blockClick();
    }
}

@end


@implementation BindPhoneCodeView
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
        [self addTarget:self action:@selector(hideKeyboard)];
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
        
    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,self.secondBG.bottom + W(25));
    
    //设置总高度
    self.height = self.btn.bottom;
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
- (void)sendCodeClick{
    if (self.blockSendCodeClick) {
        self.blockSendCodeClick();
    }
}
- (void)hideKeyboard{
    [GlobalMethod hideKeyboard];
}
@end
