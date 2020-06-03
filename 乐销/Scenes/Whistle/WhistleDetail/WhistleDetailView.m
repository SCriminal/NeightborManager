//
//  WhistleDetailView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/18.
//Copyright © 2020 ping. All rights reserved.
//

#import "WhistleDetailView.h"



@implementation WhistleDetailTopView
#pragma mark 懒加载
- (UILabel *)IDTitle{
    if (_IDTitle == nil) {
        _IDTitle = [UILabel new];
        _IDTitle.textColor = COLOR_666;
        _IDTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_IDTitle fitTitle:@"吹哨编号" variable:0];

    }
    return _IDTitle;
}
- (UILabel *)IDNumber{
    if (_IDNumber == nil) {
        _IDNumber = [UILabel new];
        _IDNumber.textColor = COLOR_333;
        _IDNumber.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _IDNumber;
}
- (UILabel *)timeTitle{
    if (_timeTitle == nil) {
        _timeTitle = [UILabel new];
        _timeTitle.textColor = COLOR_666;
        _timeTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_timeTitle fitTitle:@"吹哨时间" variable:0];

    }
    return _timeTitle;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_333;
        _time.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _time;
}

- (UILabel *)nameTtitle{
    if (_nameTtitle == nil) {
        _nameTtitle = [UILabel new];
        _nameTtitle.textColor = COLOR_666;
        _nameTtitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_nameTtitle fitTitle:@"居民姓名" variable:0];
    }
    return _nameTtitle;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _name;
}
- (UILabel *)addressTitle{
    if (_addressTitle == nil) {
        _addressTitle = [UILabel new];
        _addressTitle.textColor = COLOR_666;
        _addressTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_addressTitle fitTitle:@"小区地址" variable:0];

    }
    return _addressTitle;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_333;
        _address.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _address.numberOfLines = 0;
        _address.lineSpace = W(8);

    }
    return _address;
}
- (UILabel *)phoneTitle{
    if (_phoneTitle == nil) {
        _phoneTitle = [UILabel new];
        _phoneTitle.textColor = COLOR_666;
        _phoneTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        [_phoneTitle fitTitle:@"联系电话" variable:0];

    }
    return _phoneTitle;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_BLUE;
        _phone.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _phone;
}


- (UILabel *)problem{
    if (_problem == nil) {
        _problem = [UILabel new];
        _problem.textColor = COLOR_666;
        _problem.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _problem.numberOfLines = 1;
        _problem.lineSpace = 0;
    }
    return _problem;
}
- (UILabel *)problemDetail{
    if (_problemDetail == nil) {
        _problemDetail = [UILabel new];
        _problemDetail.textColor = COLOR_333;
        _problemDetail.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _problemDetail.numberOfLines = 0;
        _problemDetail.lineSpace = W(10);
    }
    return _problemDetail;
}
- (UILabel *)photo{
    if (_photo == nil) {
        _photo = [UILabel new];
        _photo.textColor = COLOR_666;
        _photo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _photo.numberOfLines = 1;
        _photo.lineSpace = 0;
    }
    return _photo;
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
    [self addSubview:self.IDTitle];
    [self addSubview:self.IDNumber];
    [self addSubview:self.timeTitle];
    [self addSubview:self.time];

    [self addSubview:self.problem];
    [self addSubview:self.problemDetail];
    [self addSubview:self.photo];
    [self addSubview:self.nameTtitle];
    [self addSubview:self.name];
    [self addSubview:self.addressTitle];
    [self addSubview:self.address];
    [self addSubview:self.phoneTitle];
    [self addSubview:self.phone];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelWhistleList *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线

    self.IDTitle.rightTop = XY(W(92),W(25));
    [self.IDNumber fitTitle:UnPackStr(model.serialNumber) variable:0];
    self.IDNumber.leftTop = XY(W(122),self.IDTitle.top);

    
    self.nameTtitle.rightTop = XY(W(92),self.IDTitle.bottom+W(20));
    [self.name fitTitle:UnPackStr(model.realName) variable:0];
    self.name.leftTop = XY(W(122),self.nameTtitle.top);
    
    self.timeTitle.rightTop = XY(W(92),self.nameTtitle.bottom+W(20));
    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.whistleTime andFormatter:TIME_HOUR_SHOW] variable:0];
    self.time.leftTop = XY(W(122),self.timeTitle.top);

    self.addressTitle.rightTop = XY(W(92),self.timeTitle.bottom+W(20));
    [self.address fitTitle:[NSString stringWithFormat:@"%@/%@号楼/%@单元/%@室",UnPackStr(model.estateName),UnPackStr(model.buildingName),UnPackStr(model.unitName),UnPackStr(model.roomName)] variable:W(220)];
    self.address.leftTop = XY(W(122),self.addressTitle.top);

    self.phoneTitle.rightTop = XY(W(92),self.address.bottom+W(20));
    [self.phone fitTitle:UnPackStr(model.cellPhone) variable:0];
    self.phone.leftTop = XY(W(122),self.address.bottom+W(20));

   UIView * con =  [self addControlFrame:CGRectMake(0, self.phone.top- W(10), SCREEN_WIDTH, self.phone.height + W(20)) belowView:self.phone target:self action:@selector(phoneClick)];
    con.tag = TAG_LINE;
    
    //刷新view
    [self.problem fitTitle:@"问题描述" variable:0];
    self.problem.rightTop = XY(W(92),[self addLineFrame:CGRectMake(W(30), self.phone.bottom + W(20), SCREEN_WIDTH - W(60), 1)]+W(20));
    [self.problemDetail fitTitle:UnPackStr(model.iDPropertyDescription) variable:SCREEN_WIDTH - self.problem.right - W(60)];
    self.problemDetail.leftTop = XY( W(122),self.problem.top);
    [self.photo fitTitle:@"照片信息" variable:0];
    self.photo.rightTop = XY(W(92),[self addLineFrame:CGRectMake(W(30), MAX(self.problemDetail.bottom, self.problem.bottom)+W(17), SCREEN_WIDTH - W(60), 1)]+W(20));

    //设置总高度
    self.height = self.photo.bottom;
}

