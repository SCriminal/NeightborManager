//
//  GlobalData.m
//  ChinaDream
//
//  Created by zhangfeng on 12-11-26.
//  Copyright (c) 2012年 eastedge. All rights reserved.
//

#import "GlobalData.h"

UINavigationController *GB_Nav = nil;

@implementation GlobalData
@synthesize GB_UserModel = _GB_UserModel;
@synthesize GB_CompanyModel = _GB_CompanyModel;
@synthesize GB_Key = _GB_Key;
@synthesize community = _community;

#pragma mark 实现单例
SYNTHESIZE_SINGLETONE_FOR_CLASS(GlobalData);

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化状态栏
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}
//set get companymodel
- (void)setGB_CompanyModel:(ModelCompany *)GB_CompanyModel{
    [GlobalMethod writeStr:GB_CompanyModel != nil?[GlobalMethod exchangeModelToJson:GB_CompanyModel]:@"" forKey:LOCAL_COMPANYMODEL];
    _GB_CompanyModel = GB_CompanyModel;
    if (_GB_CompanyModel) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_COMPANY_MODEL_CHANGE object:nil];
    }
}

- (ModelCompany *)GB_CompanyModel{
    if (_GB_CompanyModel.iDProperty == 0) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_COMPANYMODEL]];
        _GB_CompanyModel = [ModelCompany modelObjectWithDictionary:dicItem];
    }
    return _GB_CompanyModel;
}
+ (void)saveCompanyModel{
    [[GlobalData sharedInstance] GB_CompanyModel];
    [GlobalData sharedInstance].GB_CompanyModel = [GlobalData sharedInstance].GB_CompanyModel;
    
}
//set get userModel
- (void)setGB_UserModel:(ModelUser *)GB_UserModel{
    [GlobalMethod writeModel:GB_UserModel key:LOCAL_USERMODEL];
    _GB_UserModel = GB_UserModel;

    if (GB_UserModel) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_SELFMODEL_CHANGE object:nil];
    }
}
- (ModelUser *)GB_UserModel{
    if (!isStr(_GB_UserModel.account)) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_USERMODEL]];
        _GB_UserModel = [ModelUser modelObjectWithDictionary:dicItem];
    }
    return _GB_UserModel;
}

//set get key
- (void)setGB_Key:(NSString *)GB_Key{
    [GlobalMethod writeStr:GB_Key!=nil?GB_Key:@"" forKey:LOCAL_KEY];
    _GB_Key = GB_Key;
}
- (NSString*)GB_Key{
    if (!isStr(_GB_Key)){
        _GB_Key = [GlobalMethod readStrFromUser:LOCAL_KEY];
    }
    return _GB_Key;
}

//set get key
- (void)setCommunity:(ModelCommunity *)community{
    _community = community;
    [GlobalMethod writeModel:community key:LOCAL_COMMUNITY exchange:false];
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_COMMUNITY_REFERSH object:nil];
}
-(ModelCommunity *)community{
    if (!_community.iDProperty) {
        NSDictionary * dicItem = [GlobalMethod exchangeStringToDic:[GlobalMethod readStrFromUser:LOCAL_COMMUNITY exchange:false]];
        _community = [ModelCommunity modelObjectWithDictionary:dicItem];
    }
    return _community;
}

#pragma mark lazy init
//set Notice View
- (NoticeView *)GB_NoticeView{
    if (_GB_NoticeView == nil) {
        _GB_NoticeView = [NoticeView new];
    }
    return _GB_NoticeView;
}

+ (void)saveUserModel{
    [GlobalData sharedInstance].GB_UserModel = [GlobalData sharedInstance].GB_UserModel;
}

@end
