//
//  MultipleSelectView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleSelectView : UIView
@property (nonatomic, assign) int index;
@property (nonatomic, strong) void (^blockClick)(int);

#pragma mark 刷新view
- (void)resetViewWith:(NSArray *)aryStrs;
- (void)selectIndex:(int)index;
@end


@interface MultipleSelectItemView : UIView
//属性
@property (strong, nonatomic) UILabel *title;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIImageView *ivSelected;

#pragma mark 刷新view
- (void)resetViewWithModel:(NSString *)title;

@end
