//
//  PersonalCenterView.h
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCenterTopView : UIView
//属性
@property (strong, nonatomic) UIImageView *bg;
@property (strong, nonatomic) UIImageView *head;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *iconBind;
@property (strong, nonatomic) UILabel *bind;


@end

@interface PersonalCenterCell : UITableViewCell

@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *subTitle;

@property (nonatomic, strong) ModelBtn *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model;

@end
