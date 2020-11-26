//
//  SendWhistleVC.m
//  Neighbor
//
//  Sendd by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "SendWhistleVC.h"
//sub view
#import "SendWhistleView.h"
#import "YellowButton.h"
#import "BaseTableVC+Authority.h"
//image select
#import "BaseVC+BaseImageSelectVC.h"
//request
#import "RequestApi+Neighbor.h"
#import "DatePicker.h"
#import "SelectDepartmentVC.h"
//selectCommunityView
#import "SelectCommunityPickerView.h"
#import "UITextField+Text.h"
#import "SelectWhistleTypeVC.h"
#import "BaseVC+Location.h"

@interface SendWhistleVC ()
@property (nonatomic, strong) SendWhistleTopView *topView;
@property (nonatomic, strong) SendWhistleMidView *midView;
@property (nonatomic, strong) NSArray *ary0;
@property (nonatomic, strong) NSArray *ary1;
@property (nonatomic, strong) ModelBaseData *modelTime;
@property (nonatomic, strong) ModelBaseData *modelDepartment;
@property (nonatomic, strong) ModelBaseData *modelCommunity;
@property (nonatomic, strong) ModelBaseData *modelBuilding;
@property (nonatomic, strong) ModelBaseData *modelUnite;
@property (nonatomic, strong) ModelBaseData *modelRoom;
@property (nonatomic, strong) ModelBaseData *modelCategory;

@property (nonatomic, strong) YellowButton  *btnBottom;
@property (nonatomic, strong) NSArray *aryDepartment;

@end

@implementation SendWhistleVC
#pragma mark 懒加载
- (YellowButton *)btnBottom{
    if (!_btnBottom) {
        _btnBottom = [YellowButton new];
        [_btnBottom resetViewWithWidth:W(335) :W(45) :@"提交"];
        WEAKSELF
        _btnBottom.blockClick = ^{
            [weakSelf requestAdd];
        };
    }
    return _btnBottom;
}
- (SendWhistleTopView *)topView{
    if (!_topView) {
        _topView = [SendWhistleTopView new];
    }
    return _topView;
}
- (SendWhistleMidView *)midView{
    if (!_midView) {
        _midView = [SendWhistleMidView new];
    }
    return _midView;
}
- (NSArray *)ary0{
    if (!_ary0) {
        _ary0 = @[self.modelTime,self.modelCategory];
        //        _ary0 = @[self.modelCommunity,self.modelBuilding,self.modelUnite,self.modelRoom];
        
    }
    return _ary0;
}
- (NSArray *)ary1{
    if (!_ary1) {
        _ary1 = @[self.modelTime,self.modelDepartment];
    }
    return _ary1;
}
- (ModelBaseData *)modelTime{
    if (!_modelTime) {
        _modelTime = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"发现时间";
            model.placeHolderString = @"请选择时间";
            model.subString = [GlobalMethod exchangeDate:[NSDate date] formatter:TIME_MIN_SHOW];
            //            model.hideState = true;
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                DatePicker * datePickerView = [DatePicker initWithMinDate:[GlobalMethod exchangeStringToDate:@"1900" formatter:@"yyyy"] dateSelectBlock:^(NSDate *date) {
                    weakSelf.modelTime.subString = [GlobalMethod exchangeDate:date formatter:TIME_MIN_SHOW];
                    [weakSelf configData];
                } type:ENUM_PICKER_DATE_YEAR_MONTH_DAY_HOUR_MIN];
                [datePickerView.datePicker selectDate:isStr(weakSelf.modelTime.subString)?[GlobalMethod exchangeStringToDate:weakSelf.modelTime.subString formatter:TIME_MIN_SHOW]:[NSDate date]];
                [weakSelf.view addSubview:datePickerView];
            };
            return model;
        }();
    }
    return _modelTime;
}
- (ModelBaseData *)modelDepartment{
    if (!_modelDepartment) {
        _modelDepartment = ^(){
            WEAKSELF
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"吹哨部门";
            model.placeHolderString = @"请选择吹哨部门";
            model.hideState = true;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.blocClick = ^(ModelBaseData *item) {
                SelectDepartmentVC * selectVC = [SelectDepartmentVC new];
                selectVC.blockSelected = ^(NSMutableArray *ary) {
                    weakSelf.aryDepartment = ary;
                    NSString * strName = [[ary fetchValues:@"name"] componentsJoinedByString:@","];
                    weakSelf.modelDepartment.subString = strName;
                    [weakSelf configData];
                };
                selectVC.arySelected = [NSMutableArray arrayWithArray:weakSelf.aryDepartment];
                [GB_Nav pushViewController:selectVC animated:true];
                
            };
            return model;
        }();
    }
    return _modelDepartment;
}
- (ModelBaseData *)modelCategory{
    if (!_modelCategory) {
        _modelCategory = ^(){
            WEAKSELF
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.imageName = @"";
            model.string = @"问题分类";
            model.placeHolderString = @"请选择问题分类";
            model.hideState = true;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.blocClick = ^(ModelBaseData *item) {
                SelectWhistleTypeVC * vc = [SelectWhistleTypeVC new];
                vc.blockSelected = ^(ModelTrolley *model) {
                    weakSelf.modelCategory.subString = model.name;
                    weakSelf.modelCategory.identifier = NSNumber.dou(model.iDProperty).stringValue;
                    [weakSelf.tableView reloadData];
                };
                [GB_Nav pushViewController:vc animated:true];
                
            };
            return model;
        }();
    }
    return _modelCategory;
}

