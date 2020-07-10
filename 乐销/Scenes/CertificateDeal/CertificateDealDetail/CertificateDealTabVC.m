//
//  CertificateDealTabVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealTabVC.h"
//sub view
#import "WhistleTabView.h"
//vc
#import "CertificateDealResultVC.h"

@interface CertificateDealTabVC ()
@property (nonatomic, strong) WhistleTabView *tabView;
@property (nonatomic, strong) CertificateDealResultVC *returnedVC;
@property (nonatomic, strong) CertificateDealResultVC *successListVC;
@property (nonatomic, strong) CertificateDealResultVC *submitedVC;


@end

@implementation CertificateDealTabVC
- (CertificateDealResultVC *)returnedVC{
    if (!_returnedVC) {
        _returnedVC = [CertificateDealResultVC new];
        _returnedVC.type = ENUM_CERTIFICATE_DISPOSAL_RESULT_RETURN;
        _returnedVC.view.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height-NAVIGATIONBAR_HEIGHT);
        _returnedVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _returnedVC.view.hidden = true;
        _returnedVC.viewBG.hidden = true;
        WEAKSELF
        _returnedVC.blockRequestSuccess = ^{
            [weakSelf refreshAll];
        };
    }
    return _returnedVC;
}
- (CertificateDealResultVC *)successListVC{
    if (!_successListVC) {
        _successListVC = [CertificateDealResultVC new];
        _successListVC.type = ENUM_CERTIFICATE_DISPOSAL_RESULT_SUCCESS;
        _successListVC.view.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height-NAVIGATIONBAR_HEIGHT);
        _successListVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _successListVC.view.hidden = true;
        _successListVC.viewBG.hidden = true;
        WEAKSELF
        _successListVC.blockRequestSuccess = ^{
            [weakSelf refreshAll ];
        };
    }
    return _successListVC;
}
- (CertificateDealResultVC *)submitedVC{
    if (!_submitedVC) {
        _submitedVC = [CertificateDealResultVC new];
        _submitedVC.type = ENUM_CERTIFICATE_DISPOSAL_RESULT_SUBMIT;
        _submitedVC.view.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabView.height-NAVIGATIONBAR_HEIGHT);
        _submitedVC.tableView.height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT - self.tabView.height;
        _submitedVC.viewBG.hidden = true;
        WEAKSELF
        _submitedVC.blockRequestSuccess = ^{
            [weakSelf refreshAll ];
        };
    }
    return _submitedVC;
}
- (WhistleTabView *)tabView{
    if (!_tabView) {
        _tabView = [WhistleTabView new];
        [_tabView resetWithAry:@[^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_main_default";
            model.highImageName = @"whistle_main_choose";
            model.title = @"已提交";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_complete_default";
            model.highImageName = @"whistle_complete_chose";
            model.title = @"已办理";
            return model;
        }(),^(){
            ModelBtn * model = [ModelBtn new];
            model.imageName = @"whistle_return_default";
            model.highImageName = @"whistle_return_choose";
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
    self.submitedVC.view.hidden = index !=0;
    self.returnedVC.view.hidden = index !=2;
    self.successListVC.view.hidden = index !=1;
}
- (void)refreshAll{
    for (BaseTableVC * tableVC in self.childViewControllers) {
        if (tableVC && [tableVC isKindOfClass:[BaseTableVC class]]) {
            [tableVC refreshHeaderAll];
        }
    }
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.tabView];
    [self addChildViewController:self.submitedVC];
    [self addChildViewController:self.successListVC];
    [self addChildViewController:self.returnedVC];
    [self.view addSubview:self.submitedVC.view];
    [self.view addSubview:self.returnedVC.view];
    [self.view addSubview:self.successListVC.view];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"我的办理" rightView:nil]];
}

@end
