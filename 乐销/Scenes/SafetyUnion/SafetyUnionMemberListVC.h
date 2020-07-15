//
//  SafetyUnionMemberListVC.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SafetyUnionMemberListVC : BaseTableVC



@end

@interface SafetyUnionMemberListCell : UITableViewCell

@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UILabel *communityName;
@property (strong, nonatomic) UILabel *memberName;
@property (strong, nonatomic) UIImageView *iconPhone;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UIImageView *iconRTC;
@property (strong, nonatomic) UILabel *rtc;
@property (strong, nonatomic) UIControl *conRTC;
@property (strong, nonatomic) UIControl *conPhone;
@property (nonatomic, strong) ModelSafetyUnion *model;
@property (nonatomic, strong) void (^blockRTC)(ModelSafetyUnion *);

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end
