//
//  SelectCommunityView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCommunityView.h"

@interface SelectCommunityTopView ()

@end

@implementation SelectCommunityTopView
#pragma mark 懒加载
- (UIControl *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIControl new];
        _backBtn.tag = TAG_KEYBOARD;
        [_backBtn addTarget:self action:@selector(btnBackClick) forControlEvents:UIControlEventTouchUpInside];
        [BaseNavView resetControl:_backBtn imageName:@"back_black" imageSize:CGSizeMake(W(25), W(25)) isLeft:true];
        _backBtn.width = W(40);
    }
    return _backBtn;
}
- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.tag = 1;
        [_btnSearch addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnSearch.backgroundColor = [UIColor clearColor];
        _btnSearch.widthHeight = XY(W(55),W(45));
        STRUCT_XY wh = _btnSearch.widthHeight;
        [_btnSearch addSubview:^(){
            UIImageView * iv = [UIImageView new];
            iv.image = [UIImage imageNamed:@"shopping_Seach"];
            iv.widthHeight = XY(W(25), W(25));
            iv.rightCenterY = XY(wh.horizonX-W(15), wh.verticalY/2.0);
            return iv;
        }()];
    }
    return _btnSearch;
}
- (UITextField *)tfSearch{
    if (_tfSearch == nil) {
        _tfSearch = [UITextField new];
        _tfSearch.font = [UIFont systemFontOfSize:F(13)];
        _tfSearch.textAlignment = NSTextAlignmentLeft;
        _tfSearch.placeholder = @"请输入小区名称";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.delegate = self;
        [_tfSearch addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _tfSearch;
}

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = ^(){
            UIView *view = [[UIView alloc] init];
            view.widthHeight = XY(SCREEN_WIDTH - W(50), W(45));
            view.layer.borderWidth = 0.5;
            view.layer.borderColor = [UIColor colorWithRed:239/255.0 green:242/255.0 blue:241/255.0 alpha:1.0].CGColor;
            
            view.layer.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0].CGColor;
            view.layer.cornerRadius = 10;
            return view;
        }();
        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}

- (UILabel *)select{
    if (_select == nil) {
        _select = [UILabel new];
        _select.textColor = COLOR_333;
        _select.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _select.numberOfLines = 1;
        _select.lineSpace = 0;
        [_select fitTitle:@"请选择" variable:0];
        
    }
    return _select;
}
- (UILabel *)district{
    if (_district == nil) {
        _district = [UILabel new];
        _district.textColor = COLOR_333;
        _district.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        _district.numberOfLines = 1;
        _district.lineSpace = 0;
        [_district fitTitle:@"您所在的小区" variable:0];
    }
    return _district;
}
- (UIImageView *)location{
    if (_location == nil) {
        _location = [UIImageView new];
        _location.image = [UIImage imageNamed:@"community_local"];
        _location.widthHeight = XY(W(25),W(25));
    }
    return _location;
}
- (UILabel *)vague{
    if (_vague == nil) {
        _vague = [UILabel new];
        _vague.textColor = [UIColor colorWithHexString:@"#FC8B3C"];
        _vague.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightMedium];
        _vague.numberOfLines = 1;
        _vague.lineSpace = 0;
        [_vague fitTitle:@"手动选择" variable:0];
        
    }
    return _vague;
}


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = W(50);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self addSubview:self.tfSearch];
    [self addSubview:self.select];
    [self addSubview:self.district];
    [self addSubview:self.location];
    [self addSubview:self.vague];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    self.select.leftTop = XY(W(25),[GlobalData sharedInstance].community.iDProperty?NAVIGATIONBAR_HEIGHT+W(20):(W(58)+iphoneXTopInterval));

    self.district.leftTop = XY(W(25),self.select.bottom+W(10));
    
    self.location.leftCenterY = XY(self.district.right + W(8),self.district.centerY);

    self.viewBG.leftTop = XY(W(25),self.district.bottom + W(35));
    
    self.btnSearch.rightCenterY = XY(self.viewBG.right,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(80), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY+W(2));
    
    self.vague.rightCenterY = XY(SCREEN_WIDTH - W(25),self.location.centerY);
    [self addControlFrame:CGRectInset(self.vague.frame, -W(50), -W(50)) belowView:self.vague target:self action:@selector(manualClick)];

    self.height = self.viewBG.bottom + W(30);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GlobalMethod endEditing];
    NSString * strKey = self.tfSearch.text;
    //    if (strKey.length <2) {
    //        [GlobalMethod showAlert:@"请输入有效数据"];
    //        return;
    //    }
    //    NSArray *aryStr = @[@"物流",@"公司",@"运输",@"集装箱",@"海运",@"货代",@"货",@"代",@"运",@"货运",@"货运代理"];
    //    for (NSString * strItem in aryStr) {
    //        if ([strItem rangeOfString:strKey].location != NSNotFound) {
    //            [GlobalMethod showAlert:@"请输入有效数据"];
    //            return;
    //        }
    //    }
    
    if (self.blockSearch) {
        self.blockSearch(strKey);
    }
}

