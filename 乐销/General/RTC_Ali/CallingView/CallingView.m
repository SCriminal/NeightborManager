//
//  CallingView.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "CallingView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "RTCSampleChatViewController.h"
@interface CallingView ()
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation CallingView

SYNTHESIZE_SINGLETONE_FOR_CLASS(CallingView)

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
        _bg = [UIImageView new];
        _bg.image = [UIImage imageNamed:@"rtc_head"];
        _bg.widthHeight = XY(SCREEN_WIDTH,SCREEN_HEIGHT);
        _bg.contentMode = UIViewContentModeScaleAspectFill;
        _bg.backgroundColor = [UIColor redColor];
        [_bg addSubview:^(){
            UIView * viewBlack = [UIView new];
            viewBlack.backgroundColor = COLOR_BLACK_ALPHA_PER60;
            viewBlack.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
            return viewBlack;
        }()];
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

    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    [self timerStart];
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
}
#pragma mark 定时器相关
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    }
}

- (void)timerRun{
        AudioServicesPlaySystemSound(1000);
}

- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
    [self removeFromSuperview];
}
#pragma mark 点击事件
- (void)btnRefuseClick{
    [self timerStop];
}
- (void)btnAcceptClick{
    [self timerStop];
    RTCSampleChatViewController * vc= [RTCSampleChatViewController new];
    vc.model = self.model;
    [GB_Nav pushViewController:vc animated:true];
}
@end
