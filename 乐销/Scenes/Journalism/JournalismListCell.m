//
//  JournalismListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "JournalismListCell.h"

@interface JournalismListCell ()

@end

@implementation JournalismListCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _title.numberOfLines = 3;
        _title.lineSpace = W(5);
    }
    return _title;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];

        
    }
    return _time;
}
- (UIImageView *)icon{
    if (_icon == nil) {
        _icon = [UIImageView new];
        _icon.widthHeight = XY(W(120),W(92));
        [_icon addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
    }
    return _icon;
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
        [self.contentView addSubview:self.icon];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    if (isStr(model.coverUrl)) {
        self.icon.hidden = false;
        [self.icon sd_setImageWithURL:[NSURL URLWithString:model.coverUrl] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
        self.icon.rightTop = XY(SCREEN_WIDTH -  W(15),W(18));
        
        [self.title fitTitle:model.title variable:self.icon.left - W(45)];
        self.title.leftTop = XY(W(15),self.icon.top);
        [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.publishTime andFormatter:TIME_DAY_SHOW] variable:self.icon.left - W(30)];
        self.time.leftBottom = XY(W(15),self.icon.bottom);
        
        
        //设置总高度
        self.height = self.icon.bottom + W(18);
        [self.contentView addLineFrame:CGRectMake(W(15), self.height -1 , SCREEN_WIDTH - W(30), 1)];

    }else{
        self.icon.hidden = true;
        
        [self.title fitTitle:model.title variable:SCREEN_WIDTH - W(30)];
        self.title.leftTop = XY(W(15),W(18));
        [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.publishTime andFormatter:TIME_DAY_SHOW] variable:self.icon.left - W(30)];
        self.time.leftTop = XY(W(15),self.title.bottom+W(13));
        
        //设置总高度
        self.height = self.time.bottom + W(18);
        [self.contentView addLineFrame:CGRectMake(W(15), self.height -1 , SCREEN_WIDTH - W(30), 1)];
    }
}

@end
