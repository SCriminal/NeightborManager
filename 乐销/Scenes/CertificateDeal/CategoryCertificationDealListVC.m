//
//  CategoryCertificationDealListVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CategoryCertificationDealListVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "CertificationSubmitTabVC.h"

@interface CategoryCertificationDealListVC ()

@end

@implementation CategoryCertificationDealListVC

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    [self.tableView registerClass:[CategoryCertificationDealListCell class] forCellReuseIdentifier:@"CategoryCertificationDealListCell"];
    //request
    [self requestList];
    [self addRefresh];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"社区办事" rightView:nil]];
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
    CategoryCertificationDealListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCertificationDealListCell"];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CategoryCertificationDealListCell fetchHeight:self.aryDatas[indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelCertificateDealDetail * model = self.aryDatas[indexPath.row];
    CertificationSubmitTabVC * vc = [CertificationSubmitTabVC new];
    vc.navTitle = model.title;
    vc.categoryID = model.iDProperty;
    [GB_Nav pushViewController:vc animated:true];
}

#pragma mark request
- (void)requestList{
    [RequestApi requestCertificationDealCategoryListWithCategoryalias:nil page:self.pageNum count:50 areaId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
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



@implementation CategoryCertificationDealListCell
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
    }
    return _name;
}
- (UILabel *)category{
    if (_category == nil) {
        _category = [UILabel new];
        _category.textColor = COLOR_999;
        _category.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _category.numberOfLines = 1;
    }
    return _category;
}
- (UILabel *)num{
    if (_num == nil) {
        _num = [UILabel new];
        _num.textColor = COLOR_999;
        _num.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _num.numberOfLines = 1;
    }
    return _num;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.category];
    [self.contentView addSubview:self.num];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelCertificateDealDetail *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.name fitTitle:UnPackStr(model.title) variable:SCREEN_WIDTH - W(30)];
    self.name.leftTop = XY(W(15),W(18));
    [self.category fitTitle:UnPackStr(model.categoryName) variable:W(180)];
    self.category.leftTop = XY(self.name.left,self.name.bottom+W(12));
    [self.num fitTitle:[NSString stringWithFormat:@"已提交0   已办理0"] variable:0];
    self.num.rightTop = XY(SCREEN_WIDTH -  W(15),self.category.top);

    //设置总高度
    self.height = [self.contentView addLineFrame:CGRectMake(W(15), self.category.bottom + W(18), SCREEN_WIDTH - W(30), 1)];
}

@end
