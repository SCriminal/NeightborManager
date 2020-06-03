//
//  WhistleListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "WhistleListCell.h"

@interface WhistleListCell ()

@end

@implementation WhistleListCell
#pragma mark 懒加载
- (UILabel *)problem{
    if (_problem == nil) {
        _problem = [UILabel new];
        _problem.textColor = COLOR_333;
        _problem.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _problem.numberOfLines = 1;
        _problem.lineSpace = 0;
    }
    return _problem;
}
- (UILabel *)status{
    if (_status == nil) {
        _status = [UILabel new];
        _status.textColor = [UIColor whiteColor];
        _status.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _status.numberOfLines = 1;
        _status.lineSpace = 0;
    }
    return _status;
}

- (UIView *)labelBg{
    if (_labelBg == nil) {
        _labelBg = [UIView new];
        _labelBg.backgroundColor = COLOR_ORANGE;
        
    }
    return _labelBg;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}




#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.problem];
        [self.contentView addSubview:self.labelBg];
        [self.contentView addSubview:self.status];
        [self.contentView addSubview:self.time];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelWhistleList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    
    [self.status fitTitle:UnPackStr(model.statusShow) variable:0];
    
    self.labelBg.widthHeight = XY(self.status.width + W(13), W(18));
    self.labelBg.leftTop = XY(W(15),W(16.5));
    self.labelBg.backgroundColor = model.statusColorShow;
    [self.labelBg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0 lineColor:[UIColor clearColor]];
    
    self.status.center = self.labelBg.center;


    //刷新view
    [self.problem fitTitle:UnPackStr(model.iDPropertyDescription) variable:W(270)];
    self.problem.leftCenterY = XY(self.labelBg.right+W(8),self.labelBg.centerY);
    
    
    
    
    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.whistleTime andFormatter:TIME_MIN_SHOW] variable:W(270)];
    self.time.leftTop = XY(W(15),self.labelBg.bottom+W(11.5));
    
    
    //设置总高度
    self.height = self.time.bottom + W(18);
    
    
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}


@end
