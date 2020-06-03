//
//  CommunityServiceSuccessListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityServiceSuccessListVC.h"
//request
#import "RequestApi+Neighbor.h"
@interface CommunityServiceSuccessListVC ()

@end

@implementation CommunityServiceSuccessListVC
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



#pragma mark request
- (void)requestList{
[RequestApi requestServiceListWithScope:7 statuses:@"9,10" page:self.pageNum count:50 type:self.serviceType areaId:0 scopeId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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


@implementation CommunityServiceMainListVC
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无处理信息"];
    }
    return _noResultView;
}




#pragma mark request
- (void)requestList{
[RequestApi requestServiceListWithScope:7 statuses:@"1,9,10" page:self.pageNum count:50 type:self.serviceType areaId:0 scopeId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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
