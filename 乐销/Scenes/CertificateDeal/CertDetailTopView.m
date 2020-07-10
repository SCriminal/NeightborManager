//
//  CertDetailTopView.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertDetailTopView.h"

@interface CertDetailTopView ()

@end

@implementation CertDetailTopView
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCertificateDealDetail *)model{
    self.model = model;
    //重置视图坐标
    [self removeAllSubViews];
    CGFloat bottom = [self addAryLabel:@[^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"姓名";
        item.subTitle = UnPackStr(model.realName);
        return item;
    }(),^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @" 身份证号";
        item.subTitle = UnPackStr(model.idNumber);
        return item;
    }(),^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"处理状态";
        item.isSelected = true;
        return item;
    }(),^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"";
        item.subTitle = @"";
        return item;
    }()] top:W(25)];
    //设置总高度
    self.height = bottom ;
}
- (CGFloat)addAryLabel:(NSArray *)ary top:(CGFloat)top{
    for (ModelBtn * item in ary) {
        if (isStr(item.title)) {
            UILabel * labelTitle = [UILabel new];
            labelTitle.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            labelTitle.textColor = COLOR_666;
            [labelTitle fitTitle:item.title variable:0];
            labelTitle.rightTop = XY(W(92), top);
            [self addSubview:labelTitle];
            
            UILabel * labelTitle1 = [UILabel new];
            labelTitle1.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            labelTitle1.textColor = item.isSelected?COLOR_BLUE:COLOR_333;
            labelTitle1.leftTop = XY(W(122), top);
            labelTitle1.numberOfLines = 0;
            labelTitle1.lineSpace = W(10);
            [labelTitle1 fitTitle:item.subTitle variable:W(217)];
            [self addSubview:labelTitle1];
            
            if (item.isSelected) {
                UILabel *_status = [UILabel new];
                _status.textColor = [UIColor whiteColor];
                _status.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
                _status.numberOfLines = 1;
                _status.lineSpace = 0;
                UIView *_labelBg = [UIView new];
                [_status fitTitle:UnPackStr(self.model.statusShow) variable:0];
                _labelBg.widthHeight = XY(_status.width + W(13), W(18));
                _labelBg.leftCenterY = XY(labelTitle1.left,labelTitle.centerY);
                _labelBg.backgroundColor = self.model.statusColorShow;
                [_labelBg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0 lineColor:[UIColor clearColor]];
                _status.center = _labelBg.center;
            }
            
            top = MAX(labelTitle.bottom, labelTitle1.bottom)+W(20);
        }else{
            [self addLineFrame:CGRectMake(W(30), top, SCREEN_WIDTH - W(60), 1)];
            top += W(20);
        }
    }
    return top - W(20);
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

@end
