//
//  SelectDepartmentCell.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/3/24.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectDepartmentCell : UITableViewCell
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIImageView *ivSelected;
@property (strong, nonatomic) ModelDepartment *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelDepartment *)model;


@end


@interface SearchNavView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);
@property (nonatomic, strong) UIControl *backBtn;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
