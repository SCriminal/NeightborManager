//
//  SlPageControl.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "SLPageControl.h"

@interface SLPageControl ()

@end

@implementation SLPageControl

#pragma mark override set current page


#define dotW 4
#define margin 5
- (void)layoutSubviews
{
    [super layoutSubviews];
    //计算整个pageControll的宽度
    CGFloat newW = self.subviews.count*dotW+(self.subviews.count-1)*margin;
    
    //设置新frame
    self.widthHeight = XY(newW, self.frame.size.height);
    self.centerXTop = XY(self.superview.width/2.0, self.frame.origin.y);

    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        [dot setFrame:CGRectMake(i * (dotW+margin), 0, dotW, dotW)];
    }
}

@end
