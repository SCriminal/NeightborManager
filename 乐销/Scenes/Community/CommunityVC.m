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


@interface CommunityVC ()
@property (nonatomic, strong) CommunityNavView *navView;
@property (nonatomic, strong) AutoScView *autoSCView;
@property (nonatomic, strong) CommunityCollectionView *collection;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) NSArray *aryADs;

@end

@implementation CommunityVC

#pragma mark lazy init
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
        [_collection resetWithAry:@[^(){
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
            model.title = @"安保";
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
            model.title = @"保洁";
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
            model.title = @"维修";
            model.tag = 1;
            model.imageName = @"tmp_module_4";
            model.blockClick = ^{
                 CommunityServiceTabVC * vc = [CommunityServiceTabVC new];
                                vc.serviceType = ENUM_COMMUNITY_SERVICE_MAINTAIN;
                                [GB_Nav pushViewController:vc animated:true];
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
        }(),

                                     ^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"社区活动";
            model.tag = 1;
            model.imageName = @"tmp_module_6";
            model.blockClick = ^{
                [GB_Nav pushVCName:@"ActivityListVC" animated:true];
                 
            };
            return model;
        }(),

                                     ^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"议事厅";
            model.tag = 1;
            model.imageName = @"tmp_module_7";
            model.blockClick = ^{
                 [GB_Nav pushVCName:@"MeetingListVC" animated:true];
            };
            return model;
        }(),

                                     ^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"社团";
            model.tag = 1;
            model.imageName = @"tmp_module_8";
            model.blockClick = ^{
                 [GB_Nav pushVCName:@"AssociationListVC" animated:true];
            };
            return model;
        }(),
                                     ^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"签到";
            model.tag = 1;
            model.imageName = @"tmp_module_9";
            model.blockClick = ^{
                [GB_Nav pushVCName:@"SignInVC" animated:true];
            };
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.title = @"社区哨";
            model.tag = 1;
            model.imageName = @"tmp_module_10";
            model.blockClick = ^{
                [GB_Nav pushVCName:@"SendWhistleVC" animated:true];
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
        }()].mutableCopy];
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
}

- (void)reconfigView{
    [self.tableHeaderView removeAllSubViews];
    //auto sc
    [self.tableHeaderView addSubview:self.autoSCView];

    self.collection.top = self.autoSCView.bottom+W(15);
    [self.tableHeaderView addSubview:self.collection];
    
    
    
    
    self.tableHeaderView.height = self.collection.bottom+W(13.5);
    self.tableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark 添加导航栏
- (void)addNav{

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
@end
