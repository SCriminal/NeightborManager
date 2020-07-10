//
//  CertificationSubmitTabVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificationSubmitTabVC.h"
//sub view
#import "CommunityServiceTabView.h"
#import "CertificationSubmitListVC.h"

@interface CertificationSubmitTabVC ()
@property (nonatomic, strong) CommunityServiceTabView *tabView;
@property (nonatomic, strong) CertificationSubmitListVC *disposalListVC;
@property (nonatomic, strong) CertificationSubmitListVC *refuseListVC;
@property (nonatomic, strong) CertificationSubmitListVC *mainListVC;

@end

@implementation CertificationSubmitTabVC
- (CertificationSubmitListVC *)disposalListVC{
    if (!_disposalListVC) {
        _disposalListVC = [CertificationSubmitListVC new];
        _disposalListVC.categoryID = self.categoryID;
        _disposalListVC.navTitle = self.navTitle;
        _disposalListVC.requestStatus = @"2";
        _disposalListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height);
        _disposalListVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _disposalListVC.view.hidden = true;
        _disposalListVC.viewBG.hidden = true;
    }
    return _disposalListVC;
}
- (CertificationSubmitListVC *)refuseListVC{
    if (!_refuseListVC) {
        _refuseListVC = [CertificationSubmitListVC new];
        _refuseListVC.categoryID = self.categoryID;
        _refuseListVC.requestStatus = @"3";
        _refuseListVC.navTitle = self.navTitle;
        _refuseListVC.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height);
        _refuseListVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _refuseListVC.view.hidden = true;
        _refuseListVC.viewBG.hidden = true;

    }
    return _refuseListVC;
}
- (CertificationSubmitListVC *)mainListVC{
    if (!_mainListVC) {
        _mainListVC = [CertificationSubmitListVC new];
        _mainListVC.categoryID = self.categoryID;
        _mainListVC.requestStatus = @"1";
        _mainListVC.navTitle = self.navTitle;
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
            model.title = @"已提交";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_wait_default";
            model.highImageName = @"whistle_wait_choose";
            model.title = @"已办理";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_complete_default";
            model.highImageName = @"whistle_complete_chose";
            model.title = @"已退回";
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
    self.disposalListVC.view.hidden = index !=1;
    self.refuseListVC.view.hidden = index !=2;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tabView];
    [self addChildViewController:self.disposalListVC];
    [self addChildViewController:self.refuseListVC];
    [self addChildViewController:self.mainListVC];
    [self.view addSubview:self.mainListVC.view];
    [self.view addSubview:self.disposalListVC.view];
    [self.view addSubview:self.refuseListVC.view];

}


@end
