//
//  SwitchView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchView : UIView

//属性
@property (strong, nonatomic) UILabel *titleLeft;
@property (strong, nonatomic) UILabel *titleRight;
@property (strong, nonatomic) UIImageView *BG;
@property (nonatomic, strong) void (^blockClick)(int index);
@property (nonatomic, assign) int index;
#pragma mark 刷新view
- (void)resetViewWith:(NSString *)leftTitle :(NSString *)rightTitle;
- (void)switchToIndex:(int)index;
@end
