//
//  CallingView.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/11.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallingView : UIView
@property (nonatomic, strong) UIButton *btnRefuse;
@property (nonatomic, strong) UILabel *refuse;
@property (nonatomic, strong) UIButton *btnAccept;
@property (nonatomic, strong) UILabel *accept;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIVisualEffectView *masksView;//蒙板

DECLARE_SINGLETON(CallingView)

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
