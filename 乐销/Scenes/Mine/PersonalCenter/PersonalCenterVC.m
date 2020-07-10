//
//  PersonalCenterVC.m
//  Motorcade
//
//  Created by 隋林栋 on 2019/5/9.
//Copyright © 2019 ping. All rights reserved.
//

#import "PersonalCenterVC.h"
//view
#import "PersonalCenterView.h"
//collection view
#import "ModuleCollectionView.h"
//section title
#import "SectionTitleView.h"
#import "JournalismListVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "RequestInstance.h"
@interface PersonalCenterVC ()
@property (nonatomic, strong) PersonalCenterTopView *topView;
@property (nonatomic, strong) UIView *tableHeaderView;


@end

@implementation PersonalCenterVC
@synthesize aryDatas = _aryDatas;

- (PersonalCenterTopView *)topView{
    if (!_topView) {
        _topView = [PersonalCenterTopView new];
    }
    return _topView;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}

- (NSMutableArray *)aryDatas{
    if (!_aryDatas) {
        _aryDatas = @[^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"设置";
            model.blockClick = ^{
                [GB_Nav pushVCName:@"SettingVC" animated:true];
            };
            return model;
        }()].mutableCopy;
    }
    return _aryDatas;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self reconfigView];
    //table
    
    self.tableView.top = 0;
    self.tableView.bounces = false;
    self.tableView.height = SCREEN_HEIGHT - TABBAR_HEIGHT;
    [self.tableView registerClass:[PersonalCenterCell class] forCellReuseIdentifier:@"PersonalCenterCell"];
    //request
    [self requestList];
}
- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    
    [self.tableHeaderView addSubview:self.topView];
    

    self.tableHeaderView.height = self.topView.bottom;
    self.tableView.tableHeaderView = self.tableHeaderView;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestExtendToken];
}
- (void)requestExtendToken{
    static int requestSuccess = 0;
    if (requestSuccess) {
        return;
    }
    if (![GlobalMethod isLoginSuccess]) {
        requestSuccess = 1;
        return;
    }
    if ([RequestInstance sharedInstance].tasks.count == 0) {
        requestSuccess = 1;
        [RequestApi requestExtendTokenSuccess:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
               NSString * token = [response stringValueForKey:@"token"];
               if (isStr(token)) {
                   [GlobalData sharedInstance].GB_Key = token;
               }
           } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
           
           }];
    }
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalCenterCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PersonalCenterCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelBtn *model =self.aryDatas[indexPath.row];
    if (model.blockClick) {
        model.blockClick();
    }
}
#pragma mark request
- (void)requestList{
}
@end
