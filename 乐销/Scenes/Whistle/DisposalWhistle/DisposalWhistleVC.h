//
//  DisposalWhistleVC.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/3/24.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseVC.h"

@interface DisposalWhistleVC : BaseVC
@property (nonatomic, strong) ModelWhistleList *model;

@end

@interface CollectionDisposalImageCell : UICollectionViewCell
@property  (nonatomic, strong) UIImageView *ivImage;
#pragma mark 获取cell高度
+ (CGSize)fetchHeight;
#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model;
- (void)resetCellWithCamera;

@end