- (ModelBaseData *)modelCommunity{
    if (!_modelCommunity) {
        _modelCommunity = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_SELECT;
            model.locationType = ENUM_CELL_LOCATION_TOP;
            model.imageName = @"";
            model.string = @"发哨小区";
            model.placeHolderString = @"请选择发哨小区";
            WEAKSELF
            model.blocClick = ^(ModelBaseData *model) {
                [GlobalMethod endEditing];
                SelectCommunityPickerView * viewSelect = [SelectCommunityPickerView new];
                viewSelect.blockSeleted = ^(ModelUserAuthority *selected) {
                    weakSelf.modelCommunity.subString = selected.name;
                    weakSelf.modelCommunity.identifier = strDotF(selected.iDProperty);
                    [weakSelf configData];
                };
                [weakSelf.view addSubview:viewSelect];
            };
            return model;
        }();
    }
    return _modelCommunity;
}
- (ModelBaseData *)modelBuilding{
    if (!_modelBuilding) {
        _modelBuilding = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_MID;
            model.imageName = @"";
            model.textType = ENUM_TEXT_CONTENT_TYPE_NUMBER;
            model.string = @"楼号";
            model.placeHolderString = @"请填写楼号（非必填）";
            return model;
        }();
    }
    return _modelBuilding;
}
- (ModelBaseData *)modelUnite{
    if (!_modelUnite) {
        _modelUnite = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_MID;
            model.imageName = @"";
            model.string = @"单元号";
            model.textType = ENUM_TEXT_CONTENT_TYPE_NUMBER;
            model.placeHolderString = @"请填写单元号（非必填）";
            return model;
        }();
    }
    return _modelUnite;
}
- (ModelBaseData *)modelRoom{
    if (!_modelRoom) {
        _modelRoom = ^(){
            ModelBaseData * model = [ModelBaseData new];
            model.enumType = ENUM_PERFECT_CELL_TEXT;
            model.locationType = ENUM_CELL_LOCATION_BOTTOM;
            model.imageName = @"";
            model.string = @"室号";
            model.textType = ENUM_TEXT_CONTENT_TYPE_NUMBER;
            model.placeHolderString = @"请填写室号（非必填）";
            return model;
        }();
    }
    return _modelRoom;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self.view addSubview:[BaseNavView initNavBackTitle:@"社区哨" rightView:nil]];
    self.tableView.backgroundColor = COLOR_GRAY;
    self.tableView.tableFooterView = ^(){
        UIView * footer = [UIView new];
        [footer addSubview:self.btnBottom];
        self.btnBottom.centerXTop = XY(SCREEN_WIDTH/2.0, W(15));
        footer.widthHeight = XY(SCREEN_WIDTH, self.btnBottom.bottom+W(15));
        return footer;
    }();
    [self registAuthorityCell];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //config data
    [self configData];
    //add keyboard observe
    [self addObserveOfKeyboard];
