//
//  PerfectSelectCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PerfectSelectCell.h"
#import "BaseTableVC+Authority.h"

@interface PerfectSelectCell ()

@end

@implementation PerfectSelectCell
#pragma mark 懒加载
- (UIView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
    }
    return _whiteBG;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.numberOfLines = 0;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [UILabel new];
        _subTitle.textColor = COLOR_333;
        _subTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _subTitle.numberOfLines = 0;
        _subTitle.lineSpace = 0;
    }
    return _subTitle;
}
- (UIImageView *)ivArrow{
    if (!_ivArrow) {
        _ivArrow = [UIImageView new];
        _ivArrow.image = [UIImage imageNamed:@"arrow_right"];
        _ivArrow.backgroundColor=[UIColor clearColor];
        _ivArrow.widthHeight = XY(W(15), W(15));
    }
    return _ivArrow;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_GRAY;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.whiteBG];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.subTitle];
        [self.contentView addSubview:self.ivArrow];
        [self.contentView addTarget:self action:@selector(cellClick)];
    }
    return self;
}
#pragma mark 刷新cell
/*
 isSelected 是否必填
 isHide 是否隐藏右箭头
 */
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //设置总高度
    CGFloat cellHeight = W(45);
    self.height = cellHeight;
    
    
    [self.title fitTitle:model.string variable:0];
    self.title.leftCenterY = XY(W(35),self.height/2.0);
    self.title.textColor = self.model.isChangeInvalid?COLOR_999:COLOR_333;

    self.ivArrow.rightCenterY = XY(SCREEN_WIDTH - W(25), self.height/2.0);
    
    
    CGFloat leftInterval = self.leftInterval?self.leftInterval:(W(127));
    
    NSString * strPlace = self.model.isChangeInvalid?@"不可修改":model.placeHolderString;
    [self.subTitle fitTitle:isStr(model.subString)?model.subString:strPlace variable:self.ivArrow.left - W(110)];
    self.subTitle.leftCenterY = XY(leftInterval,self.height/2.0);
    self.subTitle.textColor = isStr(model.subString)?COLOR_333:COLOR_999;
    if (self.model.isChangeInvalid) {
        self.subTitle.textColor = COLOR_999;
    }
    
    if (self.subTitle.height > self.subTitle.font.lineHeight) {
        self.height = self.subTitle.height - self.subTitle.font.lineHeight +cellHeight;
        self.title.centerY = self.height/2.0;
        self.subTitle.centerY = self.height/2.0;
        self.ivArrow.centerY = self.height/2.0;
    }
    
    if (!model.hideState) {
        [self.contentView addLineFrame:CGRectMake(W(25), self.height -1, SCREEN_WIDTH - W(50), 1)];
    }
    
    self.whiteBG.widthHeight = XY(W(345), self.height);
    self.whiteBG.centerXTop = XY(SCREEN_WIDTH/2.0, 0);
    [self.whiteBG removeCorner];
    switch (self.model.locationType) {
        case ENUM_CELL_LOCATION_TOP:
            [self.whiteBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
            break;
        case ENUM_CELL_LOCATION_BOTTOM:
            [self.whiteBG addRoundCorner:UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
            break;
        default:
            break;
    }

    
}
#pragma mark click
- (void)cellClick{
    if (self.model.isChangeInvalid) {
        [GlobalMethod showAlert:@"不可修改"];
        return;
    }
    if (self.model.blocClick) {
        self.model.blocClick(self.model);
    }
}

@end
