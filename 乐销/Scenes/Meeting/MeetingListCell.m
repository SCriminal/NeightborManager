//
//  MeetingListView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "MeetingListCell.h"




@implementation MeetingListCell
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


#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.labelTitle];
        [self.contentView addSubview:self.labelContent];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelQuestionariList *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.labelTitle fitTitle:UnPackStr(model.title)  variable:SCREEN_WIDTH - W(40)];
    self.labelTitle.leftTop = XY(W(20),W(18));
    
    [self.labelContent fitTitle:[GlobalMethod exchangeTimeWithStamp:model.inputStartTime andFormatter:TIME_SEC_SHOW] variable:SCREEN_WIDTH - W(40)];
    self.labelContent.leftTop = XY(W(20),self.labelTitle.bottom+W(13));
    
    //设置总高度
    self.height = self.labelContent.bottom + W(18);
    
    [self.contentView addLineFrame:CGRectMake(W(20), self.height -1, SCREEN_WIDTH - W(40), 1)];
    
}


@end
