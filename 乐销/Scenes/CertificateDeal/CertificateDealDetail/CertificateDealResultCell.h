//
//  CertificateDealResultCell.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/1.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateDealResultCell : UITableViewCell
@property (strong, nonatomic) UILabel *problem;
@property (strong, nonatomic) UIView *labelBg;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *time;
@property (nonatomic, strong) ModelCertificateDealDetail *model;


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCertificateDealDetail *)model;

@end
