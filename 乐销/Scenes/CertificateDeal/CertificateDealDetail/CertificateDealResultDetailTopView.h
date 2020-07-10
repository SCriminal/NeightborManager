//
//  CertificateDealResultDetailTopView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/1.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CertificateDealResultDetailTopView : UIView
@property (nonatomic, strong) ModelCertificateDealDetail *modelDetail;

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelCertificateDealDetail *
                             )model;

@end
