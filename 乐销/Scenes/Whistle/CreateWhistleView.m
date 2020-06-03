//
//  CreateWhistleView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateWhistleView.h"

@interface MCreateWhistleTopView ()<UITextViewDelegate>
@property (nonatomic, strong) BaseNavView *nav;
@property (nonatomic, strong) UIImageView *BG;
@property (strong, nonatomic) UIImageView *whiteBG;

@property (strong, nonatomic) UILabel *addPhoto;
@property (strong, nonatomic) UILabel *problemDescription;
@property (strong, nonatomic) UILabel *myInfo;
@end

@implementation MCreateWhistleTopView

- (Collection_Image *)collection_Image{
    if (!_collection_Image) {
        _collection_Image = [Collection_Image new];
        _collection_Image.isEditing = true;
        _collection_Image.width =  SCREEN_WIDTH - W(30);
        [_collection_Image resetWithAry:nil];
        
    }
    return _collection_Image;
}

- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请输入信息..."];
        [_textView setTextColor:COLOR_333];
    }
    return _textView;
}
- (UILabel *)addPhoto{
    if (_addPhoto == nil) {
        _addPhoto = [UILabel new];
        _addPhoto.textColor = COLOR_999;
        _addPhoto.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _addPhoto.numberOfLines = 1;
        _addPhoto.lineSpace = 0;
        [_addPhoto fitTitle:@"添加照片" variable:0];
    }
    return _addPhoto;
}
- (UILabel *)problemDescription{
    if (_problemDescription == nil) {
        _problemDescription = [UILabel new];
        _problemDescription.textColor = COLOR_999;
        _problemDescription.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _problemDescription.numberOfLines = 1;
        _problemDescription.lineSpace = 0;
        [_problemDescription fitTitle:@"准确描述可以更快的解决问题" variable:0];

    }
    return _problemDescription;
}
- (UILabel *)myInfo{
    if (_myInfo == nil) {
        _myInfo = [UILabel new];
        _myInfo.textColor = COLOR_999;
        _myInfo.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _myInfo.numberOfLines = 1;
        _myInfo.lineSpace = 0;
        [_myInfo fitTitle:@"我的信息" variable:0];
    }
    return _myInfo;
}


- (BaseNavView *)nav{
    if (!_nav) {
        _nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
        _nav.backgroundColor = [UIColor clearColor];
    }
    return _nav;
}
- (UIImageView *)BG{
    if (_BG == nil) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"whistle_topBG"];
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
        _BG.widthHeight = XY(SCREEN_WIDTH, W(135)+iphoneXTopInterval);
    }
    return _BG;
}
- (UIImageView *)whiteBG{
    if (_whiteBG == nil) {
        _whiteBG = [UIImageView new];
        _whiteBG.clipsToBounds = true;
        _whiteBG.backgroundColor = [UIColor clearColor];
        _whiteBG.widthHeight = XY(SCREEN_WIDTH,15);
        {
            UIView * view = [UIView new];
            view.backgroundColor = COLOR_GRAY;
            view.widthHeight = XY(SCREEN_WIDTH, 30);
            [view addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];
            [_whiteBG addSubview:view];
        }
    }
    return _whiteBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_GRAY;
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = true;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.BG];
    [self addSubview:self.nav];
    [self addSubview:self.whiteBG];
    [self addSubview:self.textView];
    [self addSubview:self.addPhoto];
    [self addSubview:self.problemDescription];
    [self addSubview:self.myInfo];
    [self addSubview:self.collection_Image];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.whiteBG.bottom = self.BG.bottom;
    self.addPhoto.leftTop = XY(W(25), self.BG.bottom );
    
    UIView * viewWhite = [UIView new];
    viewWhite.backgroundColor = [UIColor whiteColor];
    viewWhite.widthHeight = XY(W(345), W(119));
    viewWhite.centerXTop = XY(SCREEN_WIDTH/2.0, self.addPhoto.bottom + W(15));
     [viewWhite addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:viewWhite belowSubview:self.collection_Image];
    
    self.collection_Image.leftCenterY = XY(W(15), viewWhite.centerY);

    self.problemDescription.leftTop = XY(self.addPhoto.left,viewWhite.bottom+W(15));
    
    viewWhite = [UIView new];
    viewWhite.backgroundColor = [UIColor whiteColor];
    viewWhite.widthHeight = XY(W(345), W(75));
    viewWhite.centerXTop = XY(SCREEN_WIDTH/2.0, self.problemDescription.bottom + W(15));
    [viewWhite addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:viewWhite belowSubview:self.textView];
    
    self.textView.widthHeight = XY(SCREEN_WIDTH - W(60), W(45));
    self.textView.centerXCenterY = viewWhite.centerXCenterY;
    
    self.myInfo.leftTop = XY(self.addPhoto.left,viewWhite.bottom+W(15));

    self.height = self.myInfo.bottom + W(15);
    
}
@end
