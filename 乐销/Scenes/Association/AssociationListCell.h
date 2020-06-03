//
//  AssociationListCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssociationListCell : UITableViewCell

@property (strong, nonatomic) UIButton *btnEdit;
@property (strong, nonatomic) UIButton *btnDelete;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *address;
@property (nonatomic, strong) void (^blockEditClick)(ModelAssociation *);
@property (nonatomic, strong) void (^blockDeleteClick)(ModelAssociation *);
@property (nonatomic, strong) ModelAssociation *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAssociation *)model;

@end
