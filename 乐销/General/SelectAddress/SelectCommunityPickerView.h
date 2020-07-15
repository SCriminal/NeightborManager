
//
//中车运
//
//  Created by 隋林栋 on 2018/11/7.
//Copyright © 2018 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCommunityPickerView : UIView<RequestDelegate>
@property (nonatomic, strong) void (^blockSeleted)(ModelUserAuthority *);
@property (nonatomic, strong) void (^blockCancelClick)(void);
@property (nonatomic, strong) LoadingView * loadingView;//loading动画

@end


@interface SelectCommunityPickerCell : UITableViewCell

@property (strong, nonatomic) UILabel *title;

#pragma mark 刷新cell
- (void)resetCellWithModel:(id)model;

@end

