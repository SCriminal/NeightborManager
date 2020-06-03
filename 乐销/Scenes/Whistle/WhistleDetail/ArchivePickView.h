//
//  ArchivePickView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/19.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchivePickView : UIView
@property (nonatomic, strong) void (^blockSelect)(NSInteger);

#pragma mark 刷新view
- (void)resetViewWithAry:(NSArray *)ary;

@end
