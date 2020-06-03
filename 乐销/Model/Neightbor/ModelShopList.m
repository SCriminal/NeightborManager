//
//  ModelShopList.m
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelShopList.h"


NSString *const kModelShopListMonthAmount = @"monthAmount";
NSString *const kModelShopListCategoryId = @"categoryId";
NSString *const kModelShopListIsId = @"isId";
NSString *const kModelShopListBizCityName = @"bizCityName";
NSString *const kModelShopListId = @"id";
NSString *const kModelShopListBizVillageId = @"bizVillageId";
NSString *const kModelShopListBizAreaName = @"bizAreaName";
NSString *const kModelShopListCreatorId = @"creatorId";
NSString *const kModelShopListStartTime = @"startTime";
NSString *const kModelShopListStoreScore = @"storeScore";
NSString *const kModelShopListBizLv = @"bizLv";
NSString *const kModelShopListBizTownId = @"bizTownId";
NSString *const kModelShopListBizNumber = @"bizNumber";
NSString *const kModelShopListBizTownName = @"bizTownName";
NSString *const kModelShopListBizCountyName = @"bizCountyName";
NSString *const kModelShopListCreatorName = @"creatorName";
NSString *const kModelShopListBizCountryId = @"bizCountryId";
NSString *const kModelShopListStoreName = @"storeName";
NSString *const kModelShopListEndTime = @"endTime";
NSString *const kModelShopListBizAddr = @"bizAddr";
NSString *const kModelShopListDistance = @"distance";
NSString *const kModelShopListBizCountyId = @"bizCountyId";
NSString *const kModelShopListStoreStatus = @"storeStatus";
NSString *const kModelShopListCategoryName = @"categoryName";
NSString *const kModelShopListBizProvinceId = @"bizProvinceId";
NSString *const kModelShopListLng = @"lng";
NSString *const kModelShopListBizAreaId = @"bizAreaId";
NSString *const kModelShopListBizCityId = @"bizCityId";
NSString *const kModelShopListCoverUrl = @"coverUrl";
NSString *const kModelShopListBizProvinceName = @"bizProvinceName";
NSString *const kModelShopListContactPhone = @"contactPhone";
NSString *const kModelShopListIsBiz = @"isBiz";
NSString *const kModelShopListLat = @"lat";
NSString *const kModelShopListIsRecommendation = @"isRecommendation";
NSString *const kModelShopListBizCountryName = @"bizCountryName";
NSString *const kModelShopListBizVillageName = @"bizVillageName";


@interface ModelShopList ()
@end

@implementation ModelShopList

