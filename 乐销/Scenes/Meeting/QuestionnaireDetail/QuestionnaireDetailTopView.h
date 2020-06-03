//
//  QuestionnaireDetailTopView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/13.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionnaireDetailTopView : UIView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *content;

#pragma mark 刷新view
- (void)resetViewWithModel:(id)model;

@end
