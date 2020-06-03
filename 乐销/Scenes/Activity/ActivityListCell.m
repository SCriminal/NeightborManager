//
//  ActivityListView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "ActivityListCell.h"




@implementation ActivityListCell
#pragma mark 懒加载
- (UILabel *)labelTitle{
    if (_labelTitle == nil) {
        _labelTitle = [UILabel new];
        _labelTitle.textColor = COLOR_333;
        _labelTitle.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _labelTitle.numberOfLines = 0;
        _labelTitle.lineSpace = W(5);
    }
    return _labelTitle;
}
- (UILabel *)labelContent{
    if (_labelContent == nil) {
        _labelContent = [UILabel new];
        _labelContent.textColor = COLOR_999;
        _labelContent.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _labelContent;
}
- (UILabel *)labelType{
    if (_labelType == nil) {
        _labelType = [UILabel new];
        _labelType.textColor = [UIColor whiteColor];
        _labelType.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightMedium];
        _labelType.textAlignment = NSTextAlignmentCenter;
        [GlobalMethod setRoundView:_labelType color:[UIColor clearColor] numRound:2 width:0];
    }
    return _labelType;
}
- (UILabel *)labelParticipate{
    if (_labelParticipate == nil) {
        _labelParticipate = [UILabel new];
        _labelParticipate.textColor = [UIColor whiteColor];
        _labelParticipate.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightMedium];
        _labelParticipate.textAlignment = NSTextAlignmentCenter;
        [GlobalMethod setRoundView:_labelParticipate color:[UIColor clearColor] numRound:2 width:0];

    }
    return _labelParticipate;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelContent];
        [self.contentView addSubview:self.labelType];
        [self.contentView addSubview:self.labelParticipate];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelActivity *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
   
    //刷新view
    [self.labelTitle fitTitle:UnPackStr(model.title)  variable:SCREEN_WIDTH - W(40)];
    self.labelTitle.leftTop = XY(W(20),W(18));
    
    [self.labelContent fitTitle:[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_SEC_SHOW] variable:SCREEN_WIDTH - W(40)];
    self.labelContent.leftTop = XY(W(20),self.labelTitle.bottom+W(13));
    
    
    [self.labelType fitTitle:model.typeShow variable:0];
       self.labelType.backgroundColor = model.colorShow;
       self.labelType.widthHeight = XY(self.labelType.width + W(10), self.labelType.height + W(7));
       if (false) {//社区
           [self.labelParticipate fitTitle:model.isParticipant?@"已报名":@"未报名" variable:0];
           self.labelParticipate.backgroundColor = model.isParticipant?[UIColor colorWithHexString:@"#FFA900"]:COLOR_GREEN;
           self.labelParticipate.widthHeight = XY(self.labelParticipate.width + W(10), self.labelParticipate.height + W(7));
           self.labelParticipate.hidden = false;
           self.labelParticipate.rightCenterY = XY(SCREEN_WIDTH - W(20), self.labelContent.centerY);
           self.labelType.rightCenterY = XY(self.labelParticipate.left - W(11), self.labelContent.centerY);
       }else{
           self.labelParticipate.hidden = true;
           self.labelType.rightCenterY = XY(SCREEN_WIDTH - W(20), self.labelContent.centerY);

       }
    
    //设置总高度
    self.height = self.labelContent.bottom + W(18);
    
    [self.contentView addLineFrame:CGRectMake(W(20), self.height -1, SCREEN_WIDTH - W(40), 1)];
    
}


@end
