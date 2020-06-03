//
//  ShadowView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "ShadowView.h"

@interface ShadowView ()

@end

@implementation ShadowView

#pragma mark lazy
- (CGFloat)cornerRadius{
    if (!_cornerRadius) {
        _cornerRadius = 5;
    }
    return _cornerRadius;
}
#pragma mark 刷新view
- (void)resetViewWith:(CGRect)frame{

    self.frame = frame;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor colorWithRed:251/255.0 green:251/255.0 blue:251/255.0 alpha:1.0].CGColor;
    
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.shadowColor = [UIColor colorWithRed:121/255.0 green:107/255.0 blue:91/255.0 alpha:0.4].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 5;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
    }
    return self;
}


@end