//    [self initLocation];
//    [self addLocalAuthorityListen];
}
- (void)fetchAddress:(ModelAddress *)clPlace{
    [GlobalMethod writeModel:clPlace key:LOCAL_LOCATION exchange:false];
}
#pragma mark config data
- (void)configData{
    self.tableView.tableHeaderView = self.topView;
    [self.tableView reloadData];
}
#pragma mark 选择图片
- (void)imagesSelect:(NSArray *)aryImages
{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_WHISTLE;
    
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        [self.topView.collection_Image.aryDatas insertObject:modelImageInfo atIndex:0];
    }
    [self.topView.collection_Image.collectionView reloadData];
}
#pragma mark UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//row num
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section?self.ary1.count:self.ary0.count;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self dequeueAuthorityCellWithModel:indexPath.section?self.ary1[indexPath.row]:self.ary0[indexPath.row]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self fetchAuthorityCellHeightWithModel:indexPath.section?self.ary1[indexPath.row]:self.ary0[indexPath.row]];
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return section==0?self.midView.height:CGFLOAT_MIN;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return section==0?self.midView:nil;
//}
#pragma mark request
- (void)requestAdd{
    [GlobalMethod endEditing];
    
    NSString * strImage = [[self.topView.collection_Image.aryDatas fetchValues:@"url"] componentsJoinedByString:@","];
    if (!isStr(strImage)) {
        [GlobalMethod showAlert:@"请先添加图片"];
        return;
    }
    NSString * strDes = self.topView.textView.text;
    if (!isStr(strDes)) {
        [GlobalMethod showAlert:@"请先填写问题描述"];
        return;
    }
    //    if (!self.modelCommunity.identifier.doubleValue) {
    //        [GlobalMethod showAlert:@"请先选择发哨小区"];
    //        return;
    //    }
    NSString * strReason = self.midView.textView.text;
    //    if (!isStr(strReason)) {
    //        [GlobalMethod showAlert:@"请先填写吹哨原因"];
    //        return;
    //    }
    //    if (!self.aryDepartment.count) {
    //        [GlobalMethod showAlert:@"请先选择发哨部门"];
    //        return;
    //    }
    NSString * strDep = [[self.aryDepartment fetchValues:@"code"] componentsJoinedByString:@","];
    double timeStamp = [GlobalMethod exchangeString:self.modelTime.subString formatter:TIME_MIN_SHOW].timeIntervalSince1970;
    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
    
    [RequestApi requestSendWhistleWithFindtime:timeStamp estateId:[GlobalData sharedInstance].GB_UserModel.areaID description:strDes urls:strImage realName:nil cellPhone:nil buildingName:self.modelBuilding.subString unitName:self.modelUnite.subString roomName:self.modelRoom.subString pushDescription:strReason pushCodes:strDep categoryId:self.modelCategory.identifier.doubleValue  lat:modelAddress.lat
                                           lng:modelAddress.lng delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalMethod showAlert:@"提交成功"];
        if (self.blockRequestSuccess) {
            self.blockRequestSuccess();
        }
        self.tableView.tableHeaderView = nil;
        [self.topView removeFromSuperview];
        [self cleanAllProperties];
        [self configData];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
    
}

- (void)cleanAllProperties{
    for (NSString * property in [self getAllProperties]) {
        if ([property isEqualToString:@"blockRequestSuccess"]) {
            continue;
        }
        if ([property isEqualToString:@"btnBottom"]) {
            continue;
        }
        [self setValue:nil forKeyPath:property];
        //        id value = [self valueForKey:property];
        //        value = nil;
    }
}
- (NSArray *)getAllProperties{
    
    u_int count = 0;
    
    //传递count的地址
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        
        //得到的propertyName为C语言的字符串
        
        const char *propertyName = property_getName(properties[i]);
        
        [propertyArray addObject:[NSString stringWithUTF8String:propertyName]];
        
        // NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        
    }
    
    free(properties);
    
    return propertyArray;
    
}
@end
