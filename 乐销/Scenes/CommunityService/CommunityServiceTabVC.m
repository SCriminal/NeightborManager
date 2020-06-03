//
//  CommunityServiceTabVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityServiceTabVC.h"
//sub view
#import "CommunityServiceTabView.h"
//vc
#import "CommunityServiceWatiListVC.h"
#import "CommunityServiceSuccessListVC.h"

@interface CommunityServiceTabVC ()
@property (nonatomic, strong) CommunityServiceTabView *tabView;
@property (nonatomic, strong) CommunityServiceWatiListVC *waitListVC;
@property (nonatomic, strong) CommunityServiceSuccessListVC *successListVC;
@property (nonatomic, strong) CommunityServiceMainListVC *mainListVC;

@end

@implementation CommunityServiceTabVC
- (CommunityServiceWatiListVC *)waitListVC{
    if (!_waitListVC) {
        _waitListVC = [CommunityServiceWatiListVC new];
        _waitListVC.serviceType = self.serviceType;
        _waitListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height);
        _waitListVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _waitListVC.view.hidden = true;
        _waitListVC.viewBG.hidden = true;
    }
    return _waitListVC;
}
- (CommunityServiceSuccessListVC *)successListVC{
    if (!_successListVC) {
        _successListVC = [CommunityServiceSuccessListVC new];
        _successListVC.serviceType = self.serviceType;
        _successListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height);
        _successListVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _successListVC.view.hidden = true;
        _successListVC.viewBG.hidden = true;

    }
    return _successListVC;
}
- (CommunityServiceMainListVC *)mainListVC{
    if (!_mainListVC) {
        _mainListVC = [CommunityServiceMainListVC new];
        _mainListVC.serviceType = self.serviceType;
        _mainListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height);
        _mainListVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _mainListVC.view.hidden = false;
        _mainListVC.viewBG.hidden = true;

    }
    return _mainListVC;
}
- (CommunityServiceTabView *)tabView{
    if (!_tabView) {
        _tabView = [CommunityServiceTabView new];
        [_tabView resetWithAry:@[^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_main_default";
            model.highImageName = @"whistle_main_choose";
            model.title = @"全部";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_wait_default";
            model.highImageName = @"whistle_wait_choose";
            model.title = @"待处理";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_complete_default";
            model.highImageName = @"whistle_complete_chose";
            model.title = @"已完结";
            return model;
        }()]];
        _tabView.bottom = SCREEN_HEIGHT;
        WEAKSELF
        _tabView.blockSwitch = ^(NSInteger index) {
            [weakSelf selectIndex:index];
        };
    }
    return _tabView;
}
- (void)selectIndex:(NSInteger)index{
    self.mainListVC.view.hidden = index !=0;
    self.waitListVC.view.hidden = index !=1;
    self.successListVC.view.hidden = index !=2;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tabView];
    [self addChildViewController:self.waitListVC];
    [self addChildViewController:self.successListVC];
    [self addChildViewController:self.mainListVC];
    [self.view addSubview:self.mainListVC.view];
    [self.view addSubview:self.waitListVC.view];
    [self.view addSubview:self.successListVC.view];

}


@end
