//
//  SafetySearchView.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/15.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafetySearchView : UIView<UITextFieldDelegate>
//属性
@property (strong, nonatomic) UIButton *btnSearch;
@property (strong, nonatomic) UITextField *tfSearch;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) void (^blockSearch)(void);
@property (nonatomic, strong) void (^blockClose)(void);
@property (nonatomic, strong) UIImageView *iconClose;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
