//
//  SwitchView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SwitchView.h"

@interface SwitchView ()

@end

@implementation SwitchView
#pragma mark 懒加载
- (UILabel *)titleLeft{
    if (_titleLeft == nil) {
        _titleLeft = [UILabel new];
        _titleLeft.textColor = [UIColor whiteColor];
        _titleLeft.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _titleLeft.numberOfLines = 1;
        _titleLeft.lineSpace = 0;
    }
    return _titleLeft;
}
- (UILabel *)titleRight{
    if (_titleRight == nil) {
        _titleRight = [UILabel new];
        _titleRight.textColor = COLOR_999;
        _titleRight.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _titleRight.numberOfLines = 1;
        _titleRight.lineSpace = 0;
    }
    return _titleRight;
}
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"switch_left"];
        _BG.highlightedImage = [UIImage imageNamed:@"switch_right"];

        _BG.widthHeight = XY(W(260 ),W(40));
    }
    return _BG;
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
    [self addSubview:self.BG];
    [self addSubview:self.titleLeft];
    [self addSubview:self.titleRight];
    
}

#pragma mark 刷新view
- (void)resetViewWith:(NSString *)leftTitle :(NSString *)rightTitle{
    
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.titleLeft fitTitle:leftTitle variable:0];
    self.titleLeft.centerXCenterY = XY(W(70),self.BG.height/2.0);
    [self.titleRight fitTitle:rightTitle variable:0];
    self.titleRight.centerXCenterY = XY(self.BG.width - W(70),self.BG.height/2.0);
    
    //设置总高度
    self.widthHeight = self.BG.widthHeight;
    
    [self addControlFrame:CGRectMake(0, 0, W(120), W(40)) belowView:self.titleLeft target:self action:@selector(leftClick)];
    [self addControlFrame:CGRectMake(W(140), 0, W(120), W(40)) belowView:self.titleRight target:self action:@selector(rightClick)];

}

#pragma mark click
- (void)leftClick{
    self.index = 0;
    [self reconfig];
}
- (void)rightClick{
    self.index = 1;
    [self reconfig];

}

- (void)reconfig{
    self.titleLeft.textColor = self.index == 0? [UIColor whiteColor]:COLOR_999;
    self.titleRight.textColor = self.index == 1? [UIColor whiteColor]:COLOR_999;
    self.BG.highlighted = self.index == 1;
    if (self.blockClick) {
        self.blockClick(self.index);
    }
}

- (void)switchToIndex:(int)index{
    self.index = index;
    [self reconfig];
}
@end
