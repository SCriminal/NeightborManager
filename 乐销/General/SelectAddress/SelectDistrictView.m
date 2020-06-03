//
//中车运
//
//  Created by 隋林栋 on 2018/11/7.
//Copyright © 2018 ping. All rights reserved.
//

#import "SelectDistrictView.h"
//request
#import "RequestApi+Neighbor.h"

@interface SelectDistrictView ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) NSMutableArray *provinceArray;
@property (strong, nonatomic) NSMutableArray *cityArray;
@property (strong, nonatomic) NSMutableArray *areaArray;
@property (strong, nonatomic) ModelProvince *modelProvinceSelected;
@property (strong, nonatomic) ModelProvince *modelCitySelected;
@property (strong, nonatomic) ModelProvince *modelAreaSelected;
@property (nonatomic, strong) UIView *viewBG;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *iconClose;
@property (nonatomic, strong) UIButton *btnProvince;
@property (nonatomic, strong) UIButton *btnCity;
@property (nonatomic, strong) UIButton *btnArea;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int indexSelect;
@property (nonatomic, readonly) NSMutableArray *aryDatas;

@end

@implementation SelectDistrictView

#pragma mark lazy init
-(NSMutableArray *)aryDatas{
    switch (self.indexSelect) {
        case 0:
             return self.provinceArray;
            break;
            case 1:
             return self.cityArray;
            break;
            case 2:
             return self.areaArray;
            break;
        default:
            break;
    }
    return nil;
}
-(UIButton *)btnProvince{
    if (_btnProvince == nil) {
        _btnProvince = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnProvince.tag = 0;
        [_btnProvince addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnProvince.backgroundColor = [UIColor clearColor];
        _btnProvince.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        _btnProvince.widthHeight = XY(W(30),W(50));

    }
    return _btnProvince;
}
-(UIButton *)btnCity{
    if (_btnCity == nil) {
        _btnCity = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCity.tag = 1;
        [_btnCity addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnCity.backgroundColor = [UIColor clearColor];
        _btnCity.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        _btnCity.widthHeight = XY(W(30),W(50));

    }
    return _btnCity;
}
-(UIButton *)btnArea{
    if (_btnArea == nil) {
        _btnArea = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnArea.tag = 2;
        [_btnArea addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnArea.backgroundColor = [UIColor clearColor];
        _btnArea.titleLabel.font = [UIFont systemFontOfSize:F(15)];
        _btnArea.widthHeight = XY(W(30),W(50));

    }
    return _btnArea;
}

- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
        [_title fitTitle:@"选择所在地区" variable:0];
    }
    return _title;
}
- (UIImageView *)iconClose{
    if (_iconClose == nil) {
        _iconClose = [UIImageView new];
        _iconClose.image = [UIImage imageNamed:@"inputClose"];
        _iconClose.widthHeight = XY(W(25),W(25));
    }
    return _iconClose;
}
- (UIView *)viewBG{
    if (_viewBG == nil) {
        _viewBG = [UIView new];
        _viewBG.backgroundColor = [UIColor whiteColor];
        _viewBG.widthHeight = XY(SCREEN_WIDTH, W(547)+iphoneXBottomInterval);
        [_viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:15 lineWidth:0 lineColor:[UIColor clearColor]];
    }
    return _viewBG;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
        }
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SelectDistrictCell class] forCellReuseIdentifier:@"SelectDistrictCell"];
    }
    return _tableView;
}
- (LoadingView *)loadingView{
    if (_loadingView == nil) {
        _loadingView = [LoadingView new];
    }
    return _loadingView;
}
- (NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [GlobalMethod readAry:LOCAL_PROVINCE_LIST modelName:@"ModelProvince"];
    }
    return _provinceArray;
}
- (NSMutableArray *)cityArray{
    if (!_cityArray) {
        _cityArray = [NSMutableArray new];
    }
    return _cityArray;
}
- (NSMutableArray *)areaArray{
    if (!_areaArray) {
        _areaArray = [NSMutableArray new];
    }
    return _areaArray;
}
#pragma mark  init
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self addSubview:self.viewBG];
           
        [self addSubview:self.title];
        [self addSubview:self.iconClose];
        [self addSubview:self.btnProvince];
        [self addSubview:self.btnCity];
        [self addSubview:self.btnArea];
        [self addSubview:self.tableView];
        [self configView];
        [self requestProvinceList];
        [GlobalMethod endEditing];
    }
    return self;
}
#pragma mark 刷新view
- (void)configView{
    //刷新view
       self.viewBG.leftBottom = XY(0,SCREEN_HEIGHT);
       self.title.leftTop = XY(W(20),self.viewBG.top+W(20));


    self.iconClose.rightCenterY = XY(SCREEN_WIDTH - W(15),self.title.centerY);
    
    [self addControlFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.iconClose.bottom+W(5)) belowView:self.iconClose target:self action:@selector(cancelClick)];
    
    self.btnProvince.leftTop = XY(0, self.title.bottom+W(17.5));
    self.btnCity.leftTop = XY(0, self.title.bottom+W(17.5));
    self.btnArea.leftTop = XY(0, self.title.bottom+W(17.5));

    [self reconfigBtn];
    
    self.tableView.leftTop = XY(0,self.btnArea.bottom+W(17.5));
    self.tableView.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT - self.tableView.top);

}
- (void)reconfigBtn{
    [self.btnProvince setTitleColor:(self.indexSelect ==0)?COLOR_ORANGE:COLOR_999 forState:UIControlStateNormal];
    [self.btnCity setTitleColor:self.indexSelect ==1?COLOR_ORANGE:COLOR_999 forState:UIControlStateNormal];
    [self.btnArea setTitleColor:self.indexSelect ==2?COLOR_ORANGE:COLOR_999 forState:UIControlStateNormal];
    
    [self.btnProvince setTitle:isStr(self.modelProvinceSelected.name)?self.modelProvinceSelected.name:@"选择省份" forState:UIControlStateNormal];
    [self.btnCity setTitle:isStr(self.modelCitySelected.name)?self.modelCitySelected.name:@"选择城市" forState:UIControlStateNormal];
    [self.btnArea setTitle:isStr(self.modelAreaSelected.name)?self.modelAreaSelected.name:@"选择区县" forState:UIControlStateNormal];

    self.btnProvince.width = [self.btnProvince.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.btnProvince.titleLabel.font.pointSize]}].width + W(40);
    self.btnCity.width = [self.btnCity.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.btnProvince.titleLabel.font.pointSize]}].width + W(40);
    self.btnArea.width = [self.btnArea.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.btnProvince.titleLabel.font.pointSize]}].width + W(40);
    
    self.btnProvince.left = 0;
    self.btnCity.left = self.btnProvince.right;
    self.btnArea.left = self.btnCity.right;
    self.btnCity.hidden = self.indexSelect!=1 && self.modelCitySelected == nil;
    self.btnArea.hidden = self.indexSelect!=2 && self.modelAreaSelected == nil;
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    self.indexSelect = sender.tag;
    [self reconfigBtn];
    [self.tableView reloadData];
   
}
#pragma mark request
- (void)requestProvinceList {
    [RequestApi requestProvinceWithDelegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.provinceArray = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelProvince"];
        [GlobalMethod writeAry:self.provinceArray key:LOCAL_PROVINCE_LIST];
        self.indexSelect = 0;
        self.modelProvinceSelected = nil;
        self.modelCitySelected = nil;
        self.modelAreaSelected = nil;
        [self reconfigBtn];
        [self.tableView reloadData];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
- (void)requestCityList:(ModelProvince *)modelPro {
    
    [RequestApi requestCityWithId:modelPro.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.cityArray = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelProvince"];
        self.indexSelect = 1;
        self.modelCitySelected = nil;
        self.modelAreaSelected = nil;
        [self reconfigBtn];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

    }];
}
- (void)requestDistrictList:(ModelProvince *)modelPro  {
    [RequestApi requestAreaWithId:modelPro.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        self.areaArray = [GlobalMethod exchangeDic:response toAryWithModelName:@"ModelProvince"];
        self.indexSelect = 2;
        self.modelAreaSelected = nil;
        [self reconfigBtn];
        [self.tableView reloadData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {

    }];
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.aryDatas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectDistrictCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SelectDistrictCell" forIndexPath:indexPath];
    [cell resetCellWithModel:self.aryDatas[indexPath.row]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [SelectDistrictCell fetchHeight:self.aryDatas[indexPath.row]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelProvince * model = self.aryDatas[indexPath.row];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:0];
    
    switch (self.indexSelect) {
        case 0:
        {
            self.modelProvinceSelected = model;
            [self requestCityList:model];
        }
            break;
            case 1:
        {
            self.modelCitySelected = model;
            [self requestDistrictList:model];
        }
            break;
            case 2:
        {
            self.modelAreaSelected = model;
            if (self.blockCitySeleted) {
                self.blockCitySeleted(self.modelProvinceSelected, self.modelCitySelected, self.modelAreaSelected);
            }
            [self removeFromSuperview];

        }
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

#pragma mark 请求过程回调
- (void)protocolWillRequest{
    [self showLoadingView];
}
//show loading view
- (void)showLoadingView{
    [self.loadingView hideLoading];
    [self.loadingView resetFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT) viewShow:self];
}
- (void)protocolDidRequestSuccess{
    [self.loadingView hideLoading];
}
- (void)protocolDidRequestFailure:(NSString *)errorStr{
    [self.loadingView hideLoading];
}

#pragma mark click
- (void)cancelClick{
    [self removeFromSuperview];
}

@end


@implementation SelectDistrictCell
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = COLOR_333;
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _title;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.title];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelProvince *)model{
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.title fitTitle:UnPackStr(model.name) variable:SCREEN_WIDTH - W(40)];
    self.title.leftTop = XY(W(20),W(12.5));

    //设置总高度
    self.height = self.title.bottom+W(12.5);
}

@end
