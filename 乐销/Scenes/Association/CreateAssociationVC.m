//
//  CreateAssociationVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "CreateAssociationVC.h"
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

@interface CreateAssociationVC ()
@property (nonatomic, strong) ModelBaseData *modelNumber;
@property (nonatomic, strong) ModelBaseData *modelName;
@property (nonatomic, strong) ModelBaseData *modelLeaderName;
@property (nonatomic, strong) ModelBaseData *modelPhone;
@property (nonatomic, strong) ModelBaseData *modelAssociationDetail;
@property (nonatomic, strong) YellowButton  *btnBottom;
@property (nonatomic, strong) YellowButton  *btnDelete;

@end

@implementation CreateAssociationVC

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
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确认删除社团?" dismiss:^{
                
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
            model.string = @"社团名称";
            model.subString = self.model.name;
            model.placeHolderString = @"请输入社团名称";
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
            model.placeHolderString = @"请输入团长联系电话";
            return model;
        }();
    }
    return _modelPhone;
}
- (ModelBaseData *)modelLeaderName{
    if (!_modelLeaderName) {
        _modelLeaderName = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.imageName = @"";
            model.string = @"团长姓名";
            model.subString = self.model.leaderName;
            model.placeHolderString = @"请输入团长姓名";
            return model;
        }();
    }
    return _modelLeaderName;
}
- (ModelBaseData *)modelAssociationDetail{
    if (!_modelAssociationDetail) {
        _modelAssociationDetail = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_ADDRESS;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.hideState = true;
            model.imageName = @"";
            model.string = @"社团介绍";
            model.subString = self.model.internalBaseClassDescription;
            model.placeHolderString = @"请输入社团介绍内容";
            return model;
        }();
    }
    return _modelAssociationDetail;
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
    WEAKSELF
    BaseNavView *nav = [BaseNavView initNavBackTitle:self.model.iDProperty?@"编辑社团": @"添加社团" rightTitle:self.model.iDProperty?@"删除社团":@"" rightBlock:^{
        if (weakSelf.model.iDProperty) {
            [GlobalMethod showEditAlertWithTitle:@"提示" content:@"确定删除社团?" dismiss:^{
                
            } confirm:^{
                [weakSelf requestDelete];
            } view:weakSelf.view];
        }
    }];
    [self.view addSubview:nav];
}

#pragma mark config data
- (void)configData{
    
    self.aryDatas = @[ self.modelName,self.modelLeaderName,self.modelPhone,self.modelAssociationDetail].mutableCopy;
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
        [RequestApi requestEditAssociationWithName:self.modelName.subString leaderName:self.modelLeaderName.subString logoUrl:@"" description:self.modelAssociationDetail.subString phone:self.modelPhone.subString id:self.model.iDProperty scopeId:7 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalMethod showAlert:@"编辑成功"];
            [GB_Nav popViewControllerAnimated:true];

        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
        
        return;
    }
    [RequestApi requestAddAssociationWithAreaid:7 name:self.modelName.subString leaderName:self.modelLeaderName.subString description:self.modelAssociationDetail.subString logoUrl:@"" phone:self.modelPhone.subString scopeId:7 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"添加成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)requestDelete{
    [RequestApi requestDeleteAssociationWithId:self.model.iDProperty scopeId:0 delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"删除成功"];
        [GB_Nav popViewControllerAnimated:true];

    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
   
}
@end
