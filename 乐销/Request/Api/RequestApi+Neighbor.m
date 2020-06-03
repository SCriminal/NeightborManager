//
//  RequestApi+Neighbor.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/13.
//  Copyright © 2020 ping. All rights reserved.
//

#import "RequestApi+Neighbor.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
@implementation RequestApi (Neighbor)

/**
 获取验证码
 */
+(void)requestSendCodeWithCellPhone:(NSString *)cellPhone
                            smsType:(double)smsType
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"cellphone":RequestStrKey(cellPhone),
                          @"smsType":NSNumber.dou(smsType),
                          @"scope":@1};
    [self postUrl:@"/resident/smscode" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 登录(手机号自动注册)
 */
+(void)requestLoginWithCode:(NSString *)smsCode
                  cellPhone:(NSString *)cellPhone
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"2",
                          @"terminalType":@1,
                          @"terminalNumber":RequestStrKey([CloudPushSDK getDeviceId]),
                          @"cellphone":RequestStrKey(cellPhone),
                          @"smsCode":RequestStrKey(smsCode),
                          @"scope":@1};
    [self postUrl:@"/resident/auth/login/smscode" delegate:delegate parameters:dic success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
        [self requestUserInfoWithScope:0 delegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelUser * model = [ModelUser modelObjectWithDictionary:response];
            [GlobalData sharedInstance].GB_UserModel = model;
            if (success) {
                success(response,mark);
            }
        } failure:failure];
    }  failure:failure];
}

/**
 居民登录(手机号，密码)
 */
+(void)requestLoginWithAccount:(NSString *)account
                      password:(NSString *)password
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"2",
                          @"terminalType":@1,
                          @"account":RequestStrKey(account),
                          @"password":RequestStrKey([password base64Encode]),
                          @"terminalNumber":RequestStrKey([CloudPushSDK getDeviceId]),
                          @"scope":@1};
    [self postUrl:@"/auth/user/login/2" delegate:delegate parameters:dic success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [GlobalData sharedInstance].GB_Key = [response stringValueForKey:@"token"];
        [self requestUserInfoWithScope:0 delegate:delegate success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            ModelUser * model = [ModelUser modelObjectWithDictionary:response];
            [GlobalData sharedInstance].GB_UserModel = model;
            if (success) {
                success(response,mark);
            }
        } failure:failure];
    }  failure:failure];
}
/**
 获取忘记密码验证码
 */
+(void)requestSendForgetCodeAccount:(NSString *)account
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"account":RequestStrKey(account),
                          @"scope":@1};
    [self postUrl:@"/auth/smscode" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 忘记密码
 */
+(void)requestResetPwdWithAccount:(NSString *)account
                         password:(NSString *)password
                          smsCode:(NSString *)smsCode
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"account":RequestStrKey(account),
                          @"password":RequestStrKey([password base64Encode]),
                          @"smsCode":RequestStrKey(smsCode)};
    [self patchUrl:@"/auth/password/0" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 每日签到
 */
+(void)requestSignDayWithScore:(double)score
                   description:(NSString *)description
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"score":NSNumber.dou(score),
                          @"description":RequestStrKey(description),
                          @"channel":@1,
                          @"scope":@7};
    [self putUrl:@"/resident/score/day" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 积分数
 */
+(void)requestIntegralTotalDelegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@7};
    [self getUrl:@"/resident/score" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 操作记录
 */
+(void)requestIntegralRecordDelegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@7};
    [self getUrl:@"/resident/score/log/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":@4};
    [self getUrl:@"/resident/chinaarea/1/list" delegate:delegate parameters:dic success:success failure:failure];
    //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/1/list" delegate:delegate parameters:dic success:success failure:failure];
    
}
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/chinaarea/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    //    [self getUrl:@"http://112.253.1.72:10201/zhongcheyun/dict/containerarea/1/2/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    
}
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/chinaarea/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    
}
/**
 根据市查询所有区
 */
+(void)requestBlockWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@4};
    [self getUrl:@"/resident/chinaarea/3/list/{id}" delegate:delegate parameters:dic success:success failure:failure];
    
}


/**
 提交申请
 */
