//
//  WhistleTabView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhistleTabView : UIView
@property (nonatomic, strong) void (^blockSwitch)(NSInteger);
@property (nonatomic, assign) NSInteger index;
#pragma mark 刷新view
- (void)resetWithAry:(NSArray *)aryModels;
- (void)selectIndex:(NSInteger)index;
@end
