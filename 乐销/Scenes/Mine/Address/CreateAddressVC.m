//
//  CreateAddressVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateAddressVC.h"
//keyboard observe
#import "BaseTableVC+KeyboardObserve.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"
#import "BaseTableVC+Authority.h"
#import "YellowButton.h"
//request
#import "RequestApi+Neighbor.h"
//add
#import "SelectDistrictView.h"

@interface CreateAddressVC ()
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelDistrict;
@property (nonatomic, strong) ModelBaseData *modelAddressDetail;
@property (nonatomic, strong) YellowButton  *btnBottom;
@property (nonatomic, strong) YellowButton  *btnDelete;

@end

@implementation CreateAddressVC

#pragma mark lazy init
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(325) :W(45) :@"提交"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestAdd];
        };
    }
    return _btnBottom;
}
- (YellowButton *)btnDelete{
    if (!_btnDelete) {
        _btnDelete = [YellowButton new];
        _btnDelete.hidden = self.model.iDProperty==0;
        _btnDelete.hidden = true;
        [_btnDelete resetWhiteViewWithWidth:W(325) :W(45) :@"删除"];
        WEAKSELF
        _btnDelete.blockClick = ^{
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确认删除地址?" dismiss:^{
                
            } confirm:^{
                [weakSelf requestDelete];
            } view:weakSelf.view];
        };

    }
    return _btnDelete;
}
- (ModelBaseData *)modelName{
    if (!_modelName) {
        _modelName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"收货人";
            model.subString = self.model.contact;
            model.placeHolderString = @"请输入收货人姓名";
            return model;
        }();
    }
    return _modelName;
}
- (ModelBaseData *)modelPhone{
    if (!_modelPhone) {
        _modelPhone = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"联系电话";
            model.subString = self.model.phone;
            model.placeHolderString = @"请输入手机号码";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelDistrict{
    if (!_modelDistrict) {
        _modelDistrict = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"所在地区";
            if (self.model.iDProperty) {
                model.subString = [NSString stringWithFormat:@"%@%@%@",UnPackStr(self.model.provinceName),UnPackStr(self.model.cityName),UnPackStr(self.model.countyName)];
                model.identifier = strDotF(self.model.countyId);
            }
            model.placeHolderString = @"请选择省/市/区";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                SelectDistrictView * selectView = [SelectDistrictView new];
                selectView.blockCitySeleted = ^(ModelProvince *pro, ModelProvince *city, ModelProvince *area) {
                    weakSelf.modelDistrict.subString = [NSString stringWithFormat:@"%@%@%@",pro.name,[pro.name isEqualToString:city.name]?@"":city.name,area.name];
                    weakSelf.modelDistrict.identifier = strDotF(area.iDProperty);
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:selectView];
            };
            return model;
        }();
    }
    return _modelDistrict;
}
- (ModelBaseData *)modelAddressDetail{
    if (!_modelAddressDetail) {
        _modelAddressDetail = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_ADDRESS;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.imageName = @"";
            model.string = @"详细地址";
            model.subString = self.model.detail;
            model.placeHolderString = @"请输入详细地址";
            //            model.subString = [GlobalData sharedInstance].GB_UserModel.account;
            return model;
        }();
    }
    return _modelAddressDetail;
}
#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //table
    self.tableView.tableFooterView = ^(){
        UIView * footer = [UIView new];
        [footer addSubview:self.btnBottom];
        self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(35));
        
        [footer addSubview:self.btnDelete];
        self.btnDelete.centerXTop = XY(SCREEN_WIDTH/2.0, self.btnBottom.bottom+W(20));

        footer.widthHeight = XY(SCREEN_WIDTH, self.btnDelete.bottom);
        return footer;
    }();
    [self registAuthorityCell];
    
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView *nav = [BaseNavView initNavBackTitle:self.model.iDProperty?@"编辑地址": @"添加地址" rightTitle:@"" rightBlock:^{
    }];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    
    self.aryDatas = @[ self.modelName,self.modelPhone,self.modelDistrict,self.modelAddressDetail].mutableCopy;
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

- (void)requestAdd{
    [GlobalMethod endEditing];
    for (ModelBaseData *model  in self.aryDatas) {
        if (model.enumType == ENUM_PERFECT_CELL_TEXT||model.enumType == ENUM_PERFECT_CELL_SELECT||model.enumType == ENUM_PERFECT_CELL_ADDRESS) {
            if (!isStr(model.subString)) {
                [GlobalMethod showAlert:model.placeHolderString];
                return;
            }
        }
    }
    if (self.model.iDProperty) {
        [RequestApi requestEditAddressWithCountyid:self.modelDistrict.identifier.doubleValue detail:self.modelAddressDetail.subString contact:self.modelName.subString contactPhone:self.modelPhone.subString lng:nil lat:nil id:self.model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"编辑成功"];
            [GB_Nav popViewControllerAnimated:true];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];

        return;
    }
    [RequestApi requestAddAddressWithCountyid:self.modelDistrict.identifier.doubleValue detail:self.modelAddressDetail.subString contact:self.modelName.subString contactPhone:self.modelPhone.subString lng:nil lat:nil delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}

- (void)requestDelete{
    WEAKSELF
    [RequestApi requestDeleteAddressWithId:self.model.iDProperty delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end
