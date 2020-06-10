//
//  MessageCenterCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "WorkNoticeListCell.h"

@interface WorkNoticeListCell ()

@end

@implementation WorkNoticeListCell
#pragma mark 懒加载
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
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
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
- (UIView *)labelBg{
    if (_labelBg == nil) {
        _labelBg = [UIView new];
        _labelBg.backgroundColor = COLOR_ORANGE;
        
    }
    return _labelBg;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.labelBg];
        [self.contentView addSubview:self.status];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    [self.status fitTitle:model.isReader?@"已读":@"未读" variable:0];
    
    self.labelBg.widthHeight = XY(self.status.width + W(12), W(18));
    self.labelBg.leftTop = XY(W(15),W(17.5));
    self.labelBg.backgroundColor = model.isReader?COLOR_BLUE:COLOR_ORANGE;
    [self.labelBg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0 lineColor:[UIColor clearColor]];
    
    self.status.center = self.labelBg.center;

    
    //刷新view
    [self.title fitTitle:UnPackStr(model.title) variable:W(270)];
    self.title.leftCenterY = XY(self.labelBg.right+W(8),self.labelBg.centerY);

    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.publishTime andFormatter:TIME_MIN_SHOW] variable:SCREEN_WIDTH - W(30)];
    self.time.leftTop = XY(W(15),self.title.bottom+W(13));
    
    //设置总高度
    self.height = self.time.bottom + W(18);
    
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end
