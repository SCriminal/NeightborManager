//
//  CommunityServiceWatiListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityServiceWatiListVC.h"
//cell
#import "CommunityServiceListCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "CommunityServiceDetailVC.h"

@interface CommunityServiceWatiListVC ()

@end

@implementation CommunityServiceWatiListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无待处理信息"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_SERVICE_REFERSH object:nil];
    //table
    [self.tableView registerClass:[CommunityServiceListCell class] forCellReuseIdentifier:@"CommunityServiceListCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

#pragma mark 添加导航栏
- (void)addNav{
    NSString * strNav = nil;
    switch (self.serviceType) {
        case ENUM_COMMUNITY_SERVICE_ARGUE:
            strNav = @"纠纷调解";
            break;
            case ENUM_COMMUNITY_SERVICE_MAINTAIN:
                       strNav = @"维修";
                       break;
            case ENUM_COMMUNITY_SERVICE_CLEAN:
                       strNav = @"保洁";
                       break;
            case ENUM_COMMUNITY_SERVICE_SECURITY:
                       strNav = @"安保";
                       break;
        default:
            break;
    }
    [self.view addSubview:[BaseNavView initNavBackTitle:strNav rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityServiceListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityServiceListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CommunityServiceListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CommunityServiceDetailVC * vc = [CommunityServiceDetailVC new];
    vc.modelList = self.aryDatas[indexPath.row];
    WEAKSELF
    vc.blockBack = ^(UIViewController *item) {
        if (item.requestState ) {
            [weakSelf refreshHeaderAll];
        }
    };
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
    [RequestApi requestServiceListWithScope:7 statuses:@"1" page:self.pageNum count:50 type:self.serviceType areaId:0 scopeId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
             NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunityServiceList"];
             if (self.isRemoveAll) {
                 [self.aryDatas removeAllObjects];
             }
             if (!isAry(aryRequest)) {
                 [self.tableView.mj_footer endRefreshingWithNoMoreData];
             }
             [self.aryDatas addObjectsFromArray:aryRequest];
             [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    } ];

  
}
@end
