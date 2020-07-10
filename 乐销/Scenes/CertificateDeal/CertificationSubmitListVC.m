//
//  CertificationSubmitListVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificationSubmitListVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "CertificateDealDetailVC.h"

@interface CertificationSubmitListVC ()

@end

@implementation CertificationSubmitListVC
#pragma mark noresult view
@synthesize noResultView = _noResultView;
- (BOOL)isShowNoResult{
    return true;
}
- (NoResultView *)noResultView{
    if (!_noResultView) {
        _noResultView = [NoResultView new];
        [_noResultView resetWithImageName:@"empty_default" title:@"暂无可办理项目"];
    }
    return _noResultView;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[CertificationSubmitListCell class] forCellReuseIdentifier:@"CertificationSubmitListCell"];
    //request
    [self requestList];
    [self addRefreshHeader];
    [self addRefreshFooter];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:self.navTitle rightView:nil]];
}

#pragma mark UITableViewDelegate
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.aryDatas.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificationSubmitListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CertificationSubmitListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CertificationSubmitListCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CertificateDealDetailVC * detailVC = [CertificateDealDetailVC new];
    [GB_Nav pushViewController:detailVC animated:true];
}


#pragma mark request
- (void)requestList{
    [RequestApi requestCertificateDealCategoryListWithCategoryID:self.categoryID statuses:self.requestStatus page:self.pageNum count:50 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.pageNum ++;
        NSMutableArray  * aryRequest = [GlobalMethod exchangeDic:[response arrayValueForKey:@"list"] toAryWithModelName:@"ModelCertificateDealDetail"];
        if (self.isRemoveAll) {
            [self.aryDatas removeAllObjects];
        }
        if (!isAry(aryRequest)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.aryDatas addObjectsFromArray:aryRequest];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

    }];
}
@end



@implementation CertificationSubmitListCell
#pragma mark 懒加载
- (UILabel *)problem{
    if (_problem == nil) {
        _problem = [UILabel new];
        _problem.textColor = COLOR_333;
        _problem.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _problem.numberOfLines = 1;
        _problem.lineSpace = 0;
    }
    return _problem;
}
- (UILabel *)status{
    if (_status == nil) {
        _status = [UILabel new];
        _status.textColor = [UIColor whiteColor];
        _status.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _status.numberOfLines = 1;
        _status.lineSpace = 0;
    }
    return _status;
}
- (UIView *)labelBg{
    if (_labelBg == nil) {
        _labelBg = [UIView new];
        _labelBg.backgroundColor = COLOR_ORANGE;
        
    }
    return _labelBg;
}
- (UILabel *)time{
    if (_time == nil) {
        _time = [UILabel new];
        _time.textColor = COLOR_999;
        _time.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _time.numberOfLines = 1;
        _time.lineSpace = 0;
    }
    return _time;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.problem];
        [self.contentView addSubview:self.labelBg];
        [self.contentView addSubview:self.status];
        [self.contentView addSubview:self.time];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCertificateDealDetail *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    
    [self.status fitTitle:UnPackStr(model.statusShow) variable:0];
    
    self.labelBg.widthHeight = XY(self.status.width + W(13), W(18));
    self.labelBg.leftTop = XY(W(15),W(16.5));
    self.labelBg.backgroundColor = model.statusColorShow;
    [self.labelBg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0 lineColor:[UIColor clearColor]];
    
    self.status.center = self.labelBg.center;


    //刷新view
    [self.problem fitTitle:UnPackStr(model.number) variable:W(270)];
    self.problem.leftCenterY = XY(self.labelBg.right+W(8),self.labelBg.centerY);
    
    
    
    
    [self.time fitTitle:[GlobalMethod exchangeTimeWithStamp:model.createTime andFormatter:TIME_MIN_SHOW] variable:W(270)];
    self.time.leftTop = XY(W(15),self.labelBg.bottom+W(11.5));
    
    
    //设置总高度
    self.height = self.time.bottom + W(18);
    
    
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}


@end
