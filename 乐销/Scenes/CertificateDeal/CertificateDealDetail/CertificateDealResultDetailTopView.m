//
//  CertificateDealResultDetailTopView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/1.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealResultDetailTopView.h"

@interface CertificateDealResultDetailTopView ()

@end

@implementation CertificateDealResultDetailTopView


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCertificateDealDetail *)modelDetail{
    self.modelDetail = modelDetail;
    [self removeAllSubViews];//移除线
    NSMutableArray * ary = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"姓名";
        model.subTitle = modelDetail.realName;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"身份证号";
        model.subTitle = modelDetail.idNumber;
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"处理状态";
        model.isSelected = true;
        
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        return model;
    }()].mutableCopy;
//    if (self.modelDetail.status == 3 ) {
//        [ary insertObject:^(){
//            ModelBtn * model = [ModelBtn new];
//            model.title = @"退回理由";
//            model.subTitle = @"reason";
//            return model;
//        }() atIndex:3];
//    }
    //重置视图坐标
    CGFloat bottom = [self addAryLabel:ary top:W(25)];
    //设置总高度
    self.height = bottom;
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
            
            UILabel * labelTitle1 = nil;
            if (item.isSelected) {
                labelTitle1 = [UILabel new];
                labelTitle1.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                labelTitle1.textColor = [UIColor whiteColor];
                labelTitle1.backgroundColor = self.modelDetail.statusColorShow;
                labelTitle1.widthHeight = XY([self.modelDetail.statusShow sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:labelTitle1.font.pointSize]}].width +W(11), W(18));
                labelTitle1.leftCenterY = XY(W(122), labelTitle.centerY);
                labelTitle1.textAlignment = NSTextAlignmentCenter;
                labelTitle1.text = self.modelDetail.statusShow;
                [labelTitle1 addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:3 lineWidth:0 lineColor:[UIColor clearColor]];
                

                [self addSubview:labelTitle1];
            }else{
                labelTitle1 = [UILabel new];
                labelTitle1.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
                labelTitle1.textColor = COLOR_333;
                labelTitle1.leftTop = XY(W(122), top);
                labelTitle1.numberOfLines = 0;
                labelTitle1.lineSpace = W(10);
                [labelTitle1 fitTitle:item.subTitle variable:W(217)];
                [self addSubview:labelTitle1];
            }
            
            
            top = MAX(labelTitle.bottom, labelTitle1.bottom)+W(20);
        }else{
            [self addLineFrame:CGRectMake(W(30), top, SCREEN_WIDTH - W(60), 1)];
            top += W(20)+1;
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
