//
//  ModuleCollectionView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModuleCollectionView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *aryModel;/// 标题数组
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) void (^blockModuleSelect)(ModelBtn *);//选中单元格
@property (nonatomic, assign) CGFloat cellHeight;

- (void)resetWithAry:(NSMutableArray *)arydatas;
- (void)reload;

@end


@interface ModuleCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UILabel *nameLabel;
@property (nonatomic, strong) ModelBtn *model;



#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model;

@end
