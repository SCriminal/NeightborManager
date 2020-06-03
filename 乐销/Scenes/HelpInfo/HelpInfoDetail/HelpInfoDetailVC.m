//
//  HelpInfoDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/4/2.
//Copyright © 2020 ping. All rights reserved.
//

#import "HelpInfoDetailVC.h"
#import "HelpInfoDetailView.h"
//request
#import "RequestApi+Neighbor.h"
@interface HelpInfoDetailVC ()
@property (nonatomic, strong) HelpInfoDetailView *topView;
@property (nonatomic, strong) HelpInfoDetailBottomView *bottomView;
@property (nonatomic, strong) HelpInfoDetailWebView *webView;
@property (nonatomic, strong) ModelHelpList *modelDetail;

@end

@implementation HelpInfoDetailVC
- (HelpInfoDetailWebView *)webView{
    if (!_webView) {
        _webView = [HelpInfoDetailWebView new];
        WEAKSELF
        _webView.blockWebRefresh = ^{
            [weakSelf.tableView reloadData];
        };
    }
    return _webView;
}
- (HelpInfoDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [HelpInfoDetailBottomView new];
    }
    return _bottomView;
}
- (HelpInfoDetailView *)topView{
    if (!_topView) {
        _topView = [HelpInfoDetailView new];
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

#pragma mark table view
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.webView.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.webView;
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"爱心救助" rightView:nil]];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestHelpDetailWithId:self.modelList.iDProperty scopeId:5 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelDetail = [ModelHelpList modelObjectWithDictionary:response];
        [self.topView resetViewWithModel:self.modelDetail];
        [self.bottomView resetViewWithModel:self.modelDetail];
        self.tableView.tableHeaderView = self.topView;
        self.tableView.tableFooterView = self.bottomView;
        [self.webView resetViewWithModel:self.modelDetail];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
  
}
@end
