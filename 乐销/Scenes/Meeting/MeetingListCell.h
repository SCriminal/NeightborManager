//
//  MeetingListView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetingListCell : UITableViewCell
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UILabel *labelContent;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelQuestionariList *)model;

@end
