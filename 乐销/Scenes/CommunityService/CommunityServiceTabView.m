//
//  CommunityServiceTabView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityServiceTabView.h"

@interface CommunityServiceTabView ()

@end

@implementation CommunityServiceTabView

#pragma mark 刷新view
- (void)resetWithAry:(NSArray *)aryModels{
    [self removeAllSubViews];

    for (int i = 0; i<aryModels.count; i++) {
        ModelBtn * model = aryModels[i];
        UIImageView * iv = [UIImageView new];
        iv.image = [UIImage imageNamed:model.imageName];
        iv.highlightedImage = [UIImage imageNamed:model.highImageName];
        iv.widthHeight = XY(W(20), W(20));
        if (i == 0) {
            iv.centerXTop = XY(SCREEN_WIDTH/6.0, W(7));
        }else if(i == 1){
            iv.centerXTop = XY(SCREEN_WIDTH/2.0, W(7));
        }else if(i == 2){
            iv.centerXTop = XY(SCREEN_WIDTH/6.0*5.0, W(7));
        }
        iv.tag = i;
        [self addSubview:iv];
        
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:F(10) weight:UIFontWeightRegular];
        [label fitTitle:model.title variable:0];
        label.tag = i;
        label.centerXTop = XY(iv.centerX, iv.bottom+W(5));
        [self addSubview:label];
        
        UIControl * con = [UIControl new];
        con.tag = i;
        con.frame = CGRectMake(iv.left - W(30), 0, iv.width + W(60), label.bottom + W(16));
        [con addTarget:self action:@selector(conClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:con];
    }
    [self reconfigView];
}

- (void)selectIndex:(NSInteger)index{
    self.index = index;
    [self reconfigView];
}
- (void)reconfigView{
    for (UIView * viewSub in self.subviews) {
        if ([viewSub isKindOfClass:UIImageView.class]) {
            UIImageView * iv = (UIImageView *)viewSub;
            iv.highlighted = iv.tag == self.index;
        }
        if ([viewSub isKindOfClass:UILabel.class]) {
            UILabel * label = (UILabel *)viewSub;
            label.textColor = label.tag == self.index?COLOR_BLUE:[UIColor colorWithHexString:@"#757F84"];
        }
    }
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.height = W(49)+iphoneXBottomInterval;
    }
    return self;
}


#pragma mark 点击事件
- (void)conClick:(UIControl *)con{
    self.index = con.tag;
    [self reconfigView];
    if (self.blockSwitch) {
        self.blockSwitch(self.index);
    }
}

@end
