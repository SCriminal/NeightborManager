//
//  CategoryCertificationDealListVC.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface CategoryCertificationDealListVC : BaseTableVC


@end

@interface CategoryCertificationDealListCell : UITableViewCell

@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *category;
@property (strong, nonatomic) UILabel *num;
@property (nonatomic, strong) ModelCertificateDealDetail *model;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCertificateDealDetail *)model;

@end
