//
//  CommunityView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityView.h"


@interface CommunityNavView ()
@end

@implementation CommunityNavView
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = [UIColor blackColor];
        _name.font =  [UIFont systemFontOfSize:F(20) weight:UIFontWeightRegular];
    }
    return _name;
}
- (UILabel *)selectCommunity{
    if (_selectCommunity == nil) {
        _selectCommunity = [UILabel new];
        _selectCommunity.textColor = COLOR_333;
        _selectCommunity.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _selectCommunity;
}
- (UIImageView *)arrowLocal{
    if (_arrowLocal == nil) {
        _arrowLocal = [UIImageView new];
        _arrowLocal.image = [UIImage imageNamed:@"community_local"];
        _arrowLocal.widthHeight = XY(W(25),W(25));
    }
    return _arrowLocal;
}
- (UIImageView *)arrowDown{
    if (_arrowDown == nil) {
        _arrowDown = [UIImageView new];
        _arrowDown.image = [UIImage imageNamed:@"arrow_down"];
        _arrowDown.widthHeight = XY(W(25),W(25));
    }
    return _arrowDown;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(resetViewWithModel) name:NOTICE_COMMUNITY_REFERSH object:nil];
        self.width = SCREEN_WIDTH;
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.name];
    [self addSubview:self.selectCommunity];
    [self addSubview:self.arrowLocal];
    [self addSubview:self.arrowDown];
    
    //初始化页面
    [self resetViewWithModel];
}

#pragma mark 刷新view
- (void)resetViewWithModel{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.name fitTitle:isStr([GlobalData sharedInstance].community.name)?[GlobalData sharedInstance].community.name:@"暂无小区" variable:0];
    self.name.leftTop = XY(W(15),W(11));
    
    self.arrowLocal.leftCenterY = XY(self.name.right+ W(5),self.name.centerY);
    
    self.arrowDown.rightCenterY = XY(SCREEN_WIDTH - W(15),self.name.centerY);

    [self.selectCommunity fitTitle:@"切换小区" variable:0];
    self.selectCommunity.rightCenterY = XY(self.arrowDown.left - W(2),self.arrowDown.centerY);
    
    
    //设置总高度
    self.height = self.name.bottom + W(11);
    
    [self addControlFrame:CGRectMake(self.selectCommunity.left - W(15), 0, SCREEN_WIDTH - (self.selectCommunity.left - W(15)), self.height) belowView:self.selectCommunity target:self action:@selector(selectCommunityClick)];

}

#pragma mark click
- (void)selectCommunityClick{
    if (self.blockChangeDistrictClick ) {
        self.blockChangeDistrictClick();
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end


@implementation CommunityPoliceView
#pragma mark 懒加载
- (UIImageView *)arrowLocal{
    if (_arrowLocal == nil) {
        _arrowLocal = [UIImageView new];
        _arrowLocal.image = [UIImage imageNamed:@"community_police"];
        _arrowLocal.widthHeight = XY(W(325),W(50));
    }
    return _arrowLocal;
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
    [self addSubview:self.arrowLocal];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model{
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    
    self.arrowLocal.centerXTop = XY(SCREEN_WIDTH/2.0,0);
    //设置总高度
    self.height = self.arrowLocal.height;
    [self addControlFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, self.height) belowView:self.arrowLocal target:self action:@selector(leftClick)];
    [self addControlFrame:CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, self.height) belowView:self.arrowLocal target:self action:@selector(rightClick)];


}
- (void)leftClick{
    //police
    if (isStr([GlobalData sharedInstance].community.policePhone)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[GlobalData sharedInstance].community.policePhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }
}
- (void)rightClick{
    if (isStr([GlobalData sharedInstance].community.policePhone)) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel://%@",[GlobalData sharedInstance].community.managerPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}
@end




@implementation CommunityInfoCell
#pragma mark 懒加载
- (UILabel *)infoTitle{
    if (_infoTitle == nil) {
        _infoTitle = [UILabel new];
        _infoTitle.textColor = COLOR_333;
        _infoTitle.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _infoTitle.numberOfLines = 1;
        _infoTitle.lineSpace = 0;
    }
    return _infoTitle;
}
- (UILabel *)infoTime{
    if (_infoTime == nil) {
        _infoTime = [UILabel new];
        _infoTime.textColor = COLOR_666;
        _infoTime.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _infoTime.numberOfLines = 1;
        _infoTime.lineSpace = 0;
    }
    return _infoTime;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.infoTitle];
        [self.contentView addSubview:self.infoTime];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view

    [self.infoTime fitTitle:[GlobalMethod exchangeTimeWithStamp:model.publishTime andFormatter:@"MM-dd"]  variable:0];
    self.infoTime.rightTop = XY(SCREEN_WIDTH - W(20),W(13.5));

    [self.infoTitle fitTitle:model.title variable:self.infoTime.left - W(25)-W(10)];
    self.infoTitle.leftCenterY = XY(W(25),self.infoTime.centerY);
    
    //设置总高度
    self.height = self.infoTime.bottom + W(13.5);
}

@end
