//
//  CertificationSubmitListVC.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface CertificationSubmitListVC : BaseTableVC
@property (nonatomic, assign) double categoryID;
@property (nonatomic, strong) NSString *requestStatus;
@property (nonatomic, strong) NSString *navTitle;
@end

@interface CertificationSubmitListCell : UITableViewCell
@property (strong, nonatomic) UILabel *problem;
@property (strong, nonatomic) UIView *labelBg;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *time;
@property (nonatomic, strong) ModelCertificateDealDetail *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCertificateDealDetail *)model;

@end
