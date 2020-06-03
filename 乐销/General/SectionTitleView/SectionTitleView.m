//
//  SectionTitleView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "SectionTitleView.h"

@interface SectionTitleView ()

@end

@implementation SectionTitleView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor blackColor];
        _title.font =  [UIFont systemFontOfSize:F(18) weight:UIFontWeightMedium];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UIView *)yellowBlock{
    if (_yellowBlock == nil) {
        _yellowBlock = [UIView new];
        _yellowBlock.backgroundColor = [UIColor colorWithHexString:@"#D8E5FB"];
    }
    return _yellowBlock;
}
- (UIImageView *)arrowRight{
    if (_arrowRight == nil) {
        _arrowRight = [UIImageView new];
        _arrowRight.image = [UIImage imageNamed:@"arrow_right"];
        _arrowRight.widthHeight = XY(W(15),W(15));
    }
    return _arrowRight;
}
- (UILabel *)more{
    if (_more == nil) {
        _more = [UILabel new];
        _more.textColor = COLOR_666;
        _more.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _more.numberOfLines = 1;
        _more.lineSpace = 0;
    }
    return _more;
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
    [self addSubview:self.yellowBlock];
    [self addSubview:self.title];
    [self addSubview:self.arrowRight];
    [self addSubview:self.more];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:@"动态快报" variable:0];
    self.title.leftTop = XY(W(20),W(0));
    self.yellowBlock.widthHeight = XY(self.title.width+ W(6), W(7));
    self.yellowBlock.centerXBottom = XY(self.title.centerX,self.title.bottom+W(2));
    [self.yellowBlock addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight radius:self.yellowBlock.height/2.0];

    //设置总高度
    self.height = self.yellowBlock.bottom;
    
    self.arrowRight.rightCenterY = XY(SCREEN_WIDTH - W(15),self.height/2.0);
    [self.more fitTitle:@"更多" variable:0];
    self.more.rightCenterY = XY(self.arrowRight.left - W(3),self.arrowRight.centerY);
    
    [self addControlFrame:CGRectMake(self.more.left-W(20), 0, SCREEN_WIDTH - (self.more.left-W(20)), self.height) belowView:self.more target:self action:@selector(moreClick)];
}

#pragma mark 刷新view
- (void)resetWithBigTitle:(NSString *)title{
    self.title.fontNum = F(30);
    [self.title fitTitle:title variable:0];
    self.title.leftTop = XY(W(43),W(0));
    self.yellowBlock.widthHeight = XY(self.title.width+ W(6), W(7));
    self.yellowBlock.centerXBottom = XY(self.title.centerX,self.title.bottom+W(2));
    [self.yellowBlock addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight radius:self.yellowBlock.height/2.0];
    self.more.hidden = true;
    self.arrowRight.hidden = true;
    self.height = self.yellowBlock.bottom;

}

#pragma mark click
- (void)moreClick{
    if (self.blockClick) {
        self.blockClick();
    }
}

@end
