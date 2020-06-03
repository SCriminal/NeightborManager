//
//  ActivityDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/3.
//Copyright © 2020 ping. All rights reserved.
//

#import "ActivityDetailView.h"

@interface ActivityDetailView ()

@end

@implementation ActivityDetailView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(19) weight:UIFontWeightMedium];
        _title.numberOfLines = 0;
        _title.lineSpace = W(10);
    }
    return _title;
}
- (UILabel *)sender{
    if (_sender == nil) {
        _sender = [UILabel new];
        _sender.textColor = COLOR_666;
        _sender.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    }
    return _sender;
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
    [self addSubview:self.sender];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:UnPackStr(model.title) variable:W(345)];
    self.title.leftTop = XY(W(15),W(20));
    [self.sender fitTitle:[NSString stringWithFormat:@"发布方：%@",UnPackStr(model.creatorName)] variable:W(345)];
    self.sender.leftTop = XY(W(15),self.title.bottom+W(15));

    //设置总高度
    self.height = [self addLineFrame:CGRectMake(W(15), self.sender.bottom + W(25), SCREEN_WIDTH - W(30), 1)]+W(10);
}

@end

@implementation ActivityDetailWebView
- (UIWebView *)webDetail{
    if (!_webDetail) {
        _webDetail = [UIWebView new];
        _webDetail.delegate = self;
        _webDetail.width = SCREEN_WIDTH - W(20);
        _webDetail.height = 1;
        _webDetail.left = W(10);
        _webDetail.scrollView.showsVerticalScrollIndicator = false;
        _webDetail.scrollView.showsHorizontalScrollIndicator = false;
        _webDetail.scrollView.scrollEnabled = false;
    }
    return _webDetail;
}


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    self.webDetail.top = W(0);
    if (isStr(model.content)) {
            [self.webDetail loadHTMLString:UnPackStr(model.content) baseURL:nil];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat webViewHeight1 = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    webView.frame = CGRectMake(webView.frame.origin.x,webView.frame.origin.y, webView.frame.size.width, webViewHeight1);
    self.height = webView.bottom + W(0);
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
    [self addSubview:self.webDetail];
}

@end


