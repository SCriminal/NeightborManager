//
//  LoginBottomView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ENUM_LOGIN_BTN_TYPE) {
    ENUM_LOGIN_BTN_PWD =0,
    ENUM_LOGIN_BTN_WECHAT,
    ENUM_LOGIN_BTN_FORGET,
    ENUM_LOGIN_BTN_CODE
};

@interface LoginBottomView : UIView
@property (nonatomic, strong) UIButton *btnWechat;
@property (nonatomic, strong) UIButton *btnPwd;
@property (nonatomic, strong) UIButton *btnForget;
@property (nonatomic, strong) UIButton *btnCode;
@property (nonatomic, strong) UILabel *wechat;
@property (nonatomic, strong) UILabel *pwd;
@property (nonatomic, strong) UILabel *forget;
@property (nonatomic, strong) UILabel *code;
@property (nonatomic, assign) ENUM_LOGIN_BTN_TYPE type;
@property (nonatomic, strong) void (^blockClick)(ENUM_LOGIN_BTN_TYPE);

@end
