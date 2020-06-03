//
//  SectionTitleView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionTitleView : UIView


//属性
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIView *yellowBlock;
@property (strong, nonatomic) UIImageView *arrowRight;
@property (strong, nonatomic) UILabel *more;
@property (nonatomic, strong) void (^blockClick)(void);

#pragma mark 刷新view
- (void)resetWithBigTitle:(NSString *)title;

@end


