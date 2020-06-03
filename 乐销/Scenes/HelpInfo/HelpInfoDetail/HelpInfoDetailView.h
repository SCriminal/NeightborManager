//
//  HelpInfoDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/2.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpInfoDetailView : UIView
@property (nonatomic, strong) ModelHelpList *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHelpList *)model;

@end

@interface HelpInfoDetailWebView : UIView<UIWebViewDelegate>
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIWebView *webDetail;
@property (nonatomic, strong) void (^blockWebRefresh)(void);
 

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHelpList *)model;

@end

@interface HelpInfoDetailBottomView : UIView
//属性
@property (strong, nonatomic) UILabel *info;
@property (strong, nonatomic) UIView *viewBG;
@property (strong, nonatomic) UILabel *explainTitle;
@property (strong, nonatomic) UILabel *explain;
@property (strong, nonatomic) UILabel *flowTitle;
@property (strong, nonatomic) UILabel *flow;
@property (strong, nonatomic) UILabel *phontTitle;
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *alert;
@property (nonatomic, strong) UIImageView *lineLeft;
@property (nonatomic, strong) UIImageView *lineRight;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelHelpList *)model;

@end
