//
//  QuestionnaireDetailTopView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "QuestionnaireDetailTopView.h"

@interface QuestionnaireDetailTopView ()

@end

@implementation QuestionnaireDetailTopView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(19) weight:UIFontWeightMedium];
        _title.numberOfLines = 0;
        _title.lineSpace = W(9);

    }
    return _title;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_666;
        _time.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _time;
}
- (UILabel *)content{
    if (_content == nil) {
        _content = [UILabel new];
        _content.textColor = COLOR_333;
        _content.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _content.numberOfLines = 0;
        _content.lineSpace = W(9);

    }
    return _content;
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
        [self addSubview:self.title];
    [self addSubview:self.time];
    [self addSubview:self.content];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelQuestionnairDetail *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:UnPackStr(model.title) variable:SCREEN_WIDTH - W(30)];
    self.title.leftTop = XY(W(15),W(20));
    
    [self.time fitTitle:[NSString stringWithFormat:@"发布时间:%@",[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_MIN_SHOW]] variable:0];
    self.time.leftTop = XY(W(15),self.title.bottom+W(20));
    [self.content fitTitle:UnPackStr(model.iDPropertyDescription) variable:SCREEN_WIDTH - W(30)];
    CGFloat bottom = [self addLineFrame:CGRectMake(W(15), self.time.bottom+W(25), SCREEN_WIDTH- W(30), 1)];
    self.content.leftTop = XY(W(15),bottom+W(25));

    //设置总高度
    self.height =  isStr(model.iDPropertyDescription)?[self addLineFrame:CGRectMake(W(15), self.content.bottom+W(25), SCREEN_WIDTH- W(30), 1)]:bottom;
}

@end
