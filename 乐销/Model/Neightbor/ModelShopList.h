//
//  ModelShopList.h
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelShopList : NSObject

@property (nonatomic, assign) double monthAmount;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, assign) double isId;
@property (nonatomic, strong) NSString *bizCityName;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double bizVillageId;
@property (nonatomic, strong) NSString *bizAreaName;
@property (nonatomic, assign) double creatorId;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) double storeScore;
@property (nonatomic, assign) double bizLv;
@property (nonatomic, assign) double bizTownId;
@property (nonatomic, strong) NSString *bizNumber;
@property (nonatomic, strong) NSString *bizTownName;
@property (nonatomic, strong) NSString *bizCountyName;
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, assign) double bizCountryId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) double endTime;
@property (nonatomic, strong) NSString *bizAddr;
@property (nonatomic, assign) double distance;
@property (nonatomic, assign) double bizCountyId;
@property (nonatomic, assign) double storeStatus;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, assign) double bizProvinceId;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double bizAreaId;
@property (nonatomic, assign) double bizCityId;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *bizProvinceName;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, assign) double isBiz;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double isRecommendation;
@property (nonatomic, strong) NSString *bizCountryName;
@property (nonatomic, strong) NSString *bizVillageName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
