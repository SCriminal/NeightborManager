//
//  DevelopVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/14.
//Copyright © 2020 ping. All rights reserved.
//

#import "DevelopVC.h"

@interface DevelopVC ()
@property (nonatomic, strong) UIImageView *develop;
@property (nonatomic, strong) UILabel *alert;

@end

@implementation DevelopVC
#pragma mark 懒加载
- (UIImageView *)develop{
    if (_develop == nil) {
        _develop = [UIImageView new];
        _develop.image = [UIImage imageNamed:@"develop"];
        _develop.widthHeight = XY(W(187),W(150));
    }
    return _develop;
}
- (UILabel *)alert{
    if (_alert == nil) {
        _alert = [UILabel new];
        _alert.textColor = COLOR_ORANGE;
        _alert.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _alert.numberOfLines = 1;
        _alert.lineSpace = 0;
        [_alert fitTitle:@"即将上线" variable:0];
    }
    return _alert;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.develop];
    [self.view addSubview:self.alert];
    self.develop.centerXTop = XY(SCREEN_WIDTH/2.0, NAVIGATIONBAR_HEIGHT + W(161));
    self.alert.centerXTop = XY(SCREEN_WIDTH/2.0, self.develop.bottom + W(30));

}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:self.navTitle rightView:nil]];
}

@end
