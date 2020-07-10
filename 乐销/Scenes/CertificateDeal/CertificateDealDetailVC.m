//
//  CertificateDealDetailVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/21.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealDetailVC.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
#import "CertificateDealDetailView.h"
//request
#import "RequestApi+Neighbor.h"
#import "WebVC.h"

@interface CertificateDealDetailVC ()
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) CertificateDealDetailView *voteView;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) ModelCertificateContentDetail *modelDetail;

@end

@implementation CertificateDealDetailVC
- (UIView *)viewHeader{
    if (!_viewHeader) {
        _viewHeader = [UIView new];
        _viewHeader.backgroundColor = [UIColor clearColor];
        _viewHeader.width = SCREEN_WIDTH;
    }
    return _viewHeader;
}
- (UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [UIView new];
        _viewBottom.backgroundColor = [UIColor clearColor];
        YellowButton *btn = [YellowButton new];
        [btn resetViewWithWidth:W(335) :W(45) :@"同意"];
        WEAKSELF
        btn.blockClick = ^{
            [weakSelf btnAdmitClick];
        };
        btn.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        [_viewBottom addSubview:btn];
        
        YellowButton *btnRefuse = [YellowButton new];
        [btnRefuse resetWhiteViewWithWidth:W(335) :W(45) :@"驳回"];
        btnRefuse.blockClick = ^{
            [weakSelf btnRefuseClick];
        };
        btnRefuse.centerXTop = XY(SCREEN_WIDTH/2.0,btn.bottom + W(18));
        [_viewBottom addSubview:btnRefuse];
        _viewBottom.widthHeight = XY(SCREEN_WIDTH, btnRefuse.bottom + W(15)+iphoneXBottomInterval);
    }
    return _viewBottom;
}
- (CertificateDealDetailView *)voteView{
    if (!_voteView) {
        _voteView = [CertificateDealDetailView new];
    }
    return _voteView;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    //add keyboard observe
    [self addObserveOfKeyboard];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:UnPackStr(self.modelItem.title) rightTitle:nil rightBlock:nil]];
}
- (void)configData{
    
    [self.viewHeader removeAllSubViews];
    [self.viewHeader addSubview:self.voteView];
    self.viewBottom.top = self.voteView.bottom;
    [self.viewHeader addSubview:self.viewBottom];
    
    self.viewHeader.height = self.viewBottom.bottom;
    self.tableView.tableFooterView = self.viewHeader;
    
    [self.tableView reloadData];
}


#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCell:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeight:indexPath];
}

#pragma mark request
- (void)requestDetail{
    
    [RequestApi requestCertSubmitDetailWithnNumber:self.modelItem.number delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        ModelCertificateContentDetail * model = [ModelCertificateContentDetail modelObjectWithDictionary:response];
        self.modelDetail = model;
        [self.voteView resetViewWithModel:model.template];
        [self configData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)btnAdmitClick{
    
}
- (void)btnRefuseClick{
    
}
@end
