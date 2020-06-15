//
//  SendWhistleView.m
//  Neighbor
//
//  Sendd by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "SendWhistleView.h"

@interface SendWhistleTopView ()<UITextViewDelegate>
@property (strong, nonatomic) UILabel *addPhoto;
@property (strong, nonatomic) UILabel *problemDescription;
@property (strong, nonatomic) UILabel *myInfo;
@end

@implementation SendWhistleTopView

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
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), 0, 0, 0);
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请填写问题描述..."];
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
        [_addPhoto fitTitle:@"可添加一个近景和两个角度的远景照片（非必填）" variable:0];
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
        [_problemDescription fitTitle:@"问题描述" variable:0];

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
        [_myInfo fitTitle:@"发哨信息" variable:0];
    }
    return _myInfo;
}


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
    self.addPhoto.leftTop = XY(W(25), W(15));
    
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



@interface SendWhistleMidView ()<UITextViewDelegate>
@property (strong, nonatomic) UILabel *problemDescription;
@property (strong, nonatomic) UILabel *myInfo;
@end

@implementation SendWhistleMidView


- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.delegate = self;
        _textView.textContainerInset = UIEdgeInsetsMake(-W(2), 0, 0, 0);
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请填写吹哨原因..."];
        [_textView setTextColor:COLOR_333];
    }
    return _textView;
}
- (UILabel *)problemDescription{
    if (_problemDescription == nil) {
        _problemDescription = [UILabel new];
        _problemDescription.textColor = COLOR_999;
        _problemDescription.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _problemDescription.numberOfLines = 1;
        _problemDescription.lineSpace = 0;
        [_problemDescription fitTitle:@"吹哨原因" variable:0];

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
        [_myInfo fitTitle:@"吹哨信息" variable:0];
    }
    return _myInfo;
}


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
    [self addSubview:self.textView];
    [self addSubview:self.problemDescription];
    [self addSubview:self.myInfo];
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.problemDescription.leftTop = XY(W(25), W(15));
    
    UIView * viewWhite = [UIView new];
    viewWhite.backgroundColor = [UIColor whiteColor];
    viewWhite.widthHeight = XY(W(345), W(75));
    viewWhite.centerXTop = XY(SCREEN_WIDTH/2.0, self.problemDescription.bottom + W(15));
    [viewWhite addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:0 lineColor:[UIColor clearColor]];
    [self insertSubview:viewWhite belowSubview:self.textView];
    
    self.textView.widthHeight = XY(SCREEN_WIDTH - W(60), W(45));
    self.textView.centerXCenterY = viewWhite.centerXCenterY;
    
    self.myInfo.leftTop = XY(self.problemDescription.left,viewWhite.bottom+W(15));

    self.height = self.myInfo.bottom + W(15);
    
}
@end
