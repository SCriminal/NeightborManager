//
//  ActivityDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/3.
//Copyright © 2020 ping. All rights reserved.
//

#import "ActivityDetailVC.h"
//sub view
#import "ActivityDetailView.h"
//request
#import "RequestApi+Neighbor.h"

@interface ActivityDetailVC ()
@property (nonatomic, strong) ActivityDetailView *topView;
@property (nonatomic, strong) ActivityDetailBottomView *bottomView;
@property (nonatomic, strong) ActivityDetailApplicationView *applicationView;

@property (nonatomic, strong) ModelActivity *modelDetail;
@property (nonatomic, strong) ActivityDetailWebView *webView;

@end

@implementation ActivityDetailVC
- (ActivityDetailWebView *)webView{
    if (!_webView) {
        _webView = [ActivityDetailWebView new];
        WEAKSELF
        _webView.blockWebRefresh = ^{
            [weakSelf.tableView reloadData];
        };
    }
    return _webView;
}
- (ActivityDetailView *)topView{
    if (!_topView) {
        _topView = [ActivityDetailView new];
    }
    return _topView;
}
- (ActivityDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [ActivityDetailBottomView new];
       
    }
    return _bottomView;
}
- (ActivityDetailApplicationView *)applicationView{
    if (!_applicationView) {
        _applicationView = [ActivityDetailApplicationView new];
    }
    return _applicationView;
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
    [self.view addSubview:[BaseNavView initNavBackTitle:@"社区活动" rightView:nil]];
}
#pragma mark table view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.webView.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.webView;
}
#pragma mark request
- (void)requestList{
   
    [RequestApi requestActivityDetailWithId:self.modelList.iDProperty scopeId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelActivity modelObjectWithDictionary:response];
        [self.topView resetViewWithModel:self.modelDetail];
        self.tableView.tableHeaderView = self.topView;
        [self.webView resetViewWithModel:self.modelDetail];

        if (self.modelDetail.eventType == 2) {
            [self requestAssociation];
        }else{
            [self requestApplications];
        }
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}
- (void)requestAssociation{
    [RequestApi requestAssociationDetailWithId:self.modelDetail.teamId scopeId:0  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelAssociation * modelAssociation = [ModelAssociation modelObjectWithDictionary:response];
        self.bottomView.modelAssociation = modelAssociation;
        [self.bottomView resetViewWithModel:self.modelDetail];
        self.tableView.tableFooterView = self.bottomView;

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestApplications{
    [RequestApi requestActivityApplicationsWithScopeId:0 eventId:self.modelList.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * aryApplications = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelArchiveList"];
        [self.applicationView resetViewWithModel:self.modelDetail ary:aryApplications];
        self.tableView.tableFooterView = self.applicationView;

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];

}

@end
