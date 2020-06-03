//
//  JournalismListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JournalismListCell : UITableViewCell

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UIImageView *icon;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model;


@end
