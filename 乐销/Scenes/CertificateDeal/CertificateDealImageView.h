//
//  CertificateDealImageView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/25.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SelectImageView.h"
#import "Collection_Image.h"




@interface CertificateDealImageView : UIView
@property (nonatomic, assign) BOOL isParticipated;

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(NSArray *)model top:(CGFloat)top;
@end


@interface CertificateDealSingleImage : UIView
@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *require;
@property (nonatomic, assign) BOOL isParticipated;
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;

- (void)resetViewWithModel:(ModelQuestionnairDetailContent *)model;

@end


@interface CertificateDealMultiImageView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) ModelQuestionnairDetailContent *model;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isEditing;
#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top;
@end

@interface CollectionDealImageCell : UICollectionViewCell
@property  (nonatomic, strong) UIImageView *ivImage;
#pragma mark 获取cell高度
+ (CGSize)fetchHeight;
#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model;
- (void)resetCellWithCamera;

@end
