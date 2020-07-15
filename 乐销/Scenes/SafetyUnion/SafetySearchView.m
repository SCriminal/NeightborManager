//
//  SafetySearchView.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "SafetySearchView.h"

@interface SafetySearchView ()

@end

@implementation SafetySearchView
- (UIImageView *)iconClose{
    if (!_iconClose) {
        _iconClose = [UIImageView new];
        _iconClose.backgroundColor = [UIColor clearColor];
        _iconClose.contentMode = UIViewContentModeScaleAspectFill;
        _iconClose.clipsToBounds = true;
        _iconClose.image = [UIImage imageNamed:@"shopping_Seach"];
        _iconClose.highlightedImage = [UIImage imageNamed:@"inputClose"];
        _iconClose.widthHeight = XY(W(25),W(25));
        _iconClose.rightCenterY = XY(self.btnSearch.widthHeight.horizonX-W(30), self.btnSearch.widthHeight.verticalY/2.0);
    }
    return _iconClose;
}
- (UIButton *)btnSearch{
    if (_btnSearch == nil) {
        
        _btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSearch.tag = 1;
        [_btnSearch addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnSearch.backgroundColor = [UIColor clearColor];
        _btnSearch.widthHeight = XY(W(65),NAVIGATIONBAR_HEIGHT-STATUSBAR_HEIGHT);
        [_btnSearch addSubview:self.iconClose];
    }
    return _btnSearch;
}
- (UITextField *)tfSearch{
    if (_tfSearch == nil) {
        _tfSearch = [UITextField new];
        _tfSearch.font = [UIFont systemFontOfSize:F(13)];
        _tfSearch.textAlignment = NSTextAlignmentLeft;
        _tfSearch.placeholder = @"请选择小区";
        _tfSearch.borderStyle = UITextBorderStyleNone;
        _tfSearch.backgroundColor = [UIColor clearColor];
        _tfSearch.delegate = self;
        _tfSearch.enabled = false;
    }
    return _tfSearch;
}

- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = ^(){
            UIView *view = [[UIView alloc] init];
            view.widthHeight = XY(SCREEN_WIDTH - W(30), W(37));
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
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.height = self.viewBG.height + W(20);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.viewBG];
    [self addSubview:self.btnSearch];
    [self.btnSearch addSubview:self.iconClose];
    [self addSubview:self.tfSearch];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    
    //刷新view

    self.viewBG.leftCenterY = XY(W(15),self.height/2.0);
    
    self.btnSearch.rightCenterY = XY(SCREEN_WIDTH,self.viewBG.centerY);
    self.tfSearch.widthHeight = XY(self.viewBG.width - W(60), self.tfSearch.font.lineHeight);
    self.tfSearch.leftCenterY = XY( self.viewBG.left + W(15),self.viewBG.centerY+W(2));
}
#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    if (self.iconClose.highlighted) {
        if (self.blockClose) {
            self.blockClose();
        }
    }else{
        [self viewBGClick];
    }
}

- (void)viewBGClick{
    if (self.blockSearch) {
        self.blockSearch();
    }
}
@end
