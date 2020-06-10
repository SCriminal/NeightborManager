//
//  WorkNoticeListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "WorkNoticeListVC.h"
//cell
#import "WorkNoticeListCell.h"
//request
#import "RequestApi+Neighbor.h"
#import "JournalismDetailVC.h"
@interface WorkNoticeListVC ()

@end

@implementation WorkNoticeListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_message" title:@"暂无消息"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshHeaderAll) name:NOTICE_WORK_NOTICE_REFERSH object:nil];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[WorkNoticeListCell class] forCellReuseIdentifier:@"WorkNoticeListCell"];
    //request
    [self requestList];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"消息中心" rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkNoticeListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WorkNoticeListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [WorkNoticeListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelNews * model = self.aryDatas[indexPath.row];
    model.isReader = true;
    [self.tableView reloadData];
    [RequestApi requestWorkNoticeDetailWithId:model.iDProperty  delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    JournalismDetailVC * vc = [JournalismDetailVC new];
    vc.model = model;
    [GB_Nav pushViewController:vc animated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestWorkNoticeListWithScopeid:0 page:self.pageNum count:50 categoryId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelNews"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
