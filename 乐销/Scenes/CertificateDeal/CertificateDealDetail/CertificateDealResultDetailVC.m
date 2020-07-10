//
//  CertificateDealResultDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/6/1.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealResultDetailVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "CertificateDealResultDetailTopView.h"
#import "CertificateDealDetailView.h"
//yellow btn
#import "YellowButton.h"
#import "CertificateDealDetailVC.h"

@interface CertificateDealResultDetailVC ()
@property (nonatomic, strong) ModelCertificateDealDetail *modelDetail;
@property (nonatomic, strong) CertificateDealResultDetailTopView *topView;
@property (nonatomic, strong) CertificateDealDetailView *voteView;
@property (nonatomic, strong) YellowButton *btnBottom;
@property (nonatomic, strong) UIView *footerView;

@end

@implementation CertificateDealResultDetailVC
- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = [UIColor whiteColor];
        _footerView.width = SCREEN_WIDTH;
    }
    return _footerView;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"重新提交"];
        _btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - W(25)-iphoneXBottomInterval);
        WEAKSELF
        _btnBottom.blockClick = ^{
            CertificateDealDetailVC * vc = [CertificateDealDetailVC new];
            vc.modelItem = ^(){
                ModelCertificateDealCategoryItem * item = [ModelCertificateDealCategoryItem new];
                item.title = weakSelf.modelDetail.categoryName;
                item.iDProperty = weakSelf.modelDetail.onekeyId;
                return item;
            }();
            vc.modelResutlDetail = weakSelf.modelDetail;
            vc.blockBack = ^(UIViewController *vc) {
                [weakSelf requestList];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _btnBottom;
}

- (CertificateDealDetailView *)voteView{
    if (!_voteView) {
        _voteView = [CertificateDealDetailView new];
        _voteView.isParticipated = true;
    }
    return _voteView;
}

- (CertificateDealResultDetailTopView *)topView{
    if (!_topView) {
        _topView = [CertificateDealResultDetailTopView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
//    [self.tableView registerClass:[<#CellName#> class] forCellReuseIdentifier:@"<#CellName#>"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"我的办理" rightView:nil]];
}

#pragma mark request
- (void)requestList{
//    [RequestApi requestCertificateDealResultDetailWithNumber:self.modelItem.number delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        self.modelDetail = [ModelCertificateDealDetail modelObjectWithDictionary:response];
//        self.modelDetail.number = self.modelItem.number;
//        [self.topView resetViewWithModel:self.modelDetail];
//        self.tableView.tableHeaderView = self.topView;
//        
//        [self.voteView resetViewWithModel:self.modelDetail.participant];
//        
//        [self.footerView removeAllSubViews];
//        [self.footerView addSubview:self.voteView];
//        self.footerView.height = self.voteView.bottom + W(15)+iphoneXBottomInterval;
//
//        if (self.modelDetail.status == 3) {
//            [self.footerView addSubview:self.btnBottom];
//            self.btnBottom.top = self.voteView.bottom + W(25);
//            self.footerView.height = self.btnBottom.bottom + W(15)+iphoneXBottomInterval;
//        }
//        self.tableView.tableFooterView = self.footerView;
//        
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//        
//    }];
}
@end
