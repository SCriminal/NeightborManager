//
//  PersonalCenterView.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "PersonalCenterView.h"
@interface PersonalCenterTopView ()

@end

@implementation PersonalCenterTopView
#pragma mark 懒加载
- (UIImageView *)bg{
    if (_bg == nil) {
        _bg = [UIImageView new];
        _bg.image = [UIImage imageNamed:@"personal_top_bg"];
        _bg.contentMode = UIViewContentModeScaleAspectFill;
        _bg.widthHeight = XY(SCREEN_WIDTH,W(15));
    }
    return _bg;
}
- (UIImageView *)head{
    if (_head == nil) {
        _head = [UIImageView new];
        _head.image = [UIImage imageNamed:@"personal_head"];
        _head.widthHeight = XY(W(65),W(65));
        _head.contentMode = UIViewContentModeScaleAspectFill;
        _head.clipsToBounds = true;
        [_head addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_head.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        [_head addTarget:self action:@selector(headClick)];
    }
    return _head;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = [UIColor blackColor];
        _name.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UIImageView *)whiteBg{
    if (_whiteBg == nil) {
        _whiteBg = [UIImageView new];
        _whiteBg.image = [UIImage imageNamed:@"personal_bg_white"];
        _whiteBg.widthHeight = XY(SCREEN_WIDTH,W(15));
    }
    return _whiteBg;
}
- (UIImageView *)headBG{
    if (_headBG == nil) {
        _headBG = [UIImageView new];
        _headBG.image = [UIImage imageNamed:@"personal_head_bg"];
        _headBG.widthHeight = XY(W(90),W(90));
        _headBG.backgroundColor = [UIColor clearColor];
    }
    return _headBG;
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.width = SCREEN_WIDTH;
        self.clipsToBounds = true;
        [self addSubView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetViewWithModel) name:NOTICE_SELFMODEL_CHANGE object:nil];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.bg];
//    [self addSubview:self.headBG];
    [self addSubview:self.head];
    [self addSubview:self.name];
//    [self addSubview:self.whiteBg];

    //初始化页面
    [self resetViewWithModel];
}

#pragma mark 刷新view
- (void)resetViewWithModel{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    ModelUser * model = [GlobalData sharedInstance].GB_UserModel;
    self.headBG.leftTop = XY(W(7.5),W(43.5)+iphoneXTopInterval);

    [self.head sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"personal_head"]];
    self.head.centerXCenterY = self.headBG.centerXCenterY;
  
    [self.name fitTitle:[GlobalMethod isLoginSuccess]?UnPackStr(model.nickname):@"您好，请登录" variable:0];
    self.name.leftCenterY = XY(self.headBG.right + W(7.5),self.headBG.centerY);

   
    //设置总高度
    self.height = self.headBG.bottom + W(35);
    self.bg.height = self.height;
    self.whiteBg.bottom = self.height;

}
- (void)headClick{
    if ([GlobalMethod isLoginSuccess]) {
    }else{
        [GB_Nav pushVCName:@"LoginViewController" animated:true];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end



@implementation PersonalCenterCell
#pragma mark 懒加载
- (UIImageView *)arrow{
    if (_arrow == nil) {
        _arrow = [UIImageView new];
        _arrow.image = [UIImage imageNamed:@"arrow_right"];
        _arrow.widthHeight = XY(W(15),W(15));
    }
    return _arrow;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UIView *)whiteBG{
    if (!_whiteBG) {
        _whiteBG = [UIView new];
        _whiteBG.backgroundColor = [UIColor whiteColor];
        _whiteBG.widthHeight = XY(SCREEN_WIDTH, W(50));
    }
    return _whiteBG;
}
#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = COLOR_GRAY;
        self.backgroundColor = COLOR_GRAY;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.whiteBG];
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.name];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.whiteBG.leftTop = XY(0, W(10));
    
    [self.name fitTitle:model.title variable:0];
    self.name.leftCenterY = XY(W(25),self.whiteBG.centerY);

    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);
    
    //设置总高度
    self.height = self.whiteBG.bottom + W(10);
}

@end