- (void)phoneClick{
    if (isStr(self.model.cellPhone)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",self.model.cellPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
@end



@implementation WhistleDetailStatusView
#pragma mark 懒加载
- (UILabel *)progress{
    if (_progress == nil) {
        _progress = [UILabel new];
        _progress.textColor = COLOR_666;
        _progress.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _progress.numberOfLines = 1;
        _progress.lineSpace = 0;
        [_progress fitTitle:@"处理进度" variable:0];
    }
    return _progress;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_666;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
        [_title fitTitle:@"处理状态" variable:0];
    }
    return _title;
}
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

- (UIView *)labelBg{
    if (_labelBg == nil) {
        _labelBg = [UIView new];
        _labelBg.backgroundColor = COLOR_ORANGE;
        
    }
    return _labelBg;
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
    [self addSubview:self.title];
    [self addSubview:self.labelBg];
    [self addSubview:self.status];
    [self addSubview:self.progress];

}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelWhistleList *)model{
    [self removeAllSubViews];//移除线
    [self addSubView];
    [self addLineFrame:CGRectMake(W(30), 0, SCREEN_WIDTH - W(60), 1)];
    //刷新view
    self.title.leftTop = XY(W(30), W(25));
    
    [self.status fitTitle:UnPackStr(model.statusShow) variable:0];
    
    self.labelBg.widthHeight = XY(self.status.width + W(13), W(18));
    self.labelBg.leftCenterY = XY(self.title.right + W(30),self.title.centerY);
    self.labelBg.backgroundColor = model.statusColorShow;
    [self.labelBg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0 lineColor:[UIColor clearColor]];
    
    self.status.center = self.labelBg.center;
    
    self.progress.leftTop = XY(W(30), self.title.bottom+W(17));

    NSMutableArray * aryDatas = [NSMutableArray new];
    [aryDatas addObject:^(){
        ModelBaseData * modelItem = [ModelBaseData new];
        modelItem.string = [GlobalMethod exchangeTimeWithStamp:model.whistleTime andFormatter:TIME_MIN_SHOW];
        modelItem.subString = @"居民:";
        modelItem.thirdString = @"发起吹哨";
        modelItem.isSelected = true;
        return modelItem;
    }()];
    if (model.status!=1) {
        if (model.isPlatform==0) {
            [aryDatas addObject:^(){
                ModelBaseData * modelItem = [ModelBaseData new];
                modelItem.string = [GlobalMethod exchangeTimeWithStamp:model.pushTime andFormatter:TIME_MIN_SHOW];
                modelItem.subString = @"社区:";
                modelItem.thirdString = @"已吹哨";
                modelItem.isSelected = true;
                return modelItem;
            }()];
            if (isAry(model.results)) {
                for (ModelWhistleProgress *item in model.results) {
                    [aryDatas addObject:^(){
                        ModelBaseData * modelItem = [ModelBaseData new];
                        modelItem.string = UnPackStr(item.opsTime);
                        modelItem.subString = [NSString stringWithFormat:@"%@:",item.deptName];
                        modelItem.thirdString = item.internalBaseClassDescription;
                        return modelItem;
                    }()];
                }
            }
        }else{
            [aryDatas addObject:^(){
                ModelBaseData * modelItem = [ModelBaseData new];
                modelItem.string = [GlobalMethod exchangeTimeWithStamp:model.handleTime andFormatter:TIME_MIN_SHOW];
                modelItem.subString = @"社区:";
                modelItem.thirdString = UnPackStr(model.result);
                return modelItem;
            }()];
        }
    }
   
    //设置总高度
    self.height = [self addDot:aryDatas top:self.progress.top +W(1)];
}
- (CGFloat)addDot:(NSArray *)aryBtns top:(CGFloat)top{
    for (int i = 0; i<aryBtns.count; i++) {
        ModelBaseData * modelData = aryBtns[i];

        UILabel * labelTime = [UILabel new];
        labelTime.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        labelTime.textColor = COLOR_999;
        [labelTime fitTitle:modelData.string variable:0];
        labelTime.leftTop = XY(W(144), top);
        [self addSubview:labelTime];
        
        UILabel * label = [UILabel new];
        label.fontNum = F(15);
        label.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];

        label.textColor = COLOR_333;
        [label fitTitle:modelData.subString variable:0];
        label.leftTop = XY(labelTime.left, labelTime.bottom +W(10));
        [self addSubview:label];
        
        UILabel * labelSub = [UILabel new];
        labelSub.fontNum = F(15);
        labelSub.textColor = COLOR_333;
        labelSub.numberOfLines = 0;
        [labelSub fitTitle:modelData.thirdString variable:W(200)];
        
        labelSub.leftTop = modelData.isSelected?XY(label.right+W(3), label.top):XY(labelTime.left, label.bottom +W(10));
        [self addSubview:labelSub];
        
        UIView * viewDot = [UIView new];
        viewDot.widthHeight = XY(W(7), W(7));
        [GlobalMethod setRoundView:viewDot color:[UIColor clearColor] numRound:viewDot.width/2.0 width:0];
        viewDot.backgroundColor = i==aryBtns.count -1?COLOR_ORANGE:[UIColor colorWithHexString:@"EFF2F1"];
        viewDot.leftCenterY = XY(W(122), labelTime.centerY);
        if (i!=aryBtns.count -1) {
            [self addLineFrame:CGRectMake(viewDot.centerX, viewDot.centerY, 1, labelSub.bottom-labelTime.centerY + W(25)+labelTime.height/2.0) color:[UIColor colorWithHexString:@"EFF2F1"]];
        }
        [self addSubview:viewDot];
        top = labelSub.bottom + W(25);
    
    }
    return top+W(2);
}

