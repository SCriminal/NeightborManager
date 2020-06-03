//
//  MemberListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberListCell : UITableViewCell
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIView *labelBg;
@property (strong, nonatomic) UILabel *membership;
@property (strong, nonatomic) UILabel *phone;

@property (strong, nonatomic) UIImageView *headLogo;

@property (nonatomic, strong) ModelMemberList *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelMemberList *)model;

@end