+(void)requestMerchantSigninWithStorename:(NSString *)storeName
                                bizNumber:(NSString *)bizNumber
                                 idNumber:(NSString *)idNumber
                                 realName:(NSString *)realName
                                   bizUrl:(NSString *)bizUrl
                            idPositiveUrl:(NSString *)idPositiveUrl
                            idNegativeUrl:(NSString *)idNegativeUrl
                             contactPhone:(NSString *)contactPhone
                              regCountyId:(double )regCountyId
                                  regAddr:(NSString *)regAddr
                                bizAreaId:(double)bizAreaId
                                  bizAddr:(NSString *)bizAddr
                                 delegate:(id <RequestDelegate>)delegate
                                  success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"storeName":RequestStrKey(storeName),
                          @"bizNumber":RequestStrKey(bizNumber),
                          @"idNumber":RequestStrKey(idNumber),
                          @"realName":RequestStrKey(realName),
                          @"bizUrl":RequestStrKey(bizUrl),
                          @"idPositiveUrl":RequestStrKey(idPositiveUrl),
                          @"idNegativeUrl":RequestStrKey(idNegativeUrl),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"regCountyId":NSNumber.dou(regCountyId),
                          @"regAddr":RequestStrKey(regAddr),
                          @"bizCountryId":@3,
                          @"bizCountyId":NSNumber.dou(bizAreaId),
                          @"bizAddr":RequestStrKey(bizAddr),
                          @"scope":@7};
    [self postUrl:@"/resident/store/submit" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 提交详情
 */
+(void)requestMerchantSiginDetailWithAreaId:(double)areaId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(4),
                          @"estateId":NSNumber.dou(areaId)};
    [self getUrl:@"/resident/store/submit" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 联系咨询
 */
+(void)requestMerchantConnectWithContactphone:(NSString *)contactPhone
                                      contact:(NSString *)contact
                                     delegate:(id <RequestDelegate>)delegate
                                      success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"contactPhone":RequestStrKey(contactPhone),
                          @"contact":RequestStrKey(contact),
                          @"scope":@7};
    [self postUrl:@"/resident/store/before" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 我的成员管理
 */
+(void)requestMemeberListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":@7};
    [self getUrl:@"/resident/resident/archive/member/list/total" delegate:delegate parameters:dic success:success failure:failure];
}



/**
 根据经纬度筛选
 */
+(void)requestSelectCommunityWithLng:(double)lng
                                 lat:(double)lat
                                name:(NSString *)name
                               scope:(double)scope
                                page:(double)page
                               count:(double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"lng":NSNumber.dou(lng),
                          @"lat":NSNumber.dou(lat),
                          @"name":RequestStrKey(name),
                          @"scope":NSNumber.dou(1),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/resident/estate/list" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestAddressListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/shippingaddr/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 删除
 */
+(void)requestDeleteAddressWithId:(double)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(4)};
    [self deleteUrl:@"/resident/shippingaddr/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增
 */
+(void)requestAddAddressWithCountyid:(double)countyId
                              detail:(NSString *)detail
                             contact:(NSString *)contact
                        contactPhone:(NSString *)contactPhone
                                 lng:(NSString *)lng
                                 lat:(NSString *)lat
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"countyId":NSNumber.dou(countyId),
                          @"detail":RequestStrKey(detail),
                          @"contact":RequestStrKey(contact),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"scope":NSNumber.dou(4)};
    [self postUrl:@"/resident/shippingaddr" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 编辑
 */
+(void)requestEditAddressWithCountyid:(double)countyId
                               detail:(NSString *)detail
                              contact:(NSString *)contact
                         contactPhone:(NSString *)contactPhone
                                  lng:(NSString *)lng
                                  lat:(NSString *)lat
id:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"countyId":NSNumber.dou(countyId),
                          @"detail":RequestStrKey(detail),
                          @"contact":RequestStrKey(contact),
                          @"contactPhone":RequestStrKey(contactPhone),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"id":NSNumber.dou(id),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/shippingaddr/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestNewsListWithScopeid:(double)scopeId
                             page:(double)page
                            count:(double)count
                       categoryId:(double)categoryId
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"categoryId":NSNumber.dou(categoryId),
                          @"scope":NSNumber.dou(1)};
    [self getUrl:@"/resident/content/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 修改
 */
+(void)requestEditPersonlInfoWithHeadurl:(NSString *)headUrl
                                nickname:(NSString *)nickname
                                   phone:(NSString *)phone
                                    addr:(NSString *)addr
                                  gender:(double)gender
                                   scope:(double)scope
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"headUrl":RequestStrKey(headUrl),
                          @"nickname":RequestStrKey(nickname),
                          @"phone":RequestStrKey(phone),
                          @"addr":RequestStrKey(addr),
                          @"gender":NSNumber.dou(gender),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/user" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取
 */
+(void)requestUserInfoWithScope:(double)scope
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(7)};
    NSString * strUrl = @"/admin/user/area/list/city";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
