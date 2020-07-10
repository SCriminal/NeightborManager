//
//  CertDetailTopView.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/10.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertDetailTopView : UIView
@property (nonatomic, strong) ModelCertificateDealDetail *model;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCertificateDealDetail *)model;

@end
