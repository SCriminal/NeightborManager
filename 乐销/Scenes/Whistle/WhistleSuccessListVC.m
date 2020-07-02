//
//  WhistleSuccessListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "WhistleSuccessListVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "ManagerWhistleDetailVC.h"
@interface WhistleSuccessListVC ()

@end

@implementation WhistleSuccessListVC
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无已完结信息"];
    }
    return _noResultView;
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"已完结" rightView:nil]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestWhistleListWithStatus:@"9,10" page:self.pageNum count:50 scope:@"7" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelWhistleList"];
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


@implementation WhistleMainListVC
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无吹哨信息"];
    }
    return _noResultView;
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"全部" rightView:nil]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestWhistleListWithStatus:@"1,3,9,10" page:self.pageNum count:50 scope:@"7" delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelWhistleList"];
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


@implementation ManagerWhistleSuccessListVC
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无已完结信息"];
    }
    return _noResultView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerWhistleDetailVC * vc = [ManagerWhistleDetailVC new];
    vc.modelList = self.aryDatas[indexPath.row];
    WEAKSELF
    vc.blockBack = ^(UIViewController *item) {
        if (item.requestState ) {
            [weakSelf refreshHeaderAll];
        }
    };
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"已完结" rightView:nil]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestManagerWhistleListWithStatus:@"9,10" page:self.pageNum count:50  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelWhistleList"];
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


@implementation ManagerWhistleWatiListVC

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ManagerWhistleDetailVC * vc = [ManagerWhistleDetailVC new];
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
    [RequestApi requestManagerWhistleListWithStatus:@"1,3" page:self.pageNum count:50  delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelWhistleList"];
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
