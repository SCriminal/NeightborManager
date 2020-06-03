//
//  ModelMerchantDetail.m
//
//  Created by 林栋 隋 on 2020/3/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelMerchantDetail.h"


NSString *const kModelMerchantDetailRegCountyId = @"regCountyId";
NSString *const kModelMerchantDetailReviewStatus = @"reviewStatus";
NSString *const kModelMerchantDetailSubmitorName = @"submitorName";
NSString *const kModelMerchantDetailReviewerName = @"reviewerName";
NSString *const kModelMerchantDetailBizCityName = @"bizCityName";
NSString *const kModelMerchantDetailBizVillageId = @"bizVillageId";
NSString *const kModelMerchantDetailRegCountyName = @"regCountyName";
NSString *const kModelMerchantDetailRegProvinceName = @"regProvinceName";
NSString *const kModelMerchantDetailBizAreaName = @"bizAreaName";
NSString *const kModelMerchantDetailBizLv = @"bizLv";
NSString *const kModelMerchantDetailBizTownId = @"bizTownId";
NSString *const kModelMerchantDetailBizNumber = @"bizNumber";
NSString *const kModelMerchantDetailRegCityId = @"regCityId";
NSString *const kModelMerchantDetailBizTownName = @"bizTownName";
NSString *const kModelMerchantDetailBizCountyName = @"bizCountyName";
NSString *const kModelMerchantDetailBizCountryId = @"bizCountryId";
NSString *const kModelMerchantDetailStoreName = @"storeName";
NSString *const kModelMerchantDetailRegProvinceId = @"regProvinceId";
NSString *const kModelMerchantDetailBizAddr = @"bizAddr";
NSString *const kModelMerchantDetailIdPositiveUrl = @"idPositiveUrl";
NSString *const kModelMerchantDetailBizCountyId = @"bizCountyId";
NSString *const kModelMerchantDetailRealName = @"realName";
NSString *const kModelMerchantDetailBizProvinceId = @"bizProvinceId";
NSString *const kModelMerchantDetailReviewerId = @"reviewerId";
NSString *const kModelMerchantDetailRegCityName = @"regCityName";
NSString *const kModelMerchantDetailRegAddr = @"regAddr";
NSString *const kModelMerchantDetailBizCityId = @"bizCityId";
NSString *const kModelMerchantDetailIdNegativeUrl = @"idNegativeUrl";
NSString *const kModelMerchantDetailBizAreaId = @"bizAreaId";
NSString *const kModelMerchantDetailBizProvinceName = @"bizProvinceName";
NSString *const kModelMerchantDetailContactPhone = @"contactPhone";
NSString *const kModelMerchantDetailReviewTime = @"reviewTime";
NSString *const kModelMerchantDetailBizUrl = @"bizUrl";
NSString *const kModelMerchantDetailSubmitTime = @"submitTime";
NSString *const kModelMerchantDetailSubmitorId = @"submitorId";
NSString *const kModelMerchantDetailReason = @"reason";
NSString *const kModelMerchantDetailBizCountryName = @"bizCountryName";
NSString *const kModelMerchantDetailBizVillageName = @"bizVillageName";
NSString *const kModelMerchantDetailIdNumber = @"idNumber";


@interface ModelMerchantDetail ()
@end

@implementation ModelMerchantDetail

