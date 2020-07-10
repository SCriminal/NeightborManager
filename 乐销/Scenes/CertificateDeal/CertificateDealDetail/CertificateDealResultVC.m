//
//  CertificateDealResultVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealResultVC.h"
//cell
#import "CertificateDealResultCell.h"
//request
#import "RequestApi+Neighbor.h"
//#import "SecurityDetailVC.h"
#import "CertificateDealResultDetailVC.h"

@interface CertificateDealResultVC ()

@end

@implementation CertificateDealResultVC

@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无办理信息"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //table
    [self.tableView registerClass:[CertificateDealResultCell class] forCellReuseIdentifier:@"CertificateDealResultCell"];
    self.tableView.top = 0;
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];
}



#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificateDealResultCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CertificateDealResultCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CertificateDealResultCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificateDealResultDetailVC * vc = [CertificateDealResultDetailVC new];
    vc.modelItem = self.aryDatas[indexPath.row];
    WEAKSELF
    vc.blockBack = ^(UIViewController *item) {
        if ( weakSelf.blockRequestSuccess) {
            weakSelf.blockRequestSuccess();
        }
    };
    [GB_Nav pushViewController:vc animated:true];
}
#pragma mark request
- (void)requestList{
//    [RequestApi requestCertificateDealResultWithStatuses:strEnemy(self.type) page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
//        self.pageNum ++;
//        
//               NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCertificateDealDetail"];
//               if (self.isRemoveAll) {
//                   [self.aryDatas removeAllObjects];
//               }
//               if (!isAry(aryRequest)) {
//                   [self.tableView.mj_footer endRefreshingWithNoMoreData];
//               }
//               [self.aryDatas addObjectsFromArray:aryRequest];
//               [self.tableView reloadData];
//
//    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
//        
//    }];
}
@end
