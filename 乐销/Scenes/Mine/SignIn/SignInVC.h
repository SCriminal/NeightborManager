//
//  SignInVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
//btn
#import "YellowButton.h"
@interface SignInVC : BaseVC
@property (strong, nonatomic) UIImageView *whiteBG;
@property (strong, nonatomic) UIImageView *goldCoin;
@property (strong, nonatomic) UILabel *success;
@property (strong, nonatomic) UILabel *score;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *everyday;
@property (strong, nonatomic) UILabel *alert;
@property (nonatomic, strong) YellowButton *btnBottom;

@end
