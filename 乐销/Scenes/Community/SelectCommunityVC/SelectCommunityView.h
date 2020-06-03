//
//  SelectCommunityView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCommunityTopView : UIView
<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);
@property (nonatomic, strong) UIControl *backBtn;

@property (nonatomic, strong) UILabel *select;
@property (nonatomic, strong) UILabel *district;
@property (nonatomic, strong) UIImageView *location;
@property (nonatomic, strong) UILabel *vague;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end

@interface ManualSelectCommunityTopView : UIView
<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(NSString *);

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end


@interface SelectCommunityCell : UITableViewCell

@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *BG;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCommunity *)model;

@end
