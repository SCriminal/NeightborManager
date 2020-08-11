//
//  BindedPhoneVC.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/8/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseVC.h"

@interface BindedPhoneVC : BaseVC

@end

@interface BindedPhoneView : UIView
//属性
@property (strong, nonatomic) UILabel *bind;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *subTitle;
@property (strong, nonatomic) UIView *viewBlock;
@property (strong, nonatomic) UIImageView *iconPhone;

@end
