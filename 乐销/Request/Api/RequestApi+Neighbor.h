//
//  RequestApi+Neighbor.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/13.
//  Copyright © 2020 ping. All rights reserved.
//

#import "RequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestApi (Neighbor)
/**
 获取验证码
 */
+(void)requestSendCodeWithCellPhone:(NSString *)cellPhone
                            smsType:(double)smsType
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 登录(手机号自动注册)
 */
+(void)requestLoginWithCode:(NSString *)smsCode
                  cellPhone:(NSString *)cellPhone
                   delegate:(id <RequestDelegate>)delegate
                    success:(void (^)(NSDictionary * response, id mark))success
                    failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 居民登录(手机号，密码)
 */
+(void)requestLoginWithAccount:(NSString *)account
                      password:(NSString *)password
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 获取忘记密码验证码
 */
+(void)requestSendForgetCodeAccount:(NSString *)account
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 忘记密码
 */
+(void)requestResetPwdWithAccount:(NSString *)account
                         password:(NSString *)password
                          smsCode:(NSString *)smsCode
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 每日签到
 */
+(void)requestSignDayWithScore:(double)score
                   description:(NSString *)description
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 积分数
 */
+(void)requestIntegralTotalDelegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 操作记录
 */
+(void)requestIntegralRecordDelegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 查询所有省
 */
+(void)requestProvinceWithDelegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据区查询所有镇
 */
+(void)requestCityWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 根据市查询所有区
 */
+(void)requestAreaWithId:(double)identity
                delegate:(id <RequestDelegate>)delegate
                 success:(void (^)(NSDictionary * response, id mark))success
                 failure:(void (^)(NSString * errorStr, id mark))failure;


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
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 提交详情
 */
+(void)requestMerchantSiginDetailWithAreaId:(double)areaId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 联系咨询
 */
+(void)requestMerchantConnectWithContactphone:(NSString *)contactPhone
                                      contact:(NSString *)contact
                                     delegate:(id <RequestDelegate>)delegate
                                      success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 我的成员管理
 */
+(void)requestMemeberListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;



+(void)requestSelectCommunityWithLng:(double)lng
                                 lat:(double)lat
                                name:(NSString *)name
                               scope:(double)scope
                                page:(double)page
                               count:(double)count
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 列表
 */
+(void)requestAddressListWithPage:(double)page
                            count:(double)count
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 删除
 */
+(void)requestDeleteAddressWithId:(double)identity
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
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
                             failure:(void (^)(NSString * errorStr, id mark))failure;
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
failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestNewsListWithScopeid:(double)scopeId
                             page:(double)page
                            count:(double)count
                    categoryAlias:(NSString *)categoryAlias
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestWorkNoticeListWithScopeid:(double)scopeId
                                   page:(double)page
                                  count:(double)count
                             categoryId:(double)categoryId
                               delegate:(id <RequestDelegate>)delegate
                                success:(void (^)(NSDictionary * response, id mark))success
                                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestWorkNoticeDetailWithId:(double)identity
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                 failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 列表
 */
+(void)requestArchiveListWithPage:(double)page
                            count:(double)count
                         estateId:(double)estateId
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
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
                             failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 获取
 */
+(void)requestAuthorityCommunityWithScopeId:(double)scopeId
                                   delegate:(id <RequestDelegate>)delegate
                                    success:(void (^)(NSDictionary * response, id mark))success
                                    failure:(void (^)(NSString * errorStr, id mark))failure;
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
                              failure:(void (^)(NSString * errorStr, id mark))failure;



/**
 列表
 */
+(void)requestShopProductWithscopeId:(NSString *)scopeId
                             storeId:(double)storeId
                            delegate:(id <RequestDelegate>)delegate
                             success:(void (^)(NSDictionary * response, id mark))success
                             failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表(广告位组别名查询)
 */
+(void)requestADListWithGroupalias:(NSString *)groupAlias
                           scopeId:(double)scopeId
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;


/**
 列表
 */
+(void)requestWhistleListWithStatus:(NSString *)status
                               page:(double)page
                              count:(double)count
                              scope:(NSString *)scope
                           delegate:(id <RequestDelegate>)delegate
                            success:(void (^)(NSDictionary * response, id mark))success
                            failure:(void (^)(NSString * errorStr, id mark))failure;

+(void)requestManagerWhistleListWithStatus:(NSString *)status
                                      page:(double)page
                                     count:(double)count
                                  delegate:(id <RequestDelegate>)delegate
                                   success:(void (^)(NSDictionary * response, id mark))success
                                   failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 吹哨
 */
+(void)requestAddWhistleWithPushdescription:(NSString *)pushDescription
                                   pushCode:(NSString *)pushCode
                                     areaId:(double)areaId
id:(double)identity
scope:(NSString *)scope
scopeId:(double)scopeId
categoryId:(double)categoryId
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
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
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 评价
 */
