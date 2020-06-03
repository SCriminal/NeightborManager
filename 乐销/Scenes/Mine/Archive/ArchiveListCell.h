//
//  ArchiveListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchiveListCell : UITableViewCell
@property (strong, nonatomic) UILabel *buildingNo;
@property (strong, nonatomic) UIView *labelBg;
@property (strong, nonatomic) UILabel *membership;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIButton *btnEdit;
@property (nonatomic, strong) ModelArchiveList *model;

@property (nonatomic, strong) void (^blockEditClick)(ModelArchiveList *);


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelArchiveList *)model;

@end
