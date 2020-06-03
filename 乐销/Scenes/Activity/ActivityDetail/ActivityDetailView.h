//
//  ActivityDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/3.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YellowButton.h"

@interface ActivityDetailView : UIView
//属性
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *sender;


#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model;

@end

@interface ActivityDetailWebView : UIView<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView *webDetail;
@property (nonatomic, strong) void (^blockWebRefresh)(void);
 

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model;

@end

@interface ActivityDetailBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *time;

@property (strong, nonatomic) UILabel *info;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UILabel *explainTitle;
@property (strong, nonatomic) UILabel *explain;
@property (strong, nonatomic) UILabel *flowTitle;
@property (strong, nonatomic) UILabel *flow;
@property (strong, nonatomic) UILabel *phontTitle;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *commandorNameTitle;
@property (strong, nonatomic) UILabel *commandorName;
@property (nonatomic, strong) UIImageView *lineLeft;
@property (nonatomic, strong) UIImageView *lineRight;
@property (nonatomic, strong) ModelAssociation *modelAssociation;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model;
@end

@interface ActivityDetailApplicationView : UIView
//属性
@property (strong, nonatomic) UILabel *time;
@property (strong, nonatomic) UILabel *num;

@property (strong, nonatomic) UILabel *info;
@property (strong, nonatomic) UIView *viewBG;
@property (nonatomic, strong) UIImageView *lineLeft;
@property (nonatomic, strong) UIImageView *lineRight;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelActivity *)model ary:(NSArray *)ary ;
@end
