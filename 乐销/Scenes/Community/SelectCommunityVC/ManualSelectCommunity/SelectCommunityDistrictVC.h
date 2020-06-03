//
//  SelectCommunityDistrictVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectCommunityDistrictVC : BaseVC<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryModel;/// 标题数组
@property (nonatomic, assign) CGFloat cellHeight;

@end


@interface SelectCommunityDistrictCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *nameLabel;
@property (nonatomic, strong) ModelBtn *model;



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model;

@end
