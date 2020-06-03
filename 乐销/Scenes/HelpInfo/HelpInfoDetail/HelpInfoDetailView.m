//
//  HelpInfoDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/2.
//Copyright © 2020 ping. All rights reserved.
//

#import "HelpInfoDetailView.h"

@interface HelpInfoDetailView ()

@end

@implementation HelpInfoDetailView

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHelpList *)model{
    self.model = model;
    //重置视图坐标
    [self removeAllSubViews];
    CGFloat bottom = [self addAryLabel:@[^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"编号";
        item.subTitle = UnPackStr(model.helpNumber);
        return item;
    }(),^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"姓名";
        item.subTitle = UnPackStr(model.personName);
        return item;
    }(),^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"小区住址";
        item.subTitle = UnPackStr(model.addr);
        return item;
    }(),^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"联系方式";
        item.subTitle = UnPackStr(model.phone);
        item.isSelected = true;
        return item;
    }(),^(){
        ModelBtn * item = [ModelBtn new];
        item.title = @"";
        item.subTitle = @"";
        return item;
    }()] top:W(25)];
    //设置总高度
    self.height = bottom ;
}
- (CGFloat)addAryLabel:(NSArray *)ary top:(CGFloat)top{
    for (ModelBtn * item in ary) {
        if (isStr(item.title)) {
            UILabel * labelTitle = [UILabel new];
            labelTitle.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            labelTitle.textColor = COLOR_666;
            [labelTitle fitTitle:item.title variable:0];
            labelTitle.rightTop = XY(W(92), top);
            [self addSubview:labelTitle];
            
            UILabel * labelTitle1 = [UILabel new];
            labelTitle1.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
            labelTitle1.textColor = item.isSelected?COLOR_BLUE:COLOR_333;
            labelTitle1.leftTop = XY(W(122), top);
            labelTitle1.numberOfLines = 0;
            labelTitle1.lineSpace = W(10);
            [labelTitle1 fitTitle:item.subTitle variable:W(217)];
            [self addSubview:labelTitle1];
            
            if (item.isSelected) {
                [self addControlFrame:CGRectMake(0, labelTitle.top- W(10), SCREEN_WIDTH, labelTitle.height+W(20)) belowView:labelTitle target:self action:@selector(callPhone)];
            }
            
            top = MAX(labelTitle.bottom, labelTitle1.bottom)+W(20);
        }else{
            [self addLineFrame:CGRectMake(W(30), top, SCREEN_WIDTH - W(60), 1)];
            top += W(20);
        }
    }
    return top - W(20);
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark click
- (void)callPhone{
    if (isStr(self.model.phone)) {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        [GlobalMethod showAlert:@"暂无联系电话"];
    }

}

@end

@implementation HelpInfoDetailWebView
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_666;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_title fitTitle:@"求助事项" variable:0];
    }
    return _title;
}
- (UIWebView *)webDetail{
    if (!_webDetail) {
        _webDetail = [UIWebView new];
        _webDetail.delegate = self;
        _webDetail.width = W(217);
        _webDetail.height = 1;
        _webDetail.left = W(122);
        _webDetail.scrollView.showsVerticalScrollIndicator = false;
        _webDetail.scrollView.showsHorizontalScrollIndicator = false;
        _webDetail.scrollView.scrollEnabled = false;
    }
    return _webDetail;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHelpList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.title.rightTop = XY(W(92), W(20));
    self.webDetail.top = self.title.top;
    if (isStr(model.help)) {
            [self.webDetail loadHTMLString:UnPackStr(model.help) baseURL:nil];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight1 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webView.frame = CGRectMake(webView.frame.origin.x,webView.frame.origin.y, webView.frame.size.width, webViewHeight1);
    self.height = webView.bottom + W(35);
    if (self.blockWebRefresh) {
           self.blockWebRefresh();
    }
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = CGFLOAT_MIN;
        self.clipsToBounds = true;
        [self addSubView];//添加子视图
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.title];
    [self addSubview:self.webDetail];
}

@end

@implementation HelpInfoDetailBottomView
#pragma mark 懒加载
- (UILabel *)info{
    if (_info == nil) {
        _info = [UILabel new];
        _info.textColor = COLOR_333;
        _info.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_info fitTitle:@"社区救助办公室信息" variable:0];
    }
    return _info;
}
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
    }
    return _viewBG;
}
- (UILabel *)explainTitle{
    if (_explainTitle == nil) {
        _explainTitle = [UILabel new];
        _explainTitle.textColor = COLOR_666;
        _explainTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _explainTitle.numberOfLines = 0;
        _explainTitle.lineSpace = W(12);
    }
    return _explainTitle;
}
- (UILabel *)explain{
    if (_explain == nil) {
        _explain = [UILabel new];
        _explain.textColor = COLOR_333;
        _explain.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _explain;
}
- (UILabel *)flowTitle{
    if (_flowTitle == nil) {
        _flowTitle = [UILabel new];
        _flowTitle.textColor = COLOR_666;
        _flowTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _flowTitle;
}
- (UILabel *)flow{
    if (_flow == nil) {
        _flow = [UILabel new];
        _flow.textColor = COLOR_333;
        _flow.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _flow;
}
- (UILabel *)phontTitle{
    if (_phontTitle == nil) {
        _phontTitle = [UILabel new];
        _phontTitle.textColor = COLOR_666;
        _phontTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _phontTitle;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_333;
        _phone.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _phone;
}
- (UILabel *)alert{
    if (_alert == nil) {
        _alert = [UILabel new];
        _alert.textColor = COLOR_999;
        _alert.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
    }
    return _alert;
}
- (UIImageView *)lineLeft{
    if (_lineLeft == nil) {
        _lineLeft = [UIImageView new];
        _lineLeft.image = [UIImage imageNamed:@"dot_line"];
        _lineLeft.widthHeight = XY(W(96.5),W(1));
        _lineLeft.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _lineLeft;
}
- (UIImageView *)lineRight{
    if (_lineRight == nil) {
        _lineRight = [UIImageView new];
        _lineRight.image = [UIImage imageNamed:@"dot_line"];
        _lineRight.widthHeight = XY(W(96.5),W(1));
        _lineRight.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _lineRight;
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
        [self addSubview:self.info];
    [self addSubview:self.viewBG];
    [self addSubview:self.explainTitle];
    [self addSubview:self.explain];
    [self addSubview:self.flowTitle];
    [self addSubview:self.flow];
    [self addSubview:self.phontTitle];
    [self addSubview:self.phone];
    [self addSubview:self.alert];
    [self addSubview:self.lineLeft];
    [self addSubview:self.lineRight];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHelpList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view

    self.info.centerXTop = XY(SCREEN_WIDTH/2.0,0);
    self.lineLeft.rightCenterY = XY(self.info.left - W(15), self.info.centerY);
    self.lineRight.leftCenterY = XY(self.info.right + W(15), self.info.centerY);
    
    [self.explainTitle fitTitle:UnPackStr(model.internalBaseClassDescription) variable:SCREEN_WIDTH - W(100)];
    self.explainTitle.leftTop = XY(W(50),self.info.bottom+W(40));
   
    
    self.viewBG.widthHeight = XY(W(315), self.explainTitle.bottom - self.explainTitle.top + W(40));
    self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.explainTitle.top - W(20));
    [self.viewBG removeCorner];
    [self.viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    
    [self.alert fitTitle:@"请联系社区救助办公室，对需要的人进行救助" variable:0];
    self.alert.centerXTop = XY(SCREEN_WIDTH/2.0,self.viewBG.bottom+W(15));

    //设置总高度
    self.height = self.alert.bottom + W(30);
}

@end
