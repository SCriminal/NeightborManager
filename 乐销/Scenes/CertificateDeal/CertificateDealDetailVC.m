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
#import "CertDetailTopView.h"

@interface CertificateDealDetailVC ()
@property (nonatomic, strong) CertDetailTopView *topView;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) CertificateDealDetailView *voteView;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) ModelCertificateContentDetail *modelDetail;

@end

@implementation CertificateDealDetailVC
- (CertDetailTopView *)topView{
    if (!_topView) {
        _topView = [CertDetailTopView new];
        [_topView resetViewWithModel:self.modelItem];
    }
    return _topView;
}
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
//        _voteView.userInteractionEnabled = false;
        _voteView.isParticipated = true;
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
    [self requestDetail];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"参与详情" rightTitle:nil rightBlock:nil]];
}
- (void)configData{
    
    [self.viewHeader removeAllSubViews];
    [self.viewHeader addSubview:self.topView];
    
    self.voteView.top = self.topView.bottom;
    [self.viewHeader addSubview:self.voteView];
    
    self.viewHeader.height = self.voteView.bottom;

    if (self.modelItem.status == 1) {
        self.viewBottom.top = self.voteView.bottom;
        [self.viewHeader addSubview:self.viewBottom];
        self.viewHeader.height = self.viewBottom.bottom;
    }

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
        [self.voteView resetViewWithModel:model.participant];
        [self configData];
        
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)btnAdmitClick{
    [GlobalMethod showEditAlertWithTitle:@"提示" content:@"您确定要通过吗？" dismiss:^{
        
    } confirm:^{
        [self requestAdmit:true];
    } view:self.view];
}
- (void)btnRefuseClick{
    [GlobalMethod showEditAlertWithTitle:@"提示" content:@"您确定要驳回吗？" dismiss:^{
        
    } confirm:^{
        [self requestAdmit:false];
    } view:self.view];
}

- (void)requestAdmit:(BOOL)isAdmit{
    [RequestApi requestCertDisposalAuditWithIsapproval:isAdmit?1:0 number:self.modelItem.number delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.modelItem.status = isAdmit?2:3;
        self.modelItem = [ModelCertificateDealDetail modelObjectWithDictionary:self.modelItem.dictionaryRepresentation];
        [self.topView resetViewWithModel:self.modelItem];
        [self configData];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_CERT_NOTICE_REFERSH object:nil];
        [GlobalMethod showAlert:isAdmit?@"已办理":@"已驳回"];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
