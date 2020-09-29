//
//  BindedPhoneVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "BindedPhoneVC.h"
#import "UnbindMobilePhoneVC.h"

@interface BindedPhoneVC ()
@property (nonatomic, strong) BindedPhoneView *titleView;

@end

@implementation BindedPhoneVC

- (BindedPhoneView *)titleView{
    if (!_titleView) {
        _titleView = [BindedPhoneView new];
        _titleView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _titleView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.titleView];
    
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
//    [self.view addSubview:[BaseNavView initNavBackTitle:@"" rightView:nil]];
    [self.view addSubview:[BaseNavView initNavBackTitle:@"" rightTitle:@"解绑手机号" rightBlock:^{
        ModelBtn * modelDismiss = [ModelBtn modelWithTitle:@"取消" imageName:nil highImageName:nil tag:TAG_LINE color:[UIColor redColor]];
           ModelBtn * modelConfirm = [ModelBtn modelWithTitle:@"确认" imageName:nil highImageName:nil tag:TAG_LINE color:COLOR_SUBTITLE];
        modelConfirm.blockClick = ^{
            [GB_Nav popLastAndPushVC:[UnbindMobilePhoneVC new]];
        };
        [BaseAlertView initWithTitle:@"提示" content:@"确认解绑手机号？" aryBtnModels:@[modelDismiss,modelConfirm] viewShow:weakSelf.view];
    }]];
}

@end


@implementation BindedPhoneView

#pragma mark 懒加载
- (UILabel *)bind{
    if (!_bind) {
        _bind = [UILabel new];
        _bind.textColor = COLOR_333;
        _bind.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        _bind.numberOfLines = 1;
        _bind.lineSpace = 0;
        [_bind fitTitle:@"绑定手机号" variable:0];
    }
    return _bind;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor blackColor];
        _title.font =  [UIFont systemFontOfSize:F(28) weight:UIFontWeightBold];
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
        [_title fitTitle:[GlobalData sharedInstance].GB_UserModel.cellPhone variable:0];
    }
    return _title;
}
- (UILabel *)subTitle{
    if (!_subTitle) {
        _subTitle = [UILabel new];
        _subTitle.textColor = COLOR_999;
        _subTitle.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightMedium];
        [_subTitle fitTitle:@"已验证绑定手机号，您的账号将更安全" variable:0];

    }
    return _subTitle;
}
- (UIView *)viewBlock{
    if (_viewBlock == nil) {
        _viewBlock = [UIView new];
        _viewBlock.backgroundColor = [UIColor colorWithHexString:@"#D8E5FB"];
    }
    return _viewBlock;
}
- (UIImageView *)iconPhone{
    if (_iconPhone == nil) {
        _iconPhone = [UIImageView new];
        _iconPhone.image = [UIImage imageNamed:@"bind_phone"];
        _iconPhone.widthHeight = XY(W(125),W(125));
    }
    return _iconPhone;
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
    [self addSubview:self.viewBlock];
    [self addSubview:self.title];
    [self addSubview:self.subTitle];
    [self addSubview:self.iconPhone];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view

    self.bind.leftTop = XY(W(43), W(31));
    
    self.title.leftTop = XY(self.bind.left,self.bind.bottom + W(14));
    self.viewBlock.widthHeight = XY(self.title.width+ W(6), W(7));
    self.viewBlock.centerXBottom = XY(self.title.centerX,self.title.bottom+W(2));
    [self.viewBlock addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight radius:self.viewBlock.height/2.0];

    self.subTitle.leftTop = XY(self.bind.left, self.viewBlock.bottom + W(20));
    
    self.iconPhone.centerXTop = XY(SCREEN_WIDTH/2.0,self.subTitle.bottom + W(93));
    
    CGFloat top = self.iconPhone.bottom;
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
       
        [l fitTitle:@"· 您可以使用此手机号找回密码及登录" variable:0];
        l.leftTop = XY(W(45), top + W(60));
        [self addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
       
        [l fitTitle:@"· 请勿随意泄露手机号，以防不法分子利用" variable:0];
        l.leftTop = XY(W(45), top + W(10));
        [self addSubview:l];
        top = l.bottom;
    }
    {
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        l.textColor = COLOR_999;
        l.backgroundColor = [UIColor clearColor];
       
        [l fitTitle:@"  号信息" variable:0];
        l.leftTop = XY(W(45), top + W(4));
        [self addSubview:l];
        top = l.bottom;
    }
    
    //设置总高度
    self.height = top;
}


@end
