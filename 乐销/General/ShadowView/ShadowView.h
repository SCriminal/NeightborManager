//
//  ShadowView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShadowView : UIView

@property (nonatomic, assign) CGFloat cornerRadius;
#pragma mark 刷新view
- (void)resetViewWith:(CGRect)frame;

@end