@synthesize regCountyId = _regCountyId;
@synthesize reviewStatus = _reviewStatus;
@synthesize submitorName = _submitorName;
@synthesize reviewerName = _reviewerName;
@synthesize bizCityName = _bizCityName;
@synthesize bizVillageId = _bizVillageId;
@synthesize regCountyName = _regCountyName;
@synthesize regProvinceName = _regProvinceName;
@synthesize bizAreaName = _bizAreaName;
@synthesize bizLv = _bizLv;
@synthesize bizTownId = _bizTownId;
@synthesize bizNumber = _bizNumber;
@synthesize regCityId = _regCityId;
@synthesize bizTownName = _bizTownName;
@synthesize bizCountyName = _bizCountyName;
@synthesize bizCountryId = _bizCountryId;
@synthesize storeName = _storeName;
@synthesize regProvinceId = _regProvinceId;
@synthesize bizAddr = _bizAddr;
@synthesize idPositiveUrl = _idPositiveUrl;
@synthesize bizCountyId = _bizCountyId;
@synthesize realName = _realName;
@synthesize bizProvinceId = _bizProvinceId;
@synthesize reviewerId = _reviewerId;
@synthesize regCityName = _regCityName;
@synthesize regAddr = _regAddr;
@synthesize bizCityId = _bizCityId;
@synthesize idNegativeUrl = _idNegativeUrl;
@synthesize bizAreaId = _bizAreaId;
@synthesize bizProvinceName = _bizProvinceName;
@synthesize contactPhone = _contactPhone;
@synthesize reviewTime = _reviewTime;
@synthesize bizUrl = _bizUrl;
@synthesize submitTime = _submitTime;
@synthesize submitorId = _submitorId;
@synthesize reason = _reason;
@synthesize bizCountryName = _bizCountryName;
@synthesize bizVillageName = _bizVillageName;
@synthesize idNumber = _idNumber;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.regCountyId = [dict doubleValueForKey:kModelMerchantDetailRegCountyId];
            self.reviewStatus = [dict doubleValueForKey:kModelMerchantDetailReviewStatus];
            self.submitorName = [dict stringValueForKey:kModelMerchantDetailSubmitorName];
            self.reviewerName = [dict stringValueForKey:kModelMerchantDetailReviewerName];
            self.bizCityName = [dict stringValueForKey:kModelMerchantDetailBizCityName];
            self.bizVillageId = [dict doubleValueForKey:kModelMerchantDetailBizVillageId];
            self.regCountyName = [dict stringValueForKey:kModelMerchantDetailRegCountyName];
            self.regProvinceName = [dict stringValueForKey:kModelMerchantDetailRegProvinceName];
            self.bizAreaName = [dict stringValueForKey:kModelMerchantDetailBizAreaName];
            self.bizLv = [dict doubleValueForKey:kModelMerchantDetailBizLv];
            self.bizTownId = [dict doubleValueForKey:kModelMerchantDetailBizTownId];
            self.bizNumber = [dict stringValueForKey:kModelMerchantDetailBizNumber];
            self.regCityId = [dict doubleValueForKey:kModelMerchantDetailRegCityId];
            self.bizTownName = [dict stringValueForKey:kModelMerchantDetailBizTownName];
            self.bizCountyName = [dict stringValueForKey:kModelMerchantDetailBizCountyName];
            self.bizCountryId = [dict doubleValueForKey:kModelMerchantDetailBizCountryId];
            self.storeName = [dict stringValueForKey:kModelMerchantDetailStoreName];
            self.regProvinceId = [dict doubleValueForKey:kModelMerchantDetailRegProvinceId];
            self.bizAddr = [dict stringValueForKey:kModelMerchantDetailBizAddr];
            self.idPositiveUrl = [dict stringValueForKey:kModelMerchantDetailIdPositiveUrl];
            self.bizCountyId = [dict doubleValueForKey:kModelMerchantDetailBizCountyId];
            self.realName = [dict stringValueForKey:kModelMerchantDetailRealName];
            self.bizProvinceId = [dict doubleValueForKey:kModelMerchantDetailBizProvinceId];
            self.reviewerId = [dict doubleValueForKey:kModelMerchantDetailReviewerId];
            self.regCityName = [dict stringValueForKey:kModelMerchantDetailRegCityName];
            self.regAddr = [dict stringValueForKey:kModelMerchantDetailRegAddr];
            self.bizCityId = [dict doubleValueForKey:kModelMerchantDetailBizCityId];
            self.idNegativeUrl = [dict stringValueForKey:kModelMerchantDetailIdNegativeUrl];
            self.bizAreaId = [dict doubleValueForKey:kModelMerchantDetailBizAreaId];
            self.bizProvinceName = [dict stringValueForKey:kModelMerchantDetailBizProvinceName];
            self.contactPhone = [dict stringValueForKey:kModelMerchantDetailContactPhone];
            self.reviewTime = [dict doubleValueForKey:kModelMerchantDetailReviewTime];
            self.bizUrl = [dict stringValueForKey:kModelMerchantDetailBizUrl];
            self.submitTime = [dict doubleValueForKey:kModelMerchantDetailSubmitTime];
            self.submitorId = [dict doubleValueForKey:kModelMerchantDetailSubmitorId];
            self.reason = [dict stringValueForKey:kModelMerchantDetailReason];
            self.bizCountryName = [dict stringValueForKey:kModelMerchantDetailBizCountryName];
            self.bizVillageName = [dict stringValueForKey:kModelMerchantDetailBizVillageName];
            self.idNumber = [dict stringValueForKey:kModelMerchantDetailIdNumber];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.regCountyId] forKey:kModelMerchantDetailRegCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewStatus] forKey:kModelMerchantDetailReviewStatus];
    [mutableDict setValue:self.submitorName forKey:kModelMerchantDetailSubmitorName];
    [mutableDict setValue:self.reviewerName forKey:kModelMerchantDetailReviewerName];
    [mutableDict setValue:self.bizCityName forKey:kModelMerchantDetailBizCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizVillageId] forKey:kModelMerchantDetailBizVillageId];
    [mutableDict setValue:self.regCountyName forKey:kModelMerchantDetailRegCountyName];
    [mutableDict setValue:self.regProvinceName forKey:kModelMerchantDetailRegProvinceName];
    [mutableDict setValue:self.bizAreaName forKey:kModelMerchantDetailBizAreaName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizLv] forKey:kModelMerchantDetailBizLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizTownId] forKey:kModelMerchantDetailBizTownId];
    [mutableDict setValue:self.bizNumber forKey:kModelMerchantDetailBizNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.regCityId] forKey:kModelMerchantDetailRegCityId];
    [mutableDict setValue:self.bizTownName forKey:kModelMerchantDetailBizTownName];
    [mutableDict setValue:self.bizCountyName forKey:kModelMerchantDetailBizCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizCountryId] forKey:kModelMerchantDetailBizCountryId];
    [mutableDict setValue:self.storeName forKey:kModelMerchantDetailStoreName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.regProvinceId] forKey:kModelMerchantDetailRegProvinceId];
    [mutableDict setValue:self.bizAddr forKey:kModelMerchantDetailBizAddr];
    [mutableDict setValue:self.idPositiveUrl forKey:kModelMerchantDetailIdPositiveUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizCountyId] forKey:kModelMerchantDetailBizCountyId];
    [mutableDict setValue:self.realName forKey:kModelMerchantDetailRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizProvinceId] forKey:kModelMerchantDetailBizProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewerId] forKey:kModelMerchantDetailReviewerId];
    [mutableDict setValue:self.regCityName forKey:kModelMerchantDetailRegCityName];
    [mutableDict setValue:self.regAddr forKey:kModelMerchantDetailRegAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizCityId] forKey:kModelMerchantDetailBizCityId];
    [mutableDict setValue:self.idNegativeUrl forKey:kModelMerchantDetailIdNegativeUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizAreaId] forKey:kModelMerchantDetailBizAreaId];
    [mutableDict setValue:self.bizProvinceName forKey:kModelMerchantDetailBizProvinceName];
    [mutableDict setValue:self.contactPhone forKey:kModelMerchantDetailContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.reviewTime] forKey:kModelMerchantDetailReviewTime];
    [mutableDict setValue:self.bizUrl forKey:kModelMerchantDetailBizUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelMerchantDetailSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitorId] forKey:kModelMerchantDetailSubmitorId];
    [mutableDict setValue:self.reason forKey:kModelMerchantDetailReason];
    [mutableDict setValue:self.bizCountryName forKey:kModelMerchantDetailBizCountryName];
    [mutableDict setValue:self.bizVillageName forKey:kModelMerchantDetailBizVillageName];
    [mutableDict setValue:self.idNumber forKey:kModelMerchantDetailIdNumber];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
