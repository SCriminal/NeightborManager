//
//  CallingView.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "CallingView.h"

@interface CallingView ()

@end

@implementation CallingView
#pragma mark 懒加载
- (UIVisualEffectView *)masksView
{
    if (_masksView == nil) {
        _masksView = [UIVisualEffectView  new];
        UIBlurEffect * beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _masksView = [[UIVisualEffectView alloc]initWithEffect:beffect];
        _masksView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return  _masksView;
}
-(UIButton *)btnRefuse{
    if (_btnRefuse == nil) {
        _btnRefuse = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnRefuse addTarget:self action:@selector(btnRefuseClick) forControlEvents:UIControlEventTouchUpInside];
        _btnRefuse.backgroundColor = [UIColor clearColor];
        _btnRefuse.widthHeight = XY(W(65),W(65));
        [_btnRefuse setBackgroundImage:[UIImage imageNamed:@"rtc_refuse"] forState:UIControlStateNormal];
    }
    return _btnRefuse;
}
- (UILabel *)refuse{
    if (_refuse == nil) {
        _refuse = [UILabel new];
        _refuse.textColor = [UIColor whiteColor];
        _refuse.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [_refuse fitTitle:@"拒绝" variable:0];
    }
    return _refuse;
}
-(UIButton *)btnAccept{
    if (_btnAccept == nil) {
                _btnAccept = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnAccept addTarget:self action:@selector(btnAcceptClick) forControlEvents:UIControlEventTouchUpInside];
        _btnAccept.backgroundColor = [UIColor clearColor];
        _btnAccept.widthHeight = XY(W(65),W(65));
        [_btnAccept setBackgroundImage:[UIImage imageNamed:@"rtc_accept"] forState:UIControlStateNormal];


    }
    return _btnAccept;
}
- (UILabel *)accept{
    if (_accept == nil) {
        _accept = [UILabel new];
        _accept.textColor = [UIColor whiteColor];
        _accept.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [_accept fitTitle:@"接听" variable:0];
    }
    return _accept;
}
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"rtc_head"];
        _icon.widthHeight = XY(W(80),W(80));
        [GlobalMethod setRoundView:_icon color:[UIColor clearColor] numRound:5 width:0];
    }
    return _icon;
}
- (UIImageView *)bg{
    if (_bg == nil) {
        _bg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rtc_head"]];
//        _bg.image = [UIImage imageNamed:@"rtc_head"];
        _bg.widthHeight = XY(SCREEN_WIDTH,SCREEN_WIDTH);
        _bg.contentMode = UIViewContentModeScaleAspectFill;
        [_bg addSubview:self.masksView];
    }
    return _bg;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor whiteColor];
        _title.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        [_title fitTitle:@"连线指挥中心" variable:0];
    }
    return _title;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = SCREEN_HEIGHT;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.bg];
    [self addSubview:self.btnRefuse];
    [self addSubview:self.refuse];
    [self addSubview:self.btnAccept];
    [self addSubview:self.accept];
    [self addSubview:self.icon];
    [self addSubview:self.title];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.title.centerXTop = XY(SCREEN_WIDTH/2.0,STATUSBAR_HEIGHT + iphoneXTopInterval + W(12));

    //刷新view
    self.btnRefuse.leftBottom = XY(W(61),SCREEN_HEIGHT - W(64) - iphoneXBottomInterval);

    self.refuse.centerXTop = XY(self.btnRefuse.centerX,self.btnRefuse.bottom+W(15));

    self.btnAccept.rightTop = XY(SCREEN_WIDTH - W(61),self.btnRefuse.top);

    self.accept.centerXTop = XY(self.btnAccept.centerX,self.btnAccept.bottom+W(15));

    self.icon.centerXTop = XY(SCREEN_WIDTH/2.0, self.title.bottom+W(98));

    [self.bg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:IMAGE_HEAD_DEFAULT]];
}

#pragma mark 点击事件
- (void)btnRefuseClick{
    [self removeFromSuperview];
}
- (void)btnAcceptClick{
    [self removeFromSuperview];
}
@end