@end



@implementation WhistleDetailAddCommentView
#pragma mark 懒加载
- (UILabel *)comment{
    if (_comment == nil) {
        _comment = [UILabel new];
        _comment.textColor = COLOR_333;
        _comment.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _comment.numberOfLines = 1;
        _comment.lineSpace = 0;
        [_comment fitTitle:@"我要评价" variable:0];
    }
    return _comment;
}
- (UILabel *)satisfaction{
    if (_satisfaction == nil) {
        _satisfaction = [UILabel new];
        _satisfaction.textColor = COLOR_666;
        _satisfaction.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _satisfaction.numberOfLines = 1;
        _satisfaction.lineSpace = 0;
        [_satisfaction fitTitle:@"满意程度" variable:0];

    }
    return _satisfaction;
}
- (UILabel *)content{
    if (_content == nil) {
        _content = [UILabel new];
        _content.textColor = COLOR_666;
        _content.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _content.numberOfLines = 1;
        _content.lineSpace = 0;
        [_content fitTitle:@"评论内容" variable:0];

    }
    return _content;
}
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
//        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请输入评价内容…"];
        [_textView setTextColor:COLOR_333];
    }
    return _textView;
}
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = COLOR_LINE;
        _viewBG.widthHeight = XY(W(223), W(80));
        _viewBG.backgroundColor = [UIColor colorWithHexString:@"FCFCFC"];
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"EFF2F1"]];
        

    }
    return _viewBG;
}
- (CommentStarView *)starView{
    if (!_starView) {
        _starView = [CommentStarView new];
        _starView.isShowGrayStarBg = true;
        _starView.interval = W(12);
        [_starView configDefaultView];
        _starView.userInteractionEnabled = true;
    }
    return _starView;
}
- (YellowButton *)btn{
    if (!_btn) {
        _btn = [YellowButton new];
        [_btn resetViewWithWidth:W(315) :W(45) :@"提交"];
        
    }
    return _btn;
}
#pragma mark 懒加载
- (UIImageView *)lineLeft{
    if (_lineLeft == nil) {
        _lineLeft = [UIImageView new];
        _lineLeft.image = [UIImage imageNamed:@"signin_line"];
        _lineLeft.widthHeight = XY(W(117.5),W(1));
    }
    return _lineLeft;
}
- (UIImageView *)lineRight{
    if (_lineRight == nil) {
        _lineRight = [UIImageView new];
        _lineRight.image = [UIImage imageNamed:@"signin_line"];
        _lineRight.widthHeight = XY(W(117.5),W(1));
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
    [self addSubview:self.comment];
    [self addSubview:self.satisfaction];
    [self addSubview:self.content];
    [self addSubview:self.viewBG];
    [self addSubview:self.textView];
    [self addSubview:self.starView];
    [self addSubview:self.btn];
    [self addSubview:self.lineLeft];
    [self addSubview:self.lineRight];

    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.comment.centerXTop = XY(SCREEN_WIDTH/2.0,0);
    self.lineLeft.rightCenterY = XY(self.comment.left - W(15), self.comment.centerY);
    self.lineRight.leftCenterY = XY(self.comment.right + W(15), self.comment.centerY);

    
    self.satisfaction.leftTop = XY(W(30),self.comment.bottom+W(17));
    self.starView.leftCenterY = XY(self.satisfaction.right + W(30),self.satisfaction.centerY);


    self.content.leftTop = XY(W(30),self.satisfaction.bottom+W(33));
    
    self.viewBG.leftTop = XY(W(122),self.content.top-W(15));

    self.textView.widthHeight = XY(self.viewBG.width - W(30),self.viewBG.height -  W(30));
    self.textView.leftTop = XY(self.viewBG.left + W(15),self.viewBG.top+W(15));
    
    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0, self.viewBG.bottom + W(20));
    
    //设置总高度
    self.height = self.btn.bottom + W(20);
}