@synthesize monthAmount = _monthAmount;
@synthesize categoryId = _categoryId;
@synthesize isId = _isId;
@synthesize bizCityName = _bizCityName;
@synthesize iDProperty = _iDProperty;
@synthesize bizVillageId = _bizVillageId;
@synthesize bizAreaName = _bizAreaName;
@synthesize creatorId = _creatorId;
@synthesize startTime = _startTime;
@synthesize storeScore = _storeScore;
@synthesize bizLv = _bizLv;
@synthesize bizTownId = _bizTownId;
@synthesize bizNumber = _bizNumber;
@synthesize bizTownName = _bizTownName;
@synthesize bizCountyName = _bizCountyName;
@synthesize creatorName = _creatorName;
@synthesize bizCountryId = _bizCountryId;
@synthesize storeName = _storeName;
@synthesize endTime = _endTime;
@synthesize bizAddr = _bizAddr;
@synthesize distance = _distance;
@synthesize bizCountyId = _bizCountyId;
@synthesize storeStatus = _storeStatus;
@synthesize categoryName = _categoryName;
@synthesize bizProvinceId = _bizProvinceId;
@synthesize lng = _lng;
@synthesize bizAreaId = _bizAreaId;
@synthesize bizCityId = _bizCityId;
@synthesize coverUrl = _coverUrl;
@synthesize bizProvinceName = _bizProvinceName;
@synthesize contactPhone = _contactPhone;
@synthesize isBiz = _isBiz;
@synthesize lat = _lat;
@synthesize isRecommendation = _isRecommendation;
@synthesize bizCountryName = _bizCountryName;
@synthesize bizVillageName = _bizVillageName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.monthAmount = [dict doubleValueForKey:kModelShopListMonthAmount];
            self.categoryId = [dict doubleValueForKey:kModelShopListCategoryId];
            self.isId = [dict doubleValueForKey:kModelShopListIsId];
            self.bizCityName = [dict stringValueForKey:kModelShopListBizCityName];
            self.iDProperty = [dict doubleValueForKey:kModelShopListId];
            self.bizVillageId = [dict doubleValueForKey:kModelShopListBizVillageId];
            self.bizAreaName = [dict stringValueForKey:kModelShopListBizAreaName];
            self.creatorId = [dict doubleValueForKey:kModelShopListCreatorId];
            self.startTime = [dict doubleValueForKey:kModelShopListStartTime];
            self.storeScore = [dict doubleValueForKey:kModelShopListStoreScore];
            self.bizLv = [dict doubleValueForKey:kModelShopListBizLv];
            self.bizTownId = [dict doubleValueForKey:kModelShopListBizTownId];
            self.bizNumber = [dict stringValueForKey:kModelShopListBizNumber];
            self.bizTownName = [dict stringValueForKey:kModelShopListBizTownName];
            self.bizCountyName = [dict stringValueForKey:kModelShopListBizCountyName];
            self.creatorName = [dict stringValueForKey:kModelShopListCreatorName];
            self.bizCountryId = [dict doubleValueForKey:kModelShopListBizCountryId];
            self.storeName = [dict stringValueForKey:kModelShopListStoreName];
            self.endTime = [dict doubleValueForKey:kModelShopListEndTime];
            self.bizAddr = [dict stringValueForKey:kModelShopListBizAddr];
            self.distance = [dict doubleValueForKey:kModelShopListDistance];
            self.bizCountyId = [dict doubleValueForKey:kModelShopListBizCountyId];
            self.storeStatus = [dict doubleValueForKey:kModelShopListStoreStatus];
            self.categoryName = [dict stringValueForKey:kModelShopListCategoryName];
            self.bizProvinceId = [dict doubleValueForKey:kModelShopListBizProvinceId];
            self.lng = [dict doubleValueForKey:kModelShopListLng];
            self.bizAreaId = [dict doubleValueForKey:kModelShopListBizAreaId];
            self.bizCityId = [dict doubleValueForKey:kModelShopListBizCityId];
            self.coverUrl = [dict stringValueForKey:kModelShopListCoverUrl];
            self.bizProvinceName = [dict stringValueForKey:kModelShopListBizProvinceName];
            self.contactPhone = [dict stringValueForKey:kModelShopListContactPhone];
            self.isBiz = [dict doubleValueForKey:kModelShopListIsBiz];
            self.lat = [dict doubleValueForKey:kModelShopListLat];
            self.isRecommendation = [dict doubleValueForKey:kModelShopListIsRecommendation];
            self.bizCountryName = [dict stringValueForKey:kModelShopListBizCountryName];
            self.bizVillageName = [dict stringValueForKey:kModelShopListBizVillageName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.monthAmount] forKey:kModelShopListMonthAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelShopListCategoryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isId] forKey:kModelShopListIsId];
    [mutableDict setValue:self.bizCityName forKey:kModelShopListBizCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelShopListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizVillageId] forKey:kModelShopListBizVillageId];
    [mutableDict setValue:self.bizAreaName forKey:kModelShopListBizAreaName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creatorId] forKey:kModelShopListCreatorId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.startTime] forKey:kModelShopListStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.storeScore] forKey:kModelShopListStoreScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizLv] forKey:kModelShopListBizLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizTownId] forKey:kModelShopListBizTownId];
    [mutableDict setValue:self.bizNumber forKey:kModelShopListBizNumber];
    [mutableDict setValue:self.bizTownName forKey:kModelShopListBizTownName];
    [mutableDict setValue:self.bizCountyName forKey:kModelShopListBizCountyName];
    [mutableDict setValue:self.creatorName forKey:kModelShopListCreatorName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizCountryId] forKey:kModelShopListBizCountryId];
    [mutableDict setValue:self.storeName forKey:kModelShopListStoreName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.endTime] forKey:kModelShopListEndTime];
    [mutableDict setValue:self.bizAddr forKey:kModelShopListBizAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.distance] forKey:kModelShopListDistance];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizCountyId] forKey:kModelShopListBizCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.storeStatus] forKey:kModelShopListStoreStatus];
    [mutableDict setValue:self.categoryName forKey:kModelShopListCategoryName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizProvinceId] forKey:kModelShopListBizProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelShopListLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizAreaId] forKey:kModelShopListBizAreaId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.bizCityId] forKey:kModelShopListBizCityId];
    [mutableDict setValue:self.coverUrl forKey:kModelShopListCoverUrl];
    [mutableDict setValue:self.bizProvinceName forKey:kModelShopListBizProvinceName];
    [mutableDict setValue:self.contactPhone forKey:kModelShopListContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isBiz] forKey:kModelShopListIsBiz];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelShopListLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isRecommendation] forKey:kModelShopListIsRecommendation];
    [mutableDict setValue:self.bizCountryName forKey:kModelShopListBizCountryName];
    [mutableDict setValue:self.bizVillageName forKey:kModelShopListBizVillageName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
