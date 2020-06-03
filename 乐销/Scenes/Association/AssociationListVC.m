//
//  AssociationListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "AssociationListVC.h"
//cell
#import "AssociationListCell.h"
//request
#import "RequestApi+Neighbor.h"
//create
#import "CreateAssociationVC.h"
//yellow btn
#import "YellowButton.h"

@interface AssociationListVC ()
@property (nonatomic, strong) YellowButton *btnBottom;

@end

@implementation AssociationListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_association" title:@"暂无社团"];
    }
    return _noResultView;
}
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"+ 添加社团"];
        _btnBottom.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - W(25)-iphoneXBottomInterval);
        WEAKSELF
        _btnBottom.blockClick = ^{
            CreateAssociationVC * vc = [CreateAssociationVC new];
            vc.blockBack = ^(UIViewController *vc) {
                [weakSelf refreshHeaderAll];
            };
            [GB_Nav pushViewController:vc animated:true];
        };
    }
    return _btnBottom;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[AssociationListCell class] forCellReuseIdentifier:@"AssociationListCell"];
    self.tableView.height = self.btnBottom.top - W(15) - NAVIGATIONBAR_HEIGHT;
    [self.view addSubview:self.btnBottom];

    //request
    [self requestList];
    [self addRefreshHeader];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"社团" rightTitle:@"" rightBlock:^{
        
    }]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AssociationListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AssociationListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    WEAKSELF
    cell.blockDeleteClick = ^(ModelAssociation *item) {
        [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确认删除社团?" dismiss:^{
            
        } confirm:^{
            [weakSelf requestDelete:item];
        } view:weakSelf.view];
    };
    cell.blockEditClick  = ^(ModelAssociation *item) {
        [weakSelf requestEdit:item];

    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [AssociationListCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestAssociationListWithScopeId:0 areaId:0 page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelAssociation"];
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
- (void)requestDelete:(ModelAssociation *)model{
    WEAKSELF
    [RequestApi requestDeleteAssociationWithId:model.iDProperty scopeId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [weakSelf refreshHeaderAll];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestEdit:(ModelAssociation *)model{
    WEAKSELF
    CreateAssociationVC * vc = [CreateAssociationVC new];
    vc.model = model;
    vc.blockBack = ^(UIViewController *vc) {
        [weakSelf refreshHeaderAll];
    };
    [GB_Nav pushViewController:vc animated:true];
    
}
@end
