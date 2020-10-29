//
//  CommunityVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityVC.h"
//view
#import "CommunityView.h"
//auto sc view
#import "AutoScView.h"
//collection view
#import "CommunityCollectionView.h"
//request
#import "RequestApi+Neighbor.h"
#import "WhistleTabVC.h"
//community service vc
#import "CommunityServiceTabVC.h"
//请求单例
#import "RequestInstance.h"
#import "WebVC.h"
#import "BindPhoneAlertView.h"

@interface CommunityVC ()
@property (nonatomic, strong) CommunityNavView *navView;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) CommunityCollectionView *collection;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) NSArray *aryADs;
@property (nonatomic, strong) UIView *signInView;


@end

@implementation CommunityVC

#pragma mark lazy init
- (UIView *)signInView{
    if (!_signInView) {
        _signInView = [UIView new];
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.widthHeight = XY(W(345), W(40));
        btn.centerX = SCREEN_WIDTH/2.0;
        [btn setBackgroundImage:[UIImage imageNamed:@"community_signin"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnSignInClick) forControlEvents:UIControlEventTouchUpInside];
        [_signInView addSubview:btn];
        _signInView.widthHeight = XY(SCREEN_WIDTH, btn.height);
    }
    return _signInView;
}
- (AutoScView *)autoSCView{
    if (!_autoSCView) {
        _autoSCView = [[AutoScView alloc]initWithFrame:CGRectMake(W(15), NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH - W(30), W(125)) image:@[@"temp_community1"]];
        _autoSCView.pageCurrentColor = [UIColor whiteColor];
        _autoSCView.pageDefaultColor = [UIColor colorWithHexString:@"ffffff" alpha:0.5];
        [_autoSCView addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:5 lineWidth:0 lineColor:[UIColor clearColor]];
        _autoSCView.isClickValid = true;
        WEAKSELF
        _autoSCView.blockClick = ^(int index) {
            if (weakSelf.aryADs.count > index) {
                ModelAD * model = [weakSelf.aryADs objectAtIndex:index];
                if (isStr(model.bodyUrl) && model.displayMode == 1) {
                    WebVC * vc = [WebVC new];
                    vc.navTitle = @"详情";
                    vc.url = model.bodyUrl;
                    [GB_Nav pushViewController:vc animated:true];
                }
                
            }
            
        };
    }
    return _autoSCView;
}
- (CommunityCollectionView *)collection{
    if (!_collection) {
        _collection = [CommunityCollectionView new];
        ModelBaseData * model0 = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"社区";
            model.aryDatas = @[^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"小红哨";
                model.tag = 1;
                model.imageName = @"tmp_module_0";
                model.blockClick = ^{
                    WhistleTabVC * whislterVC = [WhistleTabVC new];
                    [GB_Nav pushViewController:whislterVC animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"社区哨";
                model.tag = 1;
                model.imageName = @"tmp_module_10";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"SendWhistleTabVC" animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"工作通知";
                model.tag = 1;
                model.imageName = @"tmp_module_11";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"WorkNoticeListVC" animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"平安联盟";
                model.tag = 1;
                model.imageName = @"tmp_module_13";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"SafetyUnionMemberListVC" animated:true];
                };
                return model;
            }()].mutableCopy;
            return model;
        }();
        ModelBaseData * model1 = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"办事";
            model.aryDatas = @[^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"社区办事";
                model.tag = 1;
                model.imageName = @"tmp_module_12";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"CategoryCertificationDealListVC" animated:true];
                };
                return model;
            }()         ,^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"议事厅";
                model.tag = 1;
                model.imageName = @"tmp_module_7";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"MeetingListVC" animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"爱心救助";
                model.tag = 1;
                model.imageName = @"tmp_module_5";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"HelpInfoListVC" animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"纠纷调解";
                model.tag = 1;
                model.imageName = @"tmp_module_1";
                model.blockClick = ^{
                    CommunityServiceTabVC * vc = [CommunityServiceTabVC new];
                    vc.serviceType = ENUM_COMMUNITY_SERVICE_ARGUE;
                    [GB_Nav pushViewController:vc animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"社区活动";
                model.tag = 1;
                model.imageName = @"tmp_module_6";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"ActivityListVC" animated:true];
                    
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"社团管理";
                model.tag = 1;
                model.imageName = @"tmp_module_8";
                model.blockClick = ^{
                    [GB_Nav pushVCName:@"AssociationListVC" animated:true];
                };
                return model;
            }(),].mutableCopy;
            return model;
        }();
        ModelBaseData * model2 = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.string = @"物业";
            model.aryDatas = @[^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"小区安保";
                model.tag = 1;
                model.imageName = @"tmp_module_2";
                model.blockClick = ^{
                    CommunityServiceTabVC * vc = [CommunityServiceTabVC new];
                    vc.serviceType = ENUM_COMMUNITY_SERVICE_SECURITY;
                    [GB_Nav pushViewController:vc animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"小区保洁";
                model.tag = 1;
                model.imageName = @"tmp_module_3";
                model.blockClick = ^{
                    CommunityServiceTabVC * vc = [CommunityServiceTabVC new];
                    vc.serviceType = ENUM_COMMUNITY_SERVICE_CLEAN;
                    [GB_Nav pushViewController:vc animated:true];
                };
                return model;
            }(),^(){
                ModelBtn * model = [ModelBtn new];
                model.title = @"小区维修";
                model.tag = 1;
                model.imageName = @"tmp_module_4";
                model.blockClick = ^{
                    CommunityServiceTabVC * vc = [CommunityServiceTabVC new];
                    vc.serviceType = ENUM_COMMUNITY_SERVICE_MAINTAIN;
                    [GB_Nav pushViewController:vc animated:true];
                };
                return model;
            }()].mutableCopy;
            return model;
        }();
        [_collection resetWithAry:@[model0,model1,model2].mutableCopy];
    }
    return _collection;
}
- (UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [UIView new];
        _tableHeaderView.width = SCREEN_WIDTH;
        _tableHeaderView.backgroundColor = [UIColor clearColor];
    }
    return _tableHeaderView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self reconfigView];
    
    //table
    self.tableView.top = 0;
    self.tableView.height = SCREEN_HEIGHT  - TABBAR_HEIGHT;
    
    [self.tableView registerClass:[CommunityInfoCell class] forCellReuseIdentifier:@"CommunityInfoCell"];
    [self requestADList];
    [self reqeustCellPhone];
}

- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    [self.tableHeaderView addSubview:self.autoSCView];
    
    self.signInView.top = self.autoSCView.bottom+W(15);
    [self.tableHeaderView addSubview:self.signInView];
    
    self.collection.top = self.signInView.bottom+W(15);
    [self.tableHeaderView addSubview:self.collection];
    
    self.tableHeaderView.height = self.collection.bottom+W(13.5);
    self.tableView.tableHeaderView = self.tableHeaderView;
}

#pragma mark 添加导航栏
- (void)addNav{
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /*1.党员示范经营 1
     2.居民哨 1
     3.纠纷 1 (物业服务 1)
     4.一键办理 1
     5.商家入驻 1（商家审核 1）
     6.商家更新 1（商家审核 1）
     7.实名认证 2
     8.维修 1 (物业服务 1)
     9.保洁 1 (物业服务 1)
     10.安保 1 (物业服务 1)
     11.议事厅 1 (物业服务 1)*/
    
    NSMutableArray * ary = [NSMutableArray array];
    for (int i = 0; i<11; i++) {
        [ary addObject: [NSString stringWithFormat:@"%d",i+10000+1]];
    }
    [RequestApi requestModelNumWithModuleIds:[ary componentsJoinedByString:@","] delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [response arrayValueForKey:@"modules"];
        for (NSDictionary * dic in ary) {
            int identity = [dic intValueForKey:@"id"];
            int num = [dic intValueForKey:@"amount"];
            NSString * strModelName = @"";
            switch (identity) {
                case 10001:
                    strModelName = @"";
                    break;
                case 10002:
                    strModelName = @"小红哨";
                    break;
                case 10003:
                    strModelName = @"纠纷调解";
                    break;
                case 10004:
                    strModelName = @"社区办理";
                    break;
                case 10005:
                    strModelName = @"";
                    break;
                case 10006:
                    strModelName = @"";
                    break;
                case 10007:
                    strModelName = @"";
                    break;
                case 10008:
                    strModelName = @"小区维修";
                    break;
                case 10009:
                    strModelName = @"小区保洁";
                    break;
                case 10010:
                    strModelName = @"小区安保";
                    break;
                case 10011:
                    strModelName = @"议事厅";
                    break;
                default:
                    break;
            }
            if (strModelName.length > 0) {
                for (ModelBaseData * item in self.collection.aryModel) {
                    ModelBtn * same = [item.aryDatas fetchSameModelKeyPath:@"title" value:strModelName];
                    same.num = num;
                }
            }
        }
        [self.collection reload];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
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
    CommunityInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityInfoCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CommunityInfoCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark request
- (void)requestADList{
    [RequestApi requestADListWithGroupalias:@"admin_community_1" scopeId:1 delegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSArray * ary = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelAD"];
        self.aryADs = ary;
        NSArray * aryAds = [ary fetchValues:@"coverUrl"];
        [self.autoSCView resetWithImageAry:aryAds];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)reqeustCellPhone{
    [RequestApi requestPersonlInfoWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        NSString * cellPhone = [response stringValueForKey:@"cellphone"];
        if (!isStr(cellPhone)) {
            BindPhoneAlertView * bindView = [BindPhoneAlertView new];
            [[UIApplication sharedApplication].keyWindow addSubview:bindView];
        }else{
            [GlobalData sharedInstance].GB_UserModel.cellPhone = cellPhone;
            [GlobalData saveUserModel];
        }
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
#pragma mark click
- (void)btnSignInClick{
    [GB_Nav pushVCName:@"SignInVC" animated:true];
}

@end
