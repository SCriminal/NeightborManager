//
//  NoticeAlertView.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/9/29.
//Copyright © 2020 ping. All rights reserved.
//

#import "NoticeAlertView.h"
#import  <YYKit/YYKit.h>

@interface NoticeAlertView ()

@end

@implementation NoticeAlertView
#pragma mark 懒加载

- (UILabel *)title{
    if (!_title) {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightRegular];
        l.textColor = COLOR_333;
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:@"提醒" variable:0];
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
- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.widthHeight = XY(W(290), W(55));
        [_btn setBackgroundColor:[UIColor clearColor]];
        _btn.titleLabel.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_btn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_btn setTitleColor:COLOR_BLUE forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btn;
}

- (UIView *)viewBG{
    if (!_viewBG) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(W(290), W(323));
        _viewBG.centerXCenterY = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0);
        [GlobalMethod setRoundView:_viewBG color:[UIColor clearColor] numRound:10 width:0];
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
//    [self addSubview:self.close];
    [self addSubview:self.btn];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.viewBG.top = W(157)+iphoneXTopInterval;
    
    self.title.centerXTop = XY(SCREEN_WIDTH/2.0, self.viewBG.top + W(25));
    
    self.close.rightTop = XY(SCREEN_WIDTH - W(58.5), self.viewBG.top + W(21));
//    [self addControlFrame:CGRectInset(self.close.frame, -W(10), -W(10)) belowView:self.close target:self action:@selector(closeClick)];

    CGFloat top = W(77) + self.viewBG.top;
    
    {
        NSString * str1 = @"有";
               NSString * str2 = @"1";
        NSString * str3 = @"条新的社区工作通知下发，请及时查阅！";

               NSMutableAttributedString * strAttribute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@%@",str1,str2,str3]];
               [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_333,        NSFontAttributeName : [UIFont systemFontOfSize:F(15)]} range:NSMakeRange(0, str1.length)];
               [strAttribute setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],        NSFontAttributeName : [UIFont systemFontOfSize:F(15)]} range:NSMakeRange(str1.length, str2.length)];
        [strAttribute setAttributes:@{NSForegroundColorAttributeName : COLOR_333,        NSFontAttributeName : [UIFont systemFontOfSize:F(15)]} range:NSMakeRange(str1.length +str2.length, str3.length)];
        strAttribute.lineSpacing = W(11);
        strAttribute.lineBreakMode = NSLineBreakByCharWrapping;
        UILabel * l = [UILabel new];
        l.numberOfLines = 0;
        l.lineSpace = W(11);
        l.backgroundColor = [UIColor clearColor];
        [l fitTitle:[NSString stringWithFormat:@"%@%@%@",str1,str2,str3] variable:SCREEN_WIDTH - W(67.5)*2];
        l.attributedText = strAttribute;

        l.leftTop = XY(W(67.5), top);
        [self addSubview:l];
        top = l.bottom + W(15);
    }
            
  
    
    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,top + W(20));
    self.viewBG.height = self.btn.bottom - self.viewBG.top;
    [self addLineFrame:CGRectMake(self.viewBG.left, self.btn.top, self.viewBG.width, 1)];
}


#pragma mark click
- (void)closeClick{
    [GlobalMethod endEditing];
    [self removeFromSuperview];
}
- (void)btnClick{
    
}
@end
