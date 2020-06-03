//
//  SelectCommunityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/12.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCommunityVC.h"
#import "SelectCommunityView.h"
//request
#import "RequestApi+Neighbor.h"
//location
#import "BaseVC+Location.h"

@interface SelectCommunityVC ()
@property (nonatomic, strong) SelectCommunityTopView *topView;
@property (nonatomic, strong) UIImageView *BG;

@end

@implementation SelectCommunityVC
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
- (SelectCommunityTopView *)topView{
    if (!_topView) {
        _topView = [SelectCommunityTopView new];
        WEAKSELF
        _topView.blockSearch = ^(NSString *str) {
            [weakSelf refreshHeaderAll];
        };
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
    [self configLocation];
  
}
- (void)configLocation{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];

    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways: {
            [self initLocation];
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            [self initLocation];
        }
            break;
        case kCLAuthorizationStatusNotDetermined: {
            [self addLocalAuthorityListen];
        }
            break;
        case kCLAuthorizationStatusDenied: {
            [self fetchAddressFail];
        }
            break;
        case kCLAuthorizationStatusRestricted: {
            [self fetchAddressFail];
        }
            break;
        default:
            break;
    }
}
- (void)addNav{
    if ([GlobalData sharedInstance].community.iDProperty) {
        BaseNavView * nav = [BaseNavView initNavBackTitle:@"" rightView:nil];
        nav.backgroundColor = [UIColor clearColor];
        [self.view addSubview:nav];
    }
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
    ModelCommunity * model = self.aryDatas[indexPath.row];
    [GlobalData sharedInstance].community = model;
    [GB_Nav popViewControllerAnimated:true];
}

#pragma mark request
- (void)requestList{
   
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION modelName:@"ModelAddress" exchange:false];

    [RequestApi requestSelectCommunityWithLng:modelAddress.lng lat:modelAddress.lat name:self.topView.tfSearch.text scope:0 page:1 count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCommunity"];
        self.aryDatas = aryRequest;
      
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)fetchAddress:(ModelAddress *)clPlace{
//    [self requestCommunity:clPlace];
    [GlobalMethod writeModel:clPlace key:LOCAL_LOCATION exchange:false];
    [self requestList];

}
- (void)fetchAddressFail{
    [self requestList];
}
@end
