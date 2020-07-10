//
//  CertificateDealDetailView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/21.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CertificateDealDetailView : UIView
@property (nonatomic, assign) BOOL isParticipated;

#pragma mark 刷新view
- (void)resetViewWithModel:(NSArray *)model ;

@end

@interface CertificateDealDetailTextView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;
@property (nonatomic, strong) UITextField *tf;
@property (nonatomic, assign) BOOL isParticipated;

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top;
@end

@interface CertificateDealDetailSingleChoiceView : UIView
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;
@property (nonatomic, assign) BOOL isParticipated;

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top;
@end

@interface CertificateDealDetailMultipleChoiceView : UIView
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;
@property (nonatomic, assign) BOOL isParticipated;

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top;
@end

@interface CertificateDealDetailChoiceView : UIView
@property (nonatomic, strong) UIImageView *iconSelected;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, assign) BOOL isSingleChoice;
@property (nonatomic, assign) BOOL isParticipated;
@property (nonatomic, strong) ModelQuestionnairDetailValues*model;
@property (nonatomic, strong) void (^blockSelected)(ModelQuestionnairDetailValues *);

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelQuestionnairDetailValues *)model;
@end