/**
 获取
 */
+(void)requestAuthorityCommunityWithScopeId:(double)scopeId
                       delegate:(id <RequestDelegate>)delegate
                        success:(void (^)(NSDictionary * response, id mark))success
                        failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(7),
                          @"scopeId":NSNumber.dou(scopeId)
    };
    NSString * strUrl = @"/admin/user/area/list/estate";
    [self getUrl:strUrl delegate:delegate parameters:dic success:success failure:failure];
}
/**
 列表
 */
+(void)requestArchiveListWithPage:(double)page
                            count:(double)count
                         estateId:(double)estateId
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"estateId":NSNumber.dou(estateId),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/resident/archive/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 新增
 */
+(void)requestAddArchiveWithEstateid:(double)estateId
                            realName:(NSString *)realName
                           cellPhone:(NSString *)cellPhone
                        buildingName:(NSString *)buildingName
                            unitName:(NSString *)unitName
                            roomName:(NSString *)roomName
                                 tag:(double)tag
                                 lng:(NSString *)lng
                                 lat:(NSString *)lat
                                 job:(NSString *)job
                          enterprise:(NSString *)enterprise
                              isPart:(double)isPart
                               scope:(NSString *)scope
                            idNumber:(NSString *)idNumber
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"estateId":NSNumber.dou(estateId),
                          @"realName":RequestStrKey(realName),
                          @"cellPhone":RequestStrKey(cellPhone),
                          @"buildingName":RequestStrKey(buildingName),
                          @"unitName":RequestStrKey(unitName),
                          @"roomName":RequestStrKey(roomName),
                          @"tag":NSNumber.dou(tag),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"job":RequestStrKey(job),
                          @"enterprise":RequestStrKey(enterprise),
                          @"idNumber":RequestStrKey(idNumber),
                          @"isParty":NSNumber.dou(isPart),
                          @"scope":NSNumber.dou(4)};
    [self postUrl:@"/resident/resident/archive" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 编辑
 */
+(void)requestEditArchiveWithEstateid:(double)estateId
                             realName:(NSString *)realName
                            cellPhone:(NSString *)cellPhone
                         buildingName:(NSString *)buildingName
                             unitName:(NSString *)unitName
                             roomName:(NSString *)roomName
                                  tag:(double)tag
                                  lng:(NSString *)lng
                                  lat:(NSString *)lat
                                  job:(NSString *)job
                           enterprise:(NSString *)enterprise
                               isPart:(double)isPart
                             identity:(double)identity
                                scope:(NSString *)scope
                             idNumber:(NSString *)idNumber
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"estateId":NSNumber.dou(estateId),
                          @"realName":RequestStrKey(realName),
                          @"cellPhone":RequestStrKey(cellPhone),
                          @"buildingName":RequestStrKey(buildingName),
                          @"unitName":RequestStrKey(unitName),
                          @"roomName":RequestStrKey(roomName),
                          @"tag":NSNumber.dou(tag),
                          @"lng":RequestStrKey(lng),
                          @"lat":RequestStrKey(lat),
                          @"job":RequestStrKey(job),
                          @"enterprise":RequestStrKey(enterprise),
                          @"isParty":NSNumber.dou(isPart),
                          @"id":NSNumber.dou(identity),
                          @"idNumber":RequestStrKey(idNumber),
                          @"scope":NSNumber.dou(4)};
    [self patchUrl:@"/resident/resident/archive/{id}" delegate:delegate parameters:dic success:success failure:failure];
}





/**
 列表
 */
