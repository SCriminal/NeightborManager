//
//  CreateArchiveView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"
#import "MultipleSelectView.h"

@interface CreateArchiveView : UIView
@property (nonatomic, strong) YellowButton *btnBottom;
@property (nonatomic, strong) MultipleSelectView *selectIdentityView;
@property (nonatomic, strong) MultipleSelectView *selectRepublicView;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


