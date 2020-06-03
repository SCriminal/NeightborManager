//
//  SignInVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SignInVC.h"
//request
#import "RequestApi+Neighbor.h"
@interface SignInVC ()
@property (nonatomic, strong) UIImageView *ivBG;
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIImageView *lineLeft;
@property (nonatomic, strong) UIImageView *lineRight;


@end

@implementation SignInVC


#pragma mark 懒加载
- (UIImageView *)lineLeft{
    if (_lineLeft == nil) {
        _lineLeft = [UIImageView new];
        _lineLeft.image = [UIImage imageNamed:@"signin_line"];
        _lineLeft.widthHeight = XY(W(86),W(1));
        _lineLeft.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _lineLeft;
}
- (UIImageView *)lineRight{
    if (_lineRight == nil) {
        _lineRight = [UIImageView new];
        _lineRight.image = [UIImage imageNamed:@"signin_line"];
        _lineRight.widthHeight = XY(W(86),W(1));
        _lineRight.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _lineRight;
}
- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavTitle:@"签到成功" leftImageName:@"back_white" leftImageSize:CGSizeMake(W(25), W(25)) leftBlock:^{
            [GB_Nav popViewControllerAnimated:true];
        } rightTitle:nil righBlock:^{
            
        }];
        _nav.backgroundColor = [UIColor clearColor];
        _nav.labelTitle.textColor = [UIColor whiteColor];
    }
    return _nav;
}
- (UIImageView *)ivBG{
    if (_ivBG == nil) {
        _ivBG = [UIImageView new];
        _ivBG.image = [UIImage imageNamed:@"signin_bg"];
        _ivBG.widthHeight = XY(SCREEN_WIDTH,SCREEN_HEIGHT);
    }
    return _ivBG;
}
- (UIImageView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIImageView new];
        _whiteBG.image = [UIImage imageNamed:@"signin_white_bg"];
        _whiteBG.widthHeight = XY(W(325),W(302));
    }
    return _whiteBG;
}
- (UIImageView *)goldCoin{
    if (_goldCoin == nil) {
        _goldCoin = [UIImageView new];
        _goldCoin.image = [UIImage imageNamed:@"signin_coin"];
        _goldCoin.widthHeight = XY(W(110),W(110));
    }
    return _goldCoin;
}
- (UILabel *)success{
    if (_success == nil) {
        _success = [UILabel new];
        _success.textColor = COLOR_333;
        _success.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        _success.numberOfLines = 1;
        _success.lineSpace = 0;
    }
    return _success;
}
- (UILabel *)score{
    if (_score == nil) {
        _score = [UILabel new];
        _score.textColor = COLOR_333;
        _score.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _score.numberOfLines = 1;
        _score.lineSpace = 0;
    }
    return _score;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_BLUE;
        _time.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}
- (UILabel *)everyday{
    if (_everyday == nil) {
        _everyday = [UILabel new];
        _everyday.textColor = COLOR_333;
        _everyday.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _everyday.numberOfLines = 1;
        _everyday.lineSpace = 0;
    }
    return _everyday;
}
- (UILabel *)alert{
    if (_alert == nil) {
        _alert = [UILabel new];
        _alert.textColor = COLOR_333;
        _alert.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        _alert.numberOfLines = 2;
        _alert.lineSpace = W(8);
    }
    return _alert;
}


- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(225) :W(45) :@"积分兑换"];
        _btnBottom.blockClick = ^{
            
            [GB_Nav pushVCName:@"IntegralStoreVC" animated:true];

        };
    }
    return _btnBottom;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];

    //添加subView
    [self.view addSubview:self.ivBG];
    [self.view addSubview:self.nav];
    [self.view addSubview:self.whiteBG];
    [self.view addSubview:self.goldCoin];
    [self.view addSubview:self.success];
    [self.view addSubview:self.score];
    [self.view addSubview:self.time];
//    [self.view addSubview:self.everyday];
//    [self.view addSubview:self.alert];
//    [self.view addSubview:self.btnBottom];
//    [self.view addSubview:self.lineLeft];
//    [self.view addSubview:self.lineRight];
    
    //刷新view
    
    self.whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0,W(155)+iphoneXTopInterval);
    
    self.goldCoin.centerXCenterY = XY(SCREEN_WIDTH/2.0,self.whiteBG.top);
    [self.success fitTitle:@"今日您已经签到！" variable:0];
    self.success.centerXTop = XY(SCREEN_WIDTH/2.0,self.goldCoin.bottom+W(34));
    [self.score fitTitle:@"获得10个积分" variable:0];
    self.score.centerXTop = XY(SCREEN_WIDTH/2.0,self.success.bottom+W(30));
    [self.time fitTitle:[GlobalMethod exchangeDate:[NSDate date] formatter:TIME_DAY_SHOW] variable:0];
    self.time.centerXTop = XY(SCREEN_WIDTH/2.0,self.score.bottom+W(50));
    [self.everyday fitTitle:@"每日一句" variable:0];
    self.everyday.centerXCenterY = XY(SCREEN_WIDTH/2.0,self.whiteBG.centerY);
    self.lineLeft.rightCenterY = XY(self.everyday.left - W(16), self.everyday.centerY);
    self.lineRight.leftCenterY = XY(self.everyday.right + W(16), self.everyday.centerY);

    [self.alert fitTitle:@"人生嘛，就是笑笑别人，顺便再让别人笑笑" variable:self.whiteBG.width - W(40)];
    self.alert.centerXTop = XY(SCREEN_WIDTH/2.0,self.everyday.bottom+W(42));
    self.btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, self.whiteBG.bottom - W(35));

    //request
    [self requestList];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestSignDayWithScore:10 description:@"" delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
// velvet textile
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
