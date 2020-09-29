//
//  NoticeAlertView.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/9/29.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"

@interface NoticeAlertView : UIView
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *close;
@property (strong, nonatomic) UIButton *btn;


@end