@end



@implementation WhistleDetailCommentDetailView
#pragma mark 懒加载
- (UILabel *)comment{
    if (_comment == nil) {
        _comment = [UILabel new];
        _comment.textColor = COLOR_333;
        _comment.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _comment.numberOfLines = 0;
        _comment.lineSpace = W(5);
    }
    return _comment;
}
- (UILabel *)satisfaction{
    if (_satisfaction == nil) {
        _satisfaction = [UILabel new];
        _satisfaction.textColor = COLOR_666;
        _satisfaction.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _satisfaction.numberOfLines = 1;
        _satisfaction.lineSpace = 0;
        [_satisfaction fitTitle:@"满意程度" variable:0];
        
    }
    return _satisfaction;
}
- (UILabel *)content{
    if (_content == nil) {
        _content = [UILabel new];
        _content.textColor = COLOR_666;
        _content.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _content.numberOfLines = 1;
        _content.lineSpace = 0;
        [_content fitTitle:@"评论内容" variable:0];
        
    }
    return _content;
}
- (CommentStarView *)starView{
    if (!_starView) {
        _starView = [CommentStarView new];
        _starView.isShowGrayStarBg = true;
        _starView.interval = W(12);
        [_starView configDefaultView];
        _starView.userInteractionEnabled = false;
    }
    return _starView;
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
    [self addSubview:self.comment];
    [self addSubview:self.satisfaction];
    [self addSubview:self.content];
    [self addSubview:self.starView];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelWhistleList *)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    [self addLineFrame:CGRectMake(W(30), 0, SCREEN_WIDTH - W(60), 1)];
    //刷新view
    
    
    self.satisfaction.leftTop = XY(W(30),W(25));
    self.starView.leftCenterY = XY(self.satisfaction.right + W(30),self.satisfaction.centerY);
    [self.starView setCurrentScore:model.score];
    

    self.content.leftTop = XY(W(30),self.satisfaction.bottom+W(17));
    
    [self.comment fitTitle:UnPackStr(model.evaluation) variable:W(220)];
    self.comment.leftTop = XY(self.satisfaction.right + W(30),self.content.top);

    //设置总高度
    self.height = self.comment.bottom + W(20);
}

@end



@implementation WhistleDetailDisposaView
#pragma mark 懒加载
- (YellowButton *)btnDisposal{
    if (!_btnDisposal) {
        _btnDisposal = [YellowButton new];
        [_btnDisposal resetViewWithWidth:W(315) :W(45) :@"立即处理"];
    }
    return _btnDisposal;
}
- (YellowButton *)btnCreate{
    if (!_btnCreate) {
        _btnCreate = [YellowButton new];
        [_btnCreate resetWhiteViewWithWidth:W(315) :W(45) :@"发起吹哨"];

    }
    return _btnCreate;
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
    [self addSubview:self.btnDisposal];
    [self addSubview:self.btnCreate];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnDisposal.centerXTop = XY(SCREEN_WIDTH/2.0,0);

    self.btnCreate.centerXTop = XY(SCREEN_WIDTH/2.0,self.btnDisposal.bottom+W(20));
    
    //设置总高度
    self.height = self.btnCreate.bottom+iphoneXBottomInterval+ W(30);
}

@end
