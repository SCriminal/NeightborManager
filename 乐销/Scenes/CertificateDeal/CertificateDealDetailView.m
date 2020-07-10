//
//  CertificateDealDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/13.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealDetailView.h"
#import "CertificateDealImageView.h"

@interface CertificateDealDetailView ()

@end

@implementation CertificateDealDetailView

#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)model{
    [self removeAllSubViews];
    CGFloat top = W(25);
    NSArray * aryDatas = model;
//    BOOL fetchSingleImage = false;
    for (int i = 0; i<aryDatas.count; i++) {
        ModelQuestionnairDetailContent * content = aryDatas[i];
        switch ((int)content.type) {//类型，1-单选  2-多选 3-文本
            case 1:
            {
                CertificateDealDetailSingleChoiceView * view = [CertificateDealDetailSingleChoiceView new];
                view.userInteractionEnabled = !self.isParticipated;
                view.isParticipated = self.isParticipated;
                top = [view resetViewWithModel:content top:top];
                [self addSubview:view];
            }
                break;
            case 2:
            {
                CertificateDealDetailMultipleChoiceView * view = [CertificateDealDetailMultipleChoiceView new];
                view.userInteractionEnabled = !self.isParticipated;
                view.isParticipated = self.isParticipated;
                top = [view resetViewWithModel:content top:top];
                [self addSubview:view];
            }
                break;
            case 3:
            {
                CertificateDealDetailTextView * view = [CertificateDealDetailTextView new];
                view.isParticipated = self.isParticipated;
                top = [view resetViewWithModel:content top:top];
                [self addSubview:view];
            }
                break;
            case 4:
            {
                CertificateDealImageView * view = [CertificateDealImageView new];
                view.isParticipated = self.isParticipated;
                top = [view resetViewWithModel:@[content] top:top];
                [self addSubview:view];
            }
                break;
                case 5:
                {
                    CertificateDealMultiImageView * view = [CertificateDealMultiImageView new];
                    view.isEditing = !self.isParticipated;
                    //reload image
                    NSMutableArray * aryimages = [NSMutableArray new];
                    for (ModelQuestionnairDetailValues * item in content.values) {
                        ModelImage * model = [ModelImage new];
                        model.url = item.value;
                        [aryimages addObject:model];
                    }
                    view.aryDatas = aryimages;
                    top = [view resetViewWithModel:content top:top];
                    [self addSubview:view];
                }
                    break;

            default:
                break;
        }
    }
    
    
    //设置总高度
    self.height = top+W(20);
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


@end