+(void)requestCommentWhistleWithEvaluation:(NSString *)evaluation
                                     score:(double )score
id:(double)identity
scope:(NSString *)scope
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestWhistleDetailWithId:(double)identity
                            scope:(NSString *)scope
                         delegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestManagerWhistleDetailWithId:(double)identity
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 版本升级
 */
+(void)requestVersionWithDelegate:(_Nullable id<RequestDelegate> )delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

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
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 登出
 */
+(void)requestLogoutWithDelegate:(id <RequestDelegate>)delegate
                         success:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;
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
                           failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestServiceDetailWithId:(double)id
scope:(double)scope
areaId:(double)areaId
scopeId:(double)scopeId
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 - 绑定设备
 */
+(void)requestBindDeviceIdWithDeviceID:(NSString *)device_id
                              delegate:(_Nullable id <RequestDelegate>)delegate
                               success:(void (^)(NSDictionary * response, id mark))success
                               failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 token登录/时效延长
 */
+(void)requestExtendTokenSuccess:(void (^)(NSDictionary * response, id mark))success
                         failure:(void (^)(NSString * errorStr, id mark))failure;

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
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 详情
 */
+(void)requestHelpDetailWithId:(double)identity
                       scopeId:(double)scopeId
                      delegate:(id <RequestDelegate>)delegate
                       success:(void (^)(NSDictionary * response, id mark))success
                       failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 列表
 */
+(void)requestActivityApplicationsWithScopeId:(double)scopeId
                                      eventId:(double)eventId
                                     delegate:(id <RequestDelegate>)delegate
                                      success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestActivityDetailWithId:(double)identity
                           scopeId:(double)scopeId
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;

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
                                failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 开启/关闭
 */
+(void)requestActivitySwitchWithId:(double)identity
                           scopeId:(double)scopeId
                          delegate:(id <RequestDelegate>)delegate
                           success:(void (^)(NSDictionary * response, id mark))success
                           failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 列表
 */
+(void)requestAssociationListWithScopeId:(double)scopeId
                                  areaId:(double)areaId
                                    page:(double)page
                                   count:(double)count
                                delegate:(id <RequestDelegate>)delegate
                                 success:(void (^)(NSDictionary * response, id mark))success
                                 failure:(void (^)(NSString * errorStr, id mark))failure;

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
                               failure:(void (^)(NSString * errorStr, id mark))failure;
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
failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 删除
 */
+(void)requestDeleteAssociationWithId:(double)identity
                              scopeId:(double)scopeId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
/**
 详情
 */
+(void)requestAssociationDetailWithId:(double)identity
                              scopeId:(double)scopeId
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 详情[^/admin/questionnaire(/[0-9]+){0,1}$]
 */
+(void)requestQuestionnaireDetailWithId:(double)id
delegate:(id <RequestDelegate>)delegate
success:(void (^)(NSDictionary * response, id mark))success
failure:(void (^)(NSString * errorStr, id mark))failure;
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
                                  failure:(void (^)(NSString * errorStr, id mark))failure;

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
                           categoryId:(double)categoryId
                                  lat:(double)lat
                                  lng:(double)lng
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;
+(void)requestWhistleTypeDelegate:(id <RequestDelegate>)delegate
                          success:(void (^)(NSDictionary * response, id mark))success
                          failure:(void (^)(NSString * errorStr, id mark))failure;

/**
 修改吹哨类目[^/admin/whistle/1_0_15/1/[0-9]+$]
 */
+(void)requestModifyWhistleCategoryid:(double)categoryId
                             identity:(NSString *)identity
                             delegate:(id <RequestDelegate>)delegate
                              success:(void (^)(NSDictionary * response, id mark))success
                              failure:(void (^)(NSString * errorStr, id mark))failure;

/**
列表
*/
+(void)requestCertificationDealCategoryListWithCategoryalias:(NSString *)categoryAlias
                page:(double)page
                count:(double)count
                areaId:(double)areaId
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                                     failure:(void (^)(NSString * errorStr, id mark))failure;
/**
列表
*/
+(void)requestCertificateDealCategoryListWithCategoryID:(double)categoryID
                                               statuses:(NSString *)statuses
                page:(double)page
                count:(double)count
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                                failure:(void (^)(NSString * errorStr, id mark))failure;

/**
详情
*/
+(void)requestCertSubmitDetailWithnNumber:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                  failure:(void (^)(NSString * errorStr, id mark))failure;
/**
审核
*/
+(void)requestCertDisposalAuditWithIsapproval:(double)isApproval
                number:(NSString *)number
                delegate:(id <RequestDelegate>)delegate
                success:(void (^)(NSDictionary * response, id mark))success
                                      failure:(void (^)(NSString * errorStr, id mark))failure;

@end

NS_ASSUME_NONNULL_END
