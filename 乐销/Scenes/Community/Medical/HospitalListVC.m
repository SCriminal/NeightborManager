//
//  HospitalListVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "HospitalListVC.h"
#import "HospitalListView.h"
@interface HospitalListVC ()
@property (nonatomic, strong) HospitalListTopView *topView;

@end

@implementation HospitalListVC
- (HospitalListTopView *)topView{
    if (!_topView) {
        _topView = [HospitalListTopView new];
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    self.tableView.tableHeaderView = self.topView;
    self.tableView.height = SCREEN_HEIGHT;
    self.tableView.top = 0;
    //table
    [self.tableView registerClass:[HospitalListCell class] forCellReuseIdentifier:@"HospitalListCell"];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
//    [self.view addSubview:[BaseNavView initNavBackTitle:<#导航栏标题#> rightView:nil]];
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
    HospitalListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [HospitalListCell fetchHeight:self.aryDatas[indexPath.row]];
}

#pragma mark request
- (void)requestList{
    self.aryDatas = @[^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"潍坊市中医院";
        model.subString = @"8910186";
        model.thirdString = @"潍坊市奎文区潍州路1055号";
        model.imageName = @"";
        return model;
    }(),^(){
        ModelBaseData * model = [ModelBaseData new];
        model.string = @"潍坊市奎文区新华医院";
        model.subString = @"5078368";
        model.thirdString = @"潍坊市奎文区通亭街11628号";
        model.imageName = @"";
        return model;
    }()].mutableCopy;
    [self.tableView reloadData];
}
@end
