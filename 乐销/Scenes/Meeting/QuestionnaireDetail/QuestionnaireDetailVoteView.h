//
//  QuestionnaireDetailVoteView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/13.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionnaireDetailVoteView : UIView

@property (nonatomic, strong) ModelQuestionnairDetail *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelQuestionnairDetail *)model ;

@end

@interface QuestionnaireDetailVoteTextView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, strong) ModelQuestionnairDetail *modelDetail;

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top;
@end

@interface QuestionnaireDetailVoteSingleChoiceView : UIView
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;
@property (nonatomic, strong) ModelQuestionnairDetail *modelDetail;

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top;
@end

@interface QuestionnaireDetailVoteMultipleChoiceView : UIView
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;
@property (nonatomic, strong) ModelQuestionnairDetail *modelDetail;

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top;
@end

@interface QuestionnaireDetailVoteChoiceView : UIView
@property (nonatomic, strong) UIImageView *iconSelected;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, assign) BOOL isSingleChoice;
@property (nonatomic, assign) BOOL isParticipated;
@property (nonatomic, strong) ModelQuestionnairDetailValues*model;
@property (nonatomic, strong) void (^blockSelected)(ModelQuestionnairDetailValues *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelQuestionnairDetailValues *)model;
@end
