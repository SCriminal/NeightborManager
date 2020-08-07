//
//  BindPhoneAlertView.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/7.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindPhoneAlertView : UIView<UITextFieldDelegate>
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UIView *phoneBG;
@property (strong, nonatomic) UIView *secondBG;
@property (strong, nonatomic) UITextField *tfPhone;
@property (strong, nonatomic) UITextField *tfSecond;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *close;
@property (strong, nonatomic) UIButton *btn;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIControl *controlResendCode;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) double numTime;
@property (nonatomic, strong) void (^blockSendCodeClick)(void);
@property (nonatomic, strong) void (^blockLoginClick)(void);
- (void)timerStart;

@end
