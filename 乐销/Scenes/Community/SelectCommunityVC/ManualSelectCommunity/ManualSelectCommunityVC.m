//
//  ManualSelectCommunityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "ManualSelectCommunityVC.h"
#import "SelectCommunityView.h"
//request
#import "RequestApi+Neighbor.h"
@interface ManualSelectCommunityVC ()
@property (nonatomic, strong) ManualSelectCommunityTopView *topView;
@property (nonatomic, strong) UIImageView *BG;

@end

@implementation ManualSelectCommunityVC
- (UIImageView *)BG{
    if (!_BG) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"select_community_BG"];
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
        _BG.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _BG;
}
- (ManualSelectCommunityTopView *)topView{
    if (!_topView) {
        _topView = [ManualSelectCommunityTopView new];
        WEAKSELF
        _topView.blockSearch = ^(NSString *str) {
            [weakSelf refreshHeaderAll];
        };
        _topView.top = NAVIGATIONBAR_HEIGHT;
    }
    return _topView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view insertSubview:self.BG belowSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor clearColor];
    //添加导航栏
    self.tableView.top = self.topView.bottom;
    self.tableView.height = SCREEN_HEIGHT-self.topView.bottom;
    self.tableBackgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.topView];
    //table
    [self.tableView registerClass:[SelectCommunityCell class] forCellReuseIdentifier:@"SelectCommunityCell"];
    //request
    [self addRefreshHeader];
    [self addNav];
    [self refreshHeaderAll];
}
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"选择小区" rightView:nil];
    nav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nav];

}
#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCommunityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCommunityCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [SelectCommunityCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ModelCommunity * model = self.aryDatas[indexPath.row];
//    [GlobalData sharedInstance].community = model;
    [GB_Nav popToRootViewControllerAnimated:true];
}

#pragma mark request
- (void)requestList{
    
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION modelName:@"ModelAddress" exchange:false];
    
    [RequestApi requestSelectCommunityWithLng:modelAddress.lng lat:modelAddress.lat name:self.topView.tfSearch.text scope:0 page:1 count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunity"];
        [aryRequest insertObject:^(){
            ModelCommunity * item = [ModelCommunity new];
            item.name = @"直接进入奎文区";
            return item;
        }() atIndex:0];
        self.aryDatas = aryRequest;
        
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

@end
