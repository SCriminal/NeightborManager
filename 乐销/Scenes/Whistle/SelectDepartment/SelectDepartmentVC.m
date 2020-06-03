//
//  SelectDepartmentVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/3/24.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectDepartmentVC.h"
#import "SelectDepartmentCell.h"
//request
#import "RequestApi+Neighbor.h"
@interface SelectDepartmentVC ()
@property (nonatomic, strong) SearchNavView *searchView;

@end

@implementation SelectDepartmentVC

- (SearchNavView *)searchView{
    if (!_searchView) {
        _searchView = [SearchNavView new];
        _searchView.top = NAVIGATIONBAR_HEIGHT;
        WEAKSELF
        _searchView.blockSearch = ^(NSString *str) {
            [weakSelf refreshHeaderAll];
        };
    }
    return _searchView;
}
- (NSMutableArray *)arySelected{
    if (!_arySelected) {
        _arySelected = [NSMutableArray new];
    }
    return _arySelected;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.searchView];
    //table
    self.tableView.top = self.searchView.bottom;
    self.tableView.height = SCREEN_HEIGHT - self.searchView.bottom;
    [self.tableView registerClass:[SelectDepartmentCell class] forCellReuseIdentifier:@"SelectDepartmentCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    [self.view addSubview:[BaseNavView initNavBackTitle:@"选择吹哨部门" rightTitle:@"完成" rightBlock:^{
        if (weakSelf.blockSelected) {
            weakSelf.blockSelected(weakSelf.arySelected);
        }
        [GB_Nav popViewControllerAnimated:true];
    }]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectDepartmentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectDepartmentCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectDepartmentCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelDepartment * model = self.aryDatas[indexPath.row];
    model.isSelected = !model.isSelected;
    if (model.isSelected) {
        [self.arySelected addObject:model];
    }else{
        [self.arySelected removeObjectForKeyPath:@"iDProperty" object:model];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

}
#pragma mark request
- (void)requestList{
    [RequestApi requestDepartmentListWithScope:@"6" scopeId:6 name:self.searchView.tfSearch.text areaId:6 page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelDepartment"];
        [aryRequest fetchSelectModels:self.arySelected compareKey:@"iDProperty" exchangeKey:@"isSelected"];

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
