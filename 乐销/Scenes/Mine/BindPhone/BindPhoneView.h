//
//  BindPhoneView.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/7.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"

@interface BindPhoneTitleView : UIView
//属性
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *yellowBlock;
@property (strong, nonatomic) UIImageView *arrowRight;
@property (strong, nonatomic) UILabel *more;
@property (nonatomic, strong) void (^blockClick)(void);

#pragma mark 刷新view
- (void)resetWithBigTitle:(NSString *)title;

@end

@interface BindPhoneCodeView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIView *phoneBG;
@property (strong, nonatomic) UIView *secondBG;
@property (strong, nonatomic) UITextField *tfPhone;
@property (strong, nonatomic) UITextField *tfSecond;
@property (strong, nonatomic) YellowButton *btn;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIControl *controlResendCode;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double numTime;
@property (nonatomic, strong) void (^blockSendCodeClick)(void);
@property (nonatomic, strong) void (^blockLoginClick)(void);
- (void)timerStart;

@end