@implementation CertificateDealDetailTextView

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top{
    self.model = model;
    [self removeAllSubViews];
    
    self.userInteractionEnabled = !self.isParticipated;
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    l.textColor = self.isParticipated?COLOR_999:COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(6);
    [l fitTitle:[NSString stringWithFormat:@"%@",UnPackStr(model.name)] variable:SCREEN_WIDTH - W(50)];
    l.leftTop = XY(W(25), 0);
    [self addSubview:l];
    
    if (model.isRequired) {
        UILabel * require = [UILabel new];
        require.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        require.textColor = [UIColor redColor];
        require.backgroundColor = [UIColor clearColor];
        [require fitTitle:@"*" variable:0];
        require.rightTop = XY(W(25), 0);
        [self addSubview:require];
    }
    
    UITextField* textField = [UITextField new];
    textField.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = self.isParticipated?COLOR_999:COLOR_333;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor = [UIColor clearColor];
    textField.delegate = self;
    textField.text = model.value;
    [textField addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    textField.placeholder = [NSString stringWithFormat:@"请输入%@",UnPackStr(model.name)];
    textField.widthHeight = XY(SCREEN_WIDTH - W(60), [GlobalMethod fetchHeightFromFont:textField.font.pointSize]);
    textField.leftTop = XY(W(30), l.bottom + W(26));
    [self addSubview:textField];
    self.tf = textField;
    
    UIView * viewBG = [UIView new];
    viewBG.backgroundColor = [UIColor whiteColor];
    viewBG.frame = CGRectMake(W(15), textField.top - W(13), SCREEN_WIDTH - W(30), textField.height + W(26));
    [viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    [viewBG addTarget:self action:@selector(bgClick)];
    [self insertSubview:viewBG atIndex:0];
    
    self.top = top;
    self.height = viewBG.bottom + W(20);
    return self.bottom;
}
#pragma mark textfild change
- (void)textFileAction:(UITextField *)textField {
    self.model.value = textField.text;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return true;
}
- (void)bgClick{
    [self.tf becomeFirstResponder];
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}

@end

@implementation CertificateDealDetailSingleChoiceView

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top{
    [self removeAllSubViews];
    self.top = top;
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    l.textColor = self.isParticipated?COLOR_999:COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(6);
    [l fitTitle:[NSString stringWithFormat:@"%@:",UnPackStr(model.name)] variable:SCREEN_WIDTH - W(50)];
    l.leftTop = XY(W(25), 0);
    [self addSubview:l];
    
    if (model.isRequired) {
        UILabel * require = [UILabel new];
        require.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        require.textColor = [UIColor redColor];
        require.backgroundColor = [UIColor clearColor];
        [require fitTitle:@"*" variable:0];
        require.rightTop = XY(W(25), 0);
        [self addSubview:require];
    }
    
    top = l.bottom + W(13);
    CGFloat left = W(15);
    CGFloat itemHeight = 0;
    for (ModelQuestionnairDetailValues * item in model.values) {
        CertificateDealDetailChoiceView * choice = [CertificateDealDetailChoiceView new];
        choice.isParticipated = self.isParticipated;
        choice.isSingleChoice = true;
        [choice resetViewWithModel:item];
        if (choice.width + left >SCREEN_WIDTH - W(15)) {
            left = W(15);
            top += itemHeight;
        }
        choice.leftTop = XY(left, top);
        itemHeight = choice.height;
        left = choice.right;
        [self addSubview:choice];
        WEAKSELF
        choice.blockSelected = ^(ModelQuestionnairDetailValues *itemSelected) {
            [weakSelf reconfigView:itemSelected];
        };
    }
    
    UIView * viewBG = [UIView new];
    viewBG.backgroundColor = [UIColor whiteColor];
    viewBG.frame = CGRectMake(W(15), l.bottom + W(13), SCREEN_WIDTH - W(30), top + itemHeight - l.bottom - W(13));
    [viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    [self insertSubview:viewBG atIndex:0];
    
    self.height = top + itemHeight + W(13);
    return self.bottom;
}

#pragma mark reconfig view
- (void)reconfigView:(ModelQuestionnairDetailValues *)itemSelected{
    for (CertificateDealDetailChoiceView *subView in self.subviews) {
        if ([subView isKindOfClass:CertificateDealDetailChoiceView.class]) {
            subView.model.isSelected = subView.model == itemSelected;
            [subView resetViewWithModel:subView.model];
        }
    }
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


@end

@implementation CertificateDealDetailMultipleChoiceView

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top{
    [self removeAllSubViews];
    self.top = top;
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    l.textColor = self.isParticipated?COLOR_999:COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(6);
    [l fitTitle:[NSString stringWithFormat:@"%@:",UnPackStr(model.name)] variable:SCREEN_WIDTH - W(50)];
    l.leftTop = XY(W(25), 0);
    [self addSubview:l];
    
    if (model.isRequired) {
        UILabel * require = [UILabel new];
        require.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        require.textColor = [UIColor redColor];
        require.backgroundColor = [UIColor clearColor];
        [require fitTitle:@"*" variable:0];
        require.rightTop = XY(W(25), 0);
        [self addSubview:require];
    }
    
    top = l.bottom + W(13);
    CGFloat left = W(15);
    CGFloat itemHeight = 0;
    for (ModelQuestionnairDetailValues * item in model.values) {
        CertificateDealDetailChoiceView * choice = [CertificateDealDetailChoiceView new];
        choice.isParticipated = self.isParticipated;
        choice.isSingleChoice = false;
        [choice resetViewWithModel:item];
        if (choice.width + left >SCREEN_WIDTH - W(15)) {
            left = W(15);
            top += itemHeight;
        }
        choice.leftTop = XY(left, top);
        itemHeight = choice.height;
        left = choice.right;
        [self addSubview:choice];
    }
    
    UIView * viewBG = [UIView new];
    viewBG.backgroundColor = [UIColor whiteColor];
    viewBG.frame = CGRectMake(W(15), l.bottom + W(13), SCREEN_WIDTH - W(30), top + itemHeight - l.bottom - W(13));
    [viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    [self insertSubview:viewBG atIndex:0];
    
    self.height = top + itemHeight + W(13);
    return self.bottom;
    
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


@end

@implementation CertificateDealDetailChoiceView
#pragma mark 懒加载
- (UIImageView *)iconSelected{
    if (_iconSelected == nil) {
        _iconSelected = ^(){
            UIImageView * icon = [UIImageView new];
            icon.widthHeight = XY(W(15), W(15));
            icon.backgroundColor = [UIColor clearColor];
            return icon;
        }();
    }
    return _iconSelected;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_999;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _title;
}

- (void)setIsSingleChoice:(BOOL)isSingleChoice{
    _isSingleChoice = isSingleChoice;
    
    self.iconSelected.image = [UIImage imageNamed:_isSingleChoice?@"select_default":@"multiply_selected_default"];
    if (self.isParticipated) {
        self.iconSelected.highlightedImage = [UIImage imageNamed:_isSingleChoice?@"select_highlighted_gray":@"multiply_selected_gray"];
    }else{
        self.iconSelected.highlightedImage = [UIImage imageNamed:_isSingleChoice?@"select_highlighted":@"multiply_selected"];
    }
    
}
#pragma mark 刷新view
- (void)resetViewWithModel:(ModelQuestionnairDetailValues *)model{
    
    self.model = model;
    self.iconSelected.leftTop = XY(W(25), W(13));
    
    [self.title fitTitle:UnPackStr(model.key) variable:SCREEN_WIDTH - W(80)];
    self.title.left = self.iconSelected.right + W(5);
    self.title.top = self.iconSelected.top - ([GlobalMethod fetchHeightFromFont:self.title.fontNum] - self.iconSelected.height)/2.0;
    
    self.height = self.title.height + W(26);
    self.width = MAX(self.title.right + W(5), (SCREEN_WIDTH - W(30))/2.0);
    [self resetSelcted];
}
- (void)resetSelcted{
    self.iconSelected.highlighted = self.model.isSelected;
    self.title.textColor = self.isParticipated?COLOR_999: self.model.isSelected?COLOR_ORANGE:COLOR_999;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        [self addSubview:self.iconSelected];
        [self addSubview:self.title];
        [self addTarget:self action:@selector(click)];
    }
    return self;
}
#pragma mark click
- (void)click{
    if (self.isSingleChoice) {
        if (self.blockSelected) {
            self.blockSelected(self.model);
        }
    }else{
        self.model.isSelected = !self.model.isSelected;
        [self resetViewWithModel:self.model];
    }
    
}

@end