+(void)requestShopProductWithscopeId:(NSString *)scopeId
                             storeId:(double)storeId
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          @"storeId":NSNumber.dou(storeId),
                          @"scope":NSNumber.dou(4)};
    [self getUrl:@"/resident/sku/category/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表(广告位组别名查询)
 community 社区
 live 生活
 procurement 采购
 */
+(void)requestADListWithGroupalias:(NSString *)groupAlias
                           scopeId:(double)scopeId
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
     NSDictionary *dic = @{@"locationAliases":RequestStrKey(groupAlias),
                             @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                             @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                             @"count":NSNumber.dou(5000),
                             @"scope":NSNumber.dou(1)};
       [self getUrl:@"/resident/ad/list/location" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestWhistleListWithStatus:(NSString *)status
                               page:(double)page
                              count:(double)count
                              scope:(NSString *)scope
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"status":RequestStrKey(status),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"scope":@7,
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)
    };
    [self getUrl:@"/admin/whistle/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 吹哨
 */
+(void)requestAddWhistleWithPushdescription:(NSString *)pushDescription
                                   pushCode:(NSString *)pushCode
                                     areaId:(double)areaId
id:(double)identity
scope:(NSString *)scope
scopeId:(double)scopeId
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"pushDescription":RequestStrKey(pushDescription),
                          @"pushCode":RequestStrKey(pushCode),
                          @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          @"id":NSNumber.dou(identity),
                          @"scope":@7,
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
    [self patchUrl:@"/admin/whistle/2/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 处理
 */
+(void)requestDisposalWhistleWithResult:(NSString *)result
                                 areaId:(double)areaId
id:(double)identity
scope:(NSString *)scope
scopeId:(double)scopeId
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"result":RequestStrKey(result),
                          @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          @"id":NSNumber.dou(identity),
                          @"scope":@7,
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
    [self patchUrl:@"/admin/whistle/9/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 评价
 */
+(void)requestCommentWhistleWithEvaluation:(NSString *)evaluation
                                     score:(double)score
id:(double)identity
scope:(NSString *)scope
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"evaluation":RequestStrKey(evaluation),
                          @"score":NSNumber.dou(score),
                          @"id":NSNumber.dou(identity),
                          @"scope":@7};
    [self putUrl:@"/resident/whistle/evaluation/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestWhistleDetailWithId:(double)identity
                            scope:(NSString *)scope
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":RequestStrKey(scope)};
    [self getUrl:@"/admin/whistle/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 版本升级
 */
+(void)requestVersionWithDelegate:(_Nullable id<RequestDelegate> )delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"8",
                          @"terminalType":@1,
                          @"versionNumber":[GlobalMethod getVersion]};
    [self getUrl:@"/resident/version/new" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 列表（自身区域权限及以上）
 */
+(void)requestDepartmentListWithScope:(NSString *)scope
                              scopeId:(double)scopeId
                                 name:(NSString *)name
                               areaId:(double)areaId
                                 page:(double)page
                                count:(double)count
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":RequestStrKey(scope),
                          @"scopeId":NSNumber.dou(scopeId),
                          @"name":RequestStrKey(name),
                          @"areaId":NSNumber.dou(areaId),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/admin/whistle/pushcode/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"2",
                          @"scope":@7};
    [self deleteUrl:@"/auth/user/logout/token" delegate:delegate parameters:dic success:^(NSDictionary * response, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
        
    } failure: ^(NSString * errorStr, id mark){
        [GlobalMethod clearUserInfo];
        [GlobalMethod createRootNav];
    }];
}

/**
 列表
 */
+(void)requestServiceListWithScope:(double)scope
                          statuses:(NSString *)statuses
                              page:(double)page
                             count:(double)count
                              type:(double)type
                            areaId:(double)areaId
                           scopeId:(double)scopeId
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(scope),
                          @"statuses":RequestStrKey(statuses),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count),
                          @"type":NSNumber.dou(type),
                          @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
    [self getUrl:@"/admin/estateservice/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 解决[^/admin/estateservice/9/[0-9]+$]
 */
+(void)requestServiceDisposalWithResult:(NSString *)result
                                 areaId:(double)areaId
                               identity:(double)identity
                                  scope:(double)scope
                                scopeId:(double)scopeId
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"result":RequestStrKey(result),
                          @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          @"id":NSNumber.dou(identity),
                          @"scope":NSNumber.dou(scope),
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
    [self patchUrl:@"/admin/estateservice/9/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 详情
 */
+(void)requestServiceDetailWithId:(double)id
scope:(double)scope
areaId:(double)areaId
scopeId:(double)scopeId
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(id),
                          @"scope":NSNumber.dou(scope),
                          @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
    [self getUrl:@"/admin/estateservice/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
 - 绑定设备
 */
+(void)requestBindDeviceIdWithDeviceID:(NSString *)device_id
                              delegate:(_Nullable id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure{
    NSString * deviceID = [CloudPushSDK getDeviceId];
    if (!isStr(deviceID)) {
        return;
    }
    NSDictionary *dic = @{@"app":@"2",
                          @"scene":@"2",
                          @"type":@1,
                          @"scope":@7,
                          @"number":deviceID};
    [self patchUrl:@"/auth/user/terminal/number" delegate:delegate parameters:dic success:success failure:failure];
    
}

/**
 token登录/时效延长
 */
+(void)requestExtendTokenSuccess:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure{
    if (![GlobalMethod isLoginSuccess]) {
        failure(@"",nil);
        return;
    }
    NSDictionary *dic = @{@"app":@"2",
                          @"scope":@1,
                          @"scene":@"2",
                          @"token":[GlobalData sharedInstance].GB_Key
    };
    [self postUrl:@"/auth/user/login/token" delegate:nil parameters:dic success:success failure:failure];
}

/**
 列表
 */
+(void)requestHelpListWithScopeId:(double)scopeId
                           areaId:(double)areaId
                           isOpen:(double)isOpen
                             page:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"scope":NSNumber.dou(7),
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                          //                           @"areaId":NSNumber.dou(areaId),
                          //                           @"isOpen":NSNumber.dou(isOpen),
                          @"page":NSNumber.dou(page),
                          @"count":NSNumber.dou(count)};
    [self getUrl:@"/admin/lovehelp/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
 详情
 */
+(void)requestHelpDetailWithId:(double)identity
                       scopeId:(double)scopeId
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                          @"scope":@7,
                          @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
    [self getUrl:@"/admin/lovehelp/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
列表
*/
+(void)requestActivityApplicationsWithScopeId:(double)scopeId
                eventId:(double)eventId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"scope":@7,
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                           @"eventId":NSNumber.dou(eventId)};
        [self getUrl:@"/admin/event/participant/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
详情
*/
+(void)requestActivityDetailWithId:(double)identity
                scopeId:(double)scopeId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                           @"scope":@7,
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self getUrl:@"/admin/event/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
活动列表[^/admin/event/list/total$]
*/
+(void)requestActivitiesListWithScopeId:(double)scopeId
                areaId:(double)areaId
                isOpen:(double)isOpen
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"scope":@7,
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                           @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
//                           @"isOpen":NSNumber.dou(isOpen),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count)};
        [self getUrl:@"/admin/event/list/total" delegate:delegate parameters:dic success:success failure:failure];
}
/**
开启/关闭
*/
+(void)requestActivitySwitchWithId:(double)identity
                scopeId:(double)scopeId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                           @"scope":@7,
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self patchUrl:@"/admin/event/isopen/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
列表
*/
+(void)requestAssociationListWithScopeId:(double)scopeId
                areaId:(double)areaId
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"scope":NSNumber.dou(7),
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                           @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count)};
        [self getUrl:@"/admin/team/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
新增
*/
+(void)requestAddAssociationWithAreaid:(double)areaId
                name:(NSString *)name
                leaderName:(NSString *)leaderName
                description:(NSString *)description
                logoUrl:(NSString *)logoUrl
                phone:(NSString *)phone
                scopeId:(double)scopeId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                           @"name":RequestStrKey(name),
                           @"leaderName":RequestStrKey(leaderName),
                           @"description":RequestStrKey(description),
                           @"logoUrl":RequestStrKey(logoUrl),
                           @"phone":RequestStrKey(phone),
                           @"scope":@(7),
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self postUrl:@"/admin/team" delegate:delegate parameters:dic success:success failure:failure];
}
/**
编辑
*/
+(void)requestEditAssociationWithName:(NSString *)name
                leaderName:(NSString *)leaderName
                logoUrl:(NSString *)logoUrl
                description:(NSString *)description
                phone:(NSString *)phone
                id:(double)identity
                scopeId:(double)scopeId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"name":RequestStrKey(name),
                           @"leaderName":RequestStrKey(leaderName),
                           @"logoUrl":RequestStrKey(logoUrl),
                           @"description":RequestStrKey(description),
                           @"phone":RequestStrKey(phone),
                           @"id":NSNumber.dou(identity),
                           @"scope":@(7),
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self patchUrl:@"/admin/team/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
删除
*/
+(void)requestDeleteAssociationWithId:(double)identity
                scopeId:(double)scopeId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                           @"scope":@7,
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self deleteUrl:@"/admin/team/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
详情
*/
+(void)requestAssociationDetailWithId:(double)identity
                scopeId:(double)scopeId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
    NSDictionary *dic = @{@"id":NSNumber.dou(identity),
                           @"scope":@7,
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self getUrl:@"/admin/team/{id}" delegate:delegate parameters:dic success:success failure:failure];
}

/**
详情[^/admin/questionnaire(/[0-9]+){0,1}$]
*/
+(void)requestQuestionnaireDetailWithId:(double)id
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"id":NSNumber.dou(id),
                              @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                              @"scope":@7
        };
        [self getUrl:@"/admin/questionnaire/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
列表
*/
+(void)requestQuestionnaireListWithNumber:(NSString *)number
                startTime:(double)startTime
                endTime:(double)endTime
                areaId:(double)areaId
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{
//            @"number":RequestStrKey(number),
                           @"startTime":NSNumber.dou(startTime),
                           @"endTime":NSNumber.dou(endTime),
                           @"areaId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),
                              @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID),
                              @"scope":@7
        };
        [self getUrl:@"/admin/questionnaire/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
审核（待定）
*/
+(void)requestAuditAuthenticationWithIsapproval:(double)isApproval
                description:(NSString *)description
                identity:(double)identity
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"isApproval":NSNumber.dou(isApproval),
                           @"description":RequestStrKey(description),
                           @"id":NSNumber.dou(identity),
                              @"scope":@7,
@"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)
        };
        [self patchUrl:@"/admin/user/review/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
详情（待定）
*/
+(void)requestAuthenticationDetailWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"id":NSNumber.dou(identity),                              @"scope":@7,
        @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self getUrl:@"/admin/user/review/{id}" delegate:delegate parameters:dic success:success failure:failure];
}
/**
提交记录（待定）
*/
+(void)requestAutheticationListWithUserid:(double)userId
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"userId":NSNumber.dou(userId),
                           @"page":NSNumber.dou(page),
                           @"count":NSNumber.dou(count),                              @"scope":@7,
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self getUrl:@"/admin/user/review/list/total" delegate:delegate parameters:dic success:success failure:failure];
}

