//
//  YellowButton.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YellowButton : UIView

@property (nonatomic, strong) void (^blockClick)(void);

#pragma mark 刷新view
- (void)resetViewWithWidth:(CGFloat)width :(CGFloat)height :(NSString *)title;
- (void)resetWhiteViewWithWidth:(CGFloat)width :(CGFloat)height :(NSString *)title;
@end
