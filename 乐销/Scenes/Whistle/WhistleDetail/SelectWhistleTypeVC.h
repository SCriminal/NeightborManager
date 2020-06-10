//
//  SelectWhistleTypeVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectWhistleTypeVC : BaseTableVC
@property (nonatomic, strong) void (^blockSelected)(ModelTrolley *);

@end

@interface SelectWhistleTypeCell : UITableViewCell
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (strong, nonatomic) ModelTrolley *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelTrolley *)model;

@end
