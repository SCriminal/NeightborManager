//
//  LoginView.h
//  Driver
//
//  Created by 隋林栋 on 2019/4/9.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginAuthorityView,YellowButton;

@interface LoginPwdView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIView *phoneBG;
@property (strong, nonatomic) UIView *secondBG;
@property (strong, nonatomic) UITextField *tfPhone;
@property (strong, nonatomic) UITextField *tfSecond;
@property (strong, nonatomic) LoginAuthorityView *authorityView;
@property (strong, nonatomic) YellowButton *btn;
@property (nonatomic, strong) void (^blockLoginClick)(void);

@end

@interface LoginCodeView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIView *phoneBG;
@property (strong, nonatomic) UIView *secondBG;
@property (strong, nonatomic) UITextField *tfPhone;
@property (strong, nonatomic) UITextField *tfSecond;
@property (strong, nonatomic) LoginAuthorityView *authorityView;
@property (strong, nonatomic) YellowButton *btn;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIControl *controlResendCode;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double numTime;
@property (nonatomic, strong) void (^blockSendCodeClick)(void);
@property (nonatomic, strong) void (^blockLoginClick)(void);
- (void)timerStart;

@end

@interface LoginForgetView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIView *phoneBG;
@property (strong, nonatomic) UIView *secondBG;
@property (strong, nonatomic) UIView *thirdBG;
@property (strong, nonatomic) UITextField *tfPhone;
@property (strong, nonatomic) UITextField *tfSecond;
@property (strong, nonatomic) UITextField *tfThird;
@property (strong, nonatomic) YellowButton *btn;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIControl *controlResendCode;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double numTime;
@property (nonatomic, strong) void (^blockResetClick)(void);
@property (nonatomic, strong) void (^blockSendCodeClick)(void);

- (void)timerStart;

@end

@interface LoginAuthorityView : UIView
@end