@implementation ActivityDetailBottomView
#pragma mark 懒加载
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_333;
        _time.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _time.numberOfLines = 0;
        _time.lineSpace = W(10);
    }
    return _time;
}
- (UILabel *)info{
    if (_info == nil) {
        _info = [UILabel new];
        _info.textColor = COLOR_333;
        _info.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_info fitTitle:@"社团信息" variable:0];
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
        _flow.numberOfLines = 0;
        _flow.lineSpace = W(10);
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
- (UILabel *)commandorNameTitle{
    if (_commandorNameTitle == nil) {
        _commandorNameTitle = [UILabel new];
        _commandorNameTitle.textColor = COLOR_666;
        _commandorNameTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _commandorNameTitle;
}
- (UILabel *)commandorName{
    if (_commandorName == nil) {
        _commandorName = [UILabel new];
        _commandorName.textColor = COLOR_333;
        _commandorName.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _commandorName;
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
    [self addSubview:self.commandorNameTitle];
    [self addSubview:self.commandorName];
    [self addSubview:self.lineLeft];
    [self addSubview:self.lineRight];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model{
    [self removeAllSubViews];
    [self addSubview:self.time];
    [self.time fitTitle:UnPackStr(model.timeShow) variable:0];
    self.time.left = W(15);
    //刷新view
    {
        [self addSubView];
        //设置总高度
        self.info.centerXTop = XY(SCREEN_WIDTH/2.0,self.time.bottom+W(30));
          self.lineLeft.rightCenterY = XY(self.info.left - W(15), self.info.centerY);
          self.lineRight.leftCenterY = XY(self.info.right + W(15), self.info.centerY);
          
          [self.explainTitle fitTitle:@"社团名称：" variable:0];
          self.explainTitle.leftTop = XY(W(50),self.info.bottom+W(40));
        [self.explain fitTitle:UnPackStr(self.modelAssociation.name) variable:W(210)];
          self.explain.leftTop = XY(self.explainTitle.right,self.explainTitle.top);
          
          [self.flowTitle fitTitle:@"社团介绍：" variable:0];
          self.flowTitle.leftTop = XY(self.explainTitle.left,MAX(self.explain.bottom, self.explainTitle.bottom)+W(20));
          [self.flow fitTitle:UnPackStr(self.modelAssociation.internalBaseClassDescription)  variable:W(210)];
          self.flow.leftTop = XY(self.flowTitle.right,self.flowTitle.top);
          
          [self.phontTitle fitTitle:@"团长姓名：" variable:0];
          self.phontTitle.leftTop = XY(self.explainTitle.left,MAX(self.flow.bottom, self.flowTitle.bottom)+W(20));
          [self.phone fitTitle:UnPackStr(self.modelAssociation.leaderName) variable:W(210)];
          self.phone.leftTop = XY(self.phontTitle.right ,self.phontTitle.top);
        
        [self.commandorNameTitle fitTitle:@"联系电话：" variable:0];
        self.commandorNameTitle.leftTop = XY(self.explainTitle.left,MAX(self.phone.bottom, self.phontTitle.bottom)+W(20));
        [self.commandorName fitTitle:UnPackStr(self.modelAssociation.phone) variable:W(210)];
        self.commandorName.leftTop = XY(self.commandorNameTitle.right ,self.commandorNameTitle.top);

          
          self.viewBG.widthHeight = XY(W(315), MAX(self.commandorNameTitle.bottom, self.commandorName.bottom) - self.explain.top + W(40));
          self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.explain.top - W(20));
          [self.viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
          
          //设置总高度
          self.height = self.viewBG.bottom + W(30);
    }
}

@end



@implementation ActivityDetailApplicationView
#pragma mark 懒加载
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_333;
        _time.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _time.numberOfLines = 0;
        _time.lineSpace = W(10);
    }
    return _time;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_333;
        _num.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _num.numberOfLines = 0;
        _num.lineSpace = W(10);
    }
    return _num;
}

- (UILabel *)info{
    if (_info == nil) {
        _info = [UILabel new];
        _info.textColor = COLOR_333;
        _info.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        [_info fitTitle:@"报名居民" variable:0];
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

    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.info];
    [self addSubview:self.viewBG];
    [self addSubview:self.lineLeft];
    [self addSubview:self.lineRight];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model ary:(NSArray *)ary{
    [self removeAllSubViews];
    [self addSubview:self.time];
    [self addSubview:self.num];
    
    [self.time fitTitle:UnPackStr(model.timeShow) variable:0];
    self.time.left = W(15);
    
    [self.num fitTitle:[NSString stringWithFormat:@"报名人数:%ld",ary.count] variable:0];
    self.num.leftTop = XY(W(15), self.time.bottom + W(15)) ;

    if (ary.count == 0) {
        self.height = self.num.bottom + W(50);
        return;
    }
    
    //刷新view
    {
        [self addSubView];
        //设置总高度
        self.info.centerXTop = XY(SCREEN_WIDTH/2.0,self.num.bottom+W(30));
          self.lineLeft.rightCenterY = XY(self.info.left - W(15), self.info.centerY);
          self.lineRight.leftCenterY = XY(self.info.right + W(15), self.info.centerY);

          
        CGFloat top = self.info.bottom + W(20);
        for (int i = 0;i<ary.count ;i++) {
            ModelArchiveList *archive = ary[i];
            UIImageView * iconHead = [UIImageView new];
            iconHead.image = [UIImage imageNamed:IMAGE_HEAD_DEFAULT];
            iconHead.widthHeight = XY(W(50), W(50));
            iconHead.leftTop = XY(W(45), top+ W(15));
            [self addSubview:iconHead];
            
            UILabel * labelName = [UILabel new];
            labelName.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
            labelName.textColor = COLOR_333;
            [labelName fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(archive.realName),UnPackStr(archive.cellPhone)] variable:W(200)];
            labelName.leftTop = XY(iconHead.right + W(10), iconHead.top + W(2));
            [self addSubview:labelName];
            
            UILabel * labelAddress = [UILabel new];
                       labelAddress.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightMedium];
                       labelAddress.textColor = COLOR_999;
                       [labelAddress fitTitle:[NSString stringWithFormat:@"%@ %@号楼%@单元%@",UnPackStr(archive.estateName),UnPackStr(archive.buildingName),UnPackStr(archive.unitName),UnPackStr(archive.roomName)] variable:W(200)];
                       labelAddress.leftBottom = XY(iconHead.right + W(10), iconHead.bottom - W(2));
                       [self addSubview:labelAddress];
            
            if (i != ary.count - 1) {
                [self addLineFrame:CGRectMake(W(45), iconHead.bottom + W(15), SCREEN_WIDTH - W(90), 1)];
            }
            top = iconHead.bottom + W(15);
        }
          self.viewBG.widthHeight = XY(W(315), top - self.info.bottom + W(20));
          self.viewBG.centerXTop = XY(SCREEN_WIDTH/2.0,self.info.bottom + W(20));
        
        [self.viewBG removeCorner];
        [self.viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];

          //设置总高度
          self.height = self.viewBG.bottom + W(30);
    }
}

@end
