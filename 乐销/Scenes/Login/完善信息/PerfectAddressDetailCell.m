//
//  PerfectAddressDetailCell.m
//中车运
//
//  Created by 隋林栋 on 2018/10/24.
//Copyright © 2018年 ping. All rights reserved.
//

#import "PerfectAddressDetailCell.h"

#import "BaseTableVC+Authority.h"

@implementation PerfectAddressDetailCell
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
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _title;
}
- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.widthHeight = XY(SCREEN_WIDTH - W(50), 1);
        _line.backgroundColor = COLOR_LINE;
    }
    return _line;
}

- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = COLOR_333;
        _textView.placeHolder.fontNum = F(15);
        _textView.placeHolder.textColor = COLOR_999;
        _textView.font = [UIFont systemFontOfSize:F(15)];
        _textView.scrollEnabled = false;
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), 0, 0, 0);
        WEAKSELF
        _textView.blockTextChange = ^(PlaceHolderTextView *textView) {
            weakSelf.model.subString = textView.text;
        };
        _textView.blockHeightChange  = ^(PlaceHolderTextView *textView) {
            CGFloat heightOrigin = weakSelf.height;
            [weakSelf resetCellWithoutTextView];
            CGFloat heightChange = weakSelf.height - heightOrigin;
            BaseTableVC * tableVC = (BaseTableVC *)[weakSelf fetchVC];
            if ([tableVC isKindOfClass:BaseTableVC.class] && heightChange) {
                [tableVC.tableView reloadCellHeight:heightChange];
            }
        };
        
    }
    return _textView;
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
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.line];
        //初始化页面
        [self resetCellWithModel:nil];
    }
    return self;
}


#pragma mark 刷新view
- (void)resetCellWithModel:(ModelBaseData *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    if (isStr(model.string)) {
        [self.title fitTitle:model.string variable:0];
    }
    if (model.placeHolderString) {
        [self.textView.placeHolder fitTitle:model.placeHolderString variable:0];
    }
    //刷新view
    self.title.leftTop = XY(W(35),  W(15));
    
    self.textView.leftTop = XY(W(127),self.title.top);
    self.textView.text = model.subString;
    self.line.hidden = model.hideState;
    [self resetCellWithoutTextView];
}

- (void)resetCellWithoutTextView{
    
    self.textView.leftTop = XY(W(127),self.title.top+W(2));
    NSLog(@"%lf",W(127));
    self.textView.width = SCREEN_WIDTH - W(127) - W(35);
    [self.textView changeLinesCallBlock:false];
    self.textView.height = MAX(self.textView.font.lineHeight , self.textView.numTextHeight);
    [self.textView changeLinesCallBlock:false];
    
    self.height = self.textView.bottom + self.title.top;
    self.line.leftBottom = XY(W(35), self.height);
    
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

@end
