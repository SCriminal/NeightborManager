//
//  ModelMerchantDetail.h
//
//  Created by 林栋 隋 on 2020/3/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelMerchantDetail : NSObject

@property (nonatomic, assign) double regCountyId;
@property (nonatomic, assign) double reviewStatus;
@property (nonatomic, strong) NSString *submitorName;
@property (nonatomic, strong) NSString *reviewerName;
@property (nonatomic, strong) NSString *bizCityName;
@property (nonatomic, assign) double bizVillageId;
@property (nonatomic, strong) NSString *regCountyName;
@property (nonatomic, strong) NSString *regProvinceName;
@property (nonatomic, strong) NSString *bizAreaName;
@property (nonatomic, assign) double bizLv;
@property (nonatomic, assign) double bizTownId;
@property (nonatomic, strong) NSString *bizNumber;
@property (nonatomic, assign) double regCityId;
@property (nonatomic, strong) NSString *bizTownName;
@property (nonatomic, strong) NSString *bizCountyName;
@property (nonatomic, assign) double bizCountryId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) double regProvinceId;
@property (nonatomic, strong) NSString *bizAddr;
@property (nonatomic, strong) NSString *idPositiveUrl;
@property (nonatomic, assign) double bizCountyId;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double bizProvinceId;
@property (nonatomic, assign) double reviewerId;
@property (nonatomic, strong) NSString *regCityName;
@property (nonatomic, strong) NSString *regAddr;
@property (nonatomic, assign) double bizCityId;
@property (nonatomic, strong) NSString *idNegativeUrl;
@property (nonatomic, assign) double bizAreaId;
@property (nonatomic, strong) NSString *bizProvinceName;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, assign) double reviewTime;
@property (nonatomic, strong) NSString *bizUrl;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, assign) double submitorId;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *bizCountryName;
@property (nonatomic, strong) NSString *bizVillageName;
@property (nonatomic, strong) NSString *idNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
