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
        _name.textColor = [UIColor whiteColor];
        _name.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UIImageView *)iconBind{
    if (_iconBind == nil) {
        _iconBind = [UIImageView new];
        _iconBind.image = [UIImage imageNamed:@"personal_iconBind"];
        _iconBind.highlightedImage = [UIImage imageNamed:@"personal_iconBinded"];
        _iconBind.widthHeight = XY(W(17),W(17));
    }
    return _iconBind;
}
- (UILabel *)bind{
    if (_bind == nil) {
        _bind = [UILabel new];
        _bind.textColor = [UIColor whiteColor];
        _bind.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _bind.numberOfLines = 1;
        _bind.lineSpace = 0;
    }
    return _bind;
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
    [self addSubview:self.head];
    [self addSubview:self.name];
    [self addSubview:self.bind];
    [self addSubview:self.iconBind];
    //初始化页面
    [self resetViewWithModel];
}

#pragma mark 刷新view
- (void)resetViewWithModel{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    ModelUser * model = [GlobalData sharedInstance].GB_UserModel;

    [self.head sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"personal_head"]];
    self.head.leftTop = XY(W(20), W(55)+iphoneXTopInterval);
  
    [self.name fitTitle:[GlobalMethod isLoginSuccess]?UnPackStr(model.nickname):@"您好，请登录" variable:0];
    self.name.leftTop = XY(self.head.right + W(20),self.head.top+W(5));

            self.iconBind.highlighted = isStr([GlobalData sharedInstance].GB_UserModel.cellPhone);
    [self.bind fitTitle:isStr([GlobalData sharedInstance].GB_UserModel.cellPhone)?@"手机已绑定":@"手机未绑定" variable:0];

    self.iconBind.leftBottom = XY(self.head.right +W(20), self.head.bottom - W(6));
    self.bind.leftCenterY = XY(self.iconBind.right +W(4), self.iconBind.centerY);

   
    //设置总高度
    [self addSubview:^(){
        UIView * viewGray = [UIView new];
        viewGray.widthHeight = XY(SCREEN_WIDTH, W(10));
        viewGray.top = self.head.bottom + W(53);
        viewGray.tag = TAG_LINE;
        viewGray.backgroundColor = COLOR_GRAY;
        return viewGray;
    }()];
    self.height = self.head.bottom + W(53)+W(10);
    self.bg.height = self.height-W(10);

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
- (UILabel *)subTitle{
    if (_subTitle == nil) {
        _subTitle = [UILabel new];
        _subTitle.textColor = COLOR_999;
        _subTitle.font =  [UIFont systemFontOfSize:F(16) weight:UIFontWeightRegular];
        _subTitle.numberOfLines = 1;
        _subTitle.lineSpace = 0;
    }
    return _subTitle;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.arrow];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.subTitle];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.height = W(52);

    [self.name fitTitle:model.title variable:0];
    self.name.leftCenterY = XY(W(25),self.height/2.0);

    self.arrow.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);
    
    [self.subTitle fitTitle:model.subTitle variable:0];
    self.subTitle.rightCenterY = XY(self.arrow.left - W(5),self.height/2.0);
}

@end
