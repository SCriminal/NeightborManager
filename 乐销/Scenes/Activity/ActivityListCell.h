//
//  ActivityListView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityListCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelContent;
@property (nonatomic, strong) UILabel *labelType;
@property (nonatomic, strong) UILabel *labelParticipate;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelActivity *)model;

@end
