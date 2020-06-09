//
//  MessageCenterVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "MessageCenterVC.h"
//cell
#import "MessageCenterCell.h"

@interface MessageCenterVC ()

@end

@implementation MessageCenterVC
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
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[MessageCenterCell class] forCellReuseIdentifier:@"MessageCenterCell"];
    //request
    [self requestList];
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
    MessageCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCenterCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MessageCenterCell fetchHeight:self.aryDatas[indexPath.row]];
}


#pragma mark request
- (void)requestList{
    self.aryDatas = @[^(){
        ModelMsg * model = [ModelMsg new];
        model.content = @"123123123123sdsdf";
        model.createTime = [[NSDate date]timeIntervalSince1970];
        return model;
    }(),^(){
        ModelMsg * model = [ModelMsg new];
        model.content = @"123123123123sdsdf";
        model.createTime = [[NSDate date]timeIntervalSince1970];
        return model;
    }(),^(){
        ModelMsg * model = [ModelMsg new];
        model.content = @"123123123123sdsdf";
        model.createTime = [[NSDate date]timeIntervalSince1970];
        return model;
    }()].mutableCopy;
    [self.tableView reloadData];
//    [self showNoResult];
}
@end