#pragma mark click
- (void)btnBackClick{
    [GB_Nav popViewControllerAnimated:true];
}
- (void)manualClick{
    [GB_Nav pushVCName:@"SelectCommunityCityVC" animated:true];
}
#pragma mark textfield delegate
- (void)textFileAction:(UITextField *)tf{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}
@end

@implementation ManualSelectCommunityTopView
#pragma mark 懒加载
- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.tag = 1;
        [_btnSearch addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnSearch.backgroundColor = [UIColor clearColor];
        _btnSearch.widthHeight = XY(W(55),W(45));
        STRUCT_XY wh = _btnSearch.widthHeight;
        [_btnSearch addSubview:^(){
            UIImageView * iv = [UIImageView new];
            iv.image = [UIImage imageNamed:@"shopping_Seach"];
            iv.widthHeight = XY(W(25), W(25));
            iv.rightCenterY = XY(wh.horizonX-W(15), wh.verticalY/2.0);
            return iv;
        }()];
    }
    return _btnSearch;
}
- (UITextField *)tfSearch{
    if (_tfSearch == nil) {
        _tfSearch = [UITextField new];
        _tfSearch.font = [UIFont systemFontOfSize:F(13)];
        _tfSearch.textAlignment = NSTextAlignmentLeft;
        _tfSearch.placeholder = @"请输入小区名称";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.delegate = self;
        [_tfSearch addTarget:self action:@selector(textFileAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _tfSearch;
}

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = ^(){
            UIView *view = [[UIView alloc] init];
            view.widthHeight = XY(SCREEN_WIDTH - W(50), W(45));
            view.layer.borderWidth = 0.5;
            view.layer.borderColor = [UIColor colorWithRed:239/255.0 green:242/255.0 blue:241/255.0 alpha:1.0].CGColor;
            
            view.layer.backgroundColor = [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0].CGColor;
            view.layer.cornerRadius = 10;
            return view;
        }();
        [_viewBG addTarget:self action:@selector(viewBGClick)];
    }
    return _viewBG;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.width = SCREEN_WIDTH;
        self.height = W(50);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self addSubview:self.tfSearch];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view
    
    self.viewBG.leftTop = XY(W(25),  W(23));
    
    self.btnSearch.rightCenterY = XY(self.viewBG.right,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(80), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY+W(2));
    
    
    self.height = self.viewBG.bottom + W(25);
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    [GlobalMethod endEditing];
    NSString * strKey = self.tfSearch.text;
    //    if (strKey.length <2) {
    //        [GlobalMethod showAlert:@"请输入有效数据"];
    //        return;
    //    }
    //    NSArray *aryStr = @[@"物流",@"公司",@"运输",@"集装箱",@"海运",@"货代",@"货",@"代",@"运",@"货运",@"货运代理"];
    //    for (NSString * strItem in aryStr) {
    //        if ([strItem rangeOfString:strKey].location != NSNotFound) {
    //            [GlobalMethod showAlert:@"请输入有效数据"];
    //            return;
    //        }
    //    }
    
    if (self.blockSearch) {
        self.blockSearch(strKey);
    }
}

#pragma mark textfield delegate
- (void)textFileAction:(UITextField *)tf{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [GlobalMethod endEditing];
    return true;
}
- (void)viewBGClick{
    [self.tfSearch becomeFirstResponder];
}
@end

@implementation SelectCommunityCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UIView *)BG{
    if (_BG == nil) {
        _BG = [UIView new];
        _BG.backgroundColor =[UIColor colorWithHexString:@"FFF4B6"];

    }
    return _BG;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.BG];
        [self.contentView addSubview:self.title];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCommunity *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.BG.widthHeight = XY(SCREEN_WIDTH - W(47.5)*2, W(45));
    [self.BG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"EFF2F1"]];

    self.BG.centerXTop = XY(SCREEN_WIDTH/2.0,W(15));
    [self.title fitTitle:model.name variable:self.BG.width - W(30)];
    self.title.centerXCenterY = self.BG.centerXCenterY;

    //设置总高度
    self.height = self.BG.bottom + W(15);
}

@end