/**
社区发哨吹哨[^/admin/whistle/1/3$]
*/
+(void)requestSendWhistleWithFindtime:(double)findTime
                             estateId:(double)estateId
                description:(NSString *)description
                urls:(NSString *)urls
                realName:(NSString *)realName
                cellPhone:(NSString *)cellPhone
                buildingName:(NSString *)buildingName
                unitName:(NSString *)unitName
                roomName:(NSString *)roomName
                pushDescription:(NSString *)pushDescription
                pushCodes:(NSString *)pushCodes
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                failure:(void (^)(NSString * errorStr, id mark))failure{
        NSDictionary *dic = @{@"findTime":NSNumber.lon(findTime),
                           @"description":RequestStrKey(description),
                           @"urls":RequestStrKey(urls),
//                           @"lat":RequestStrKey(lat),
//                           @"lng":RequestStrKey(lng),
                           @"realName":RequestStrKey(realName),
                           @"cellPhone":RequestStrKey(cellPhone),
                           @"buildingName":RequestStrKey(buildingName),
                           @"unitName":RequestStrKey(unitName),
                           @"roomName":RequestStrKey(roomName),
                           @"estateId":NSNumber.dou(estateId),
                           @"pushDescription":RequestStrKey(pushDescription),
                           @"pushCodes":RequestStrKey(pushCodes),
                           @"scope":@(7),
                           @"scopeId":NSNumber.dou([GlobalData sharedInstance].GB_UserModel.areaID)};
        [self postUrl:@"/admin/whistle/1/3" delegate:delegate parameters:dic success:success failure:failure];
}
@end
