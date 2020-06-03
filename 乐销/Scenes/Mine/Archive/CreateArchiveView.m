//
//  CreateArchiveView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateArchiveView.h"


@interface CreateArchiveView ()

//属性
@property (strong, nonatomic) UILabel *identify;
@property (strong, nonatomic) UILabel *republic;
@property (strong, nonatomic) UILabel *alert;
@property (strong, nonatomic) UIImageView *alertIV;
@property (nonatomic, strong) UIView *viewWhiteBG;

@end

@implementation CreateArchiveView
- (UIView *)viewWhiteBG{
    if (!_viewWhiteBG) {
        _viewWhiteBG = [UIView new];
        _viewWhiteBG.backgroundColor = [UIColor whiteColor];
        _viewWhiteBG.width = W(345);
    }
    return _viewWhiteBG;
}
- (UILabel *)identify{
    if (_identify == nil) {
        _identify = [UILabel new];
        _identify.textColor = COLOR_333;
        _identify.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _identify.numberOfLines = 1;
        _identify.lineSpace = 0;
    }
    return _identify;
}
- (UILabel *)republic{
    if (_republic == nil) {
        _republic = [UILabel new];
        _republic.textColor = COLOR_333;
        _republic.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _republic.numberOfLines = 1;
        _republic.lineSpace = 0;
    }
    return _republic;
}
- (UILabel *)alert{
    if (_alert == nil) {
        _alert = [UILabel new];
        _alert.textColor = COLOR_999;
        _alert.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _alert.numberOfLines = 3;
        _alert.lineSpace = W(10);
    }
    return _alert;
}
- (UIImageView *)alertIV{
    if (_alertIV == nil) {
        _alertIV = [UIImageView new];
        _alertIV.image = [UIImage imageNamed:@"archive_alert"];
        _alertIV.widthHeight = XY(W(12),W(12));
    }
    return _alertIV;
}

- (MultipleSelectView *)selectIdentityView{
    if (!_selectIdentityView) {
        _selectIdentityView = [MultipleSelectView new];
        [_selectIdentityView resetViewWith:@[@"业主",@"亲友",@"租户"]];
        _selectIdentityView.blockClick = ^(int index) {
            
        };
        NSLog(@"%ld",_selectIdentityView.index);
    }
    return _selectIdentityView;
}
- (MultipleSelectView *)selectRepublicView{
    if (!_selectRepublicView) {
        _selectRepublicView = [MultipleSelectView new];
        [_selectRepublicView resetViewWith:@[@"否",@"是"]];
        _selectRepublicView.blockClick = ^(int index) {
            
        };
    }
    return _selectRepublicView;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(325) :W(45) :@"提交"];
        _btnBottom.blockClick = ^{
            [GB_Nav popViewControllerAnimated:true];
        };
    }
    return _btnBottom;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self addSubview:self.viewWhiteBG];
    [self addSubview:self.identify];
    [self addSubview:self.republic];

    [self addSubview:self.alert];
    [self addSubview:self.alertIV];
    [self addSubview:self.selectIdentityView];
    [self addSubview:self.selectRepublicView];

    [self addSubview:self.btnBottom];
    [self resetViewWithModel:nil];
}

- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    CGFloat cellHeight = W(45);
    //刷新view
    [self.identify fitTitle:@"身份选择" variable:0];
    self.identify.leftCenterY = XY(W(35),cellHeight/2.0);
    self.selectIdentityView.leftCenterY = XY( W(127), self.identify.centerY);
    
    [self.republic fitTitle:@"是否党员" variable:0];
    [self addLineFrame:CGRectMake(W(35),cellHeight, SCREEN_WIDTH - W(70), 1)];
    self.republic.leftCenterY = XY(W(35),cellHeight*1.5);
    
    self.selectRepublicView.leftCenterY = XY( W(127), self.republic.centerY);

    self.viewWhiteBG.height = cellHeight*2;
    self.viewWhiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
    [self.viewWhiteBG addRoundCorner:UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    

    
    self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, cellHeight*2+W(25));
    
    [self.alert fitTitle:@"如楼栋、单元、门号出现以A、B等方式命名\n请以对应阿拉伯数字1、2的形式填写\n若无单元号，请填写1" variable:0];
    self.alert.centerXTop = XY(SCREEN_WIDTH/2.0,self.btnBottom.bottom+W(35));
    
    self.alertIV.rightTop = XY(self.alert.left - W(8),self.alert.top);
    
    //设置总高度
    self.height = self.alert.bottom + W(36);
}


@end

