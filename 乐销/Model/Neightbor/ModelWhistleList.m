//
//  ModelWhistleList.m
//
//  Created by 林栋 隋 on 2020/3/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelWhistleList.h"


NSString *const kModelWhistleListStatus = @"status";
NSString *const kModelWhistleListId = @"id";
NSString *const kModelWhistleListWhistleTime = @"whistleTime";
NSString *const kModelWhistleListDescription = @"description";
NSString *const kModelWhistleListCategoryName = @"categoryName";
NSString *const kModelWhistleListUrls = @"photoUrls";
NSString *const kModelWhistleListScore = @"score";
NSString *const kModelWhistleListEvaluation = @"evaluation";
NSString *const kModelWhistleListSolutionResult = @"result";
NSString *const kModelWhistleListResults = @"results";
NSString *const kModelWhistleListHandleTime = @"handleTime";
NSString *const kModelWhistleListPushTime = @"pushTime";
NSString *const kModelWhistleListEvaluateTime = @"evaluateTime";
NSString *const kModelWhistleListIsPlatform = @"isPlatform";
NSString *const kModelWhistleListWhistlerId = @"whistlerId";
NSString *const kModelWhistleListHandlerAreaId = @"handlerAreaId";
NSString *const kModelWhistleListCountryName = @"countryName";
NSString *const kModelWhistleListRoomName = @"roomName";
NSString *const kModelWhistleListHandlerAreaName = @"handlerAreaName";
NSString *const kModelWhistleListUnitName = @"unitName";
NSString *const kModelWhistleListEstateId = @"estateId";
NSString *const kModelWhistleListBuildingName = @"buildingName";
NSString *const kModelWhistleListVillageName = @"villageName";
NSString *const kModelWhistleListRealName = @"realName";
NSString *const kModelWhistleListHandlerAreaLv = @"handlerAreaLv";
NSString *const kModelWhistleListLng = @"lng";
NSString *const kModelWhistleListPushDescription = @"pushDescription";
NSString *const kModelWhistleListVillageId = @"villageId";
NSString *const kModelWhistleListCountyId = @"countyId";
NSString *const kModelWhistleListCountryId = @"countryId";
NSString *const kModelWhistleListCountyName = @"countyName";
NSString *const kModelWhistleListProvinceName = @"provinceName";
NSString *const kModelWhistleListCityId = @"cityId";
NSString *const kModelWhistleListProvinceId = @"provinceId";
NSString *const kModelWhistleListSerialNumber = @"serialNumber";
NSString *const kModelWhistleListTownName = @"townName";
NSString *const kModelWhistleListCellPhone = @"cellPhone";
NSString *const kModelWhistleListTownId = @"townId";
NSString *const kModelWhistleListLat = @"lat";
NSString *const kModelWhistleListHandlerId = @"handlerId";
NSString *const kModelWhistleListWhistlerName = @"whistlerName";
NSString *const kModelWhistleListCreateTime = @"createTime";
NSString *const kModelWhistleListEstateName = @"estateName";
NSString *const kModelWhistleListCityName = @"cityName";
NSString *const kModelWhistleListCategoryId = @"categoryId";
NSString *const kModelWhistleListHandlerName = @"handlerName";

@interface ModelWhistleList ()

@end

@implementation ModelWhistleList

@synthesize status = _status;
@synthesize iDProperty = _iDProperty;
@synthesize whistleTime = _whistleTime;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize categoryName = _categoryName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [dict doubleValueForKey:kModelWhistleListStatus];
            self.iDProperty = [dict doubleValueForKey:kModelWhistleListId];
            self.whistleTime = [dict doubleValueForKey:kModelWhistleListWhistleTime];
            self.iDPropertyDescription = [dict stringValueForKey:kModelWhistleListDescription];
            self.categoryName = [dict stringValueForKey:kModelWhistleListCategoryName];
        self.urls =  [dict arrayValueForKey:kModelWhistleListUrls];
        self.photo9Urls =  [dict arrayValueForKey:@"photo9Urls"];
        self.score = [dict doubleValueForKey:kModelWhistleListScore];
        self.evaluation = [dict stringValueForKey:kModelWhistleListEvaluation];
        self.result = [dict stringValueForKey:kModelWhistleListSolutionResult];
        self.results = [GlobalMethod exchangeDic:[dict arrayValueForKey:kModelWhistleListResults] toAryWithModelName:@"ModelWhistleProgress"] ;
        self.handleTime = [dict doubleValueForKey:kModelWhistleListHandleTime];
        self.pushTime = [dict doubleValueForKey:kModelWhistleListPushTime];
        self.evaluateTime = [dict doubleValueForKey:kModelWhistleListEvaluateTime];
        self.isPlatform = [dict doubleValueForKey:kModelWhistleListIsPlatform];
        self.whistlerId = [dict doubleValueForKey:kModelWhistleListWhistlerId];
        self.handlerAreaId = [dict doubleValueForKey:kModelWhistleListHandlerAreaId];
        self.countryName = [dict stringValueForKey:kModelWhistleListCountryName];
        self.roomName = [dict stringValueForKey:kModelWhistleListRoomName];
        self.handlerAreaName = [dict stringValueForKey:kModelWhistleListHandlerAreaName];
        self.unitName = [dict stringValueForKey:kModelWhistleListUnitName];
        self.estateId = [dict doubleValueForKey:kModelWhistleListEstateId];
        self.buildingName = [dict stringValueForKey:kModelWhistleListBuildingName];
        self.villageName = [dict stringValueForKey:kModelWhistleListVillageName];
        self.realName = [dict stringValueForKey:kModelWhistleListRealName];
        self.handlerAreaLv = [dict doubleValueForKey:kModelWhistleListHandlerAreaLv];
        self.lng = [dict doubleValueForKey:kModelWhistleListLng];
        self.pushDescription = [dict stringValueForKey:kModelWhistleListPushDescription];
        self.villageId = [dict doubleValueForKey:kModelWhistleListVillageId];
        self.countyId = [dict doubleValueForKey:kModelWhistleListCountyId];
        self.countryId = [dict doubleValueForKey:kModelWhistleListCountryId];
        self.countyName = [dict stringValueForKey:kModelWhistleListCountyName];
        self.provinceName = [dict stringValueForKey:kModelWhistleListProvinceName];
        self.cityId = [dict doubleValueForKey:kModelWhistleListCityId];
        self.provinceId = [dict doubleValueForKey:kModelWhistleListProvinceId];
        self.serialNumber = [dict stringValueForKey:kModelWhistleListSerialNumber];
        self.townName = [dict stringValueForKey:kModelWhistleListTownName];
        self.cellPhone = [dict stringValueForKey:kModelWhistleListCellPhone];
        self.townId = [dict doubleValueForKey:kModelWhistleListTownId];
        self.lat = [dict doubleValueForKey:kModelWhistleListLat];
        self.handlerId = [dict doubleValueForKey:kModelWhistleListHandlerId];
        self.whistlerName = [dict stringValueForKey:kModelWhistleListWhistlerName];
        self.createTime = [dict doubleValueForKey:kModelWhistleListCreateTime];
        self.estateName = [dict stringValueForKey:kModelWhistleListEstateName];
        self.cityName = [dict stringValueForKey:kModelWhistleListCityName];
        self.categoryId = [dict doubleValueForKey:kModelWhistleListCategoryId];
        self.handlerName = [dict stringValueForKey:kModelWhistleListHandlerName];

//1已发哨 3已吹哨 6已处理 9已处理 10已评价
        switch ((int)self.status) {
            case 1:
            {
                self.statusShow = @"已发哨";
                self.statusColorShow = COLOR_ORANGE;
            }
                break;
            case 3:
            {
                self.statusShow = @"已吹哨";
                self.statusColorShow = [UIColor colorWithHexString:@"#FF6A00"];
            }
                break;
          
            case 9:
            {
                self.statusShow = @"已处理";
                self.statusColorShow = [UIColor colorWithHexString:@"#22D393"];
            }
                break;
            case 10:
            {
                self.statusShow = @"已评价";
                self.statusColorShow = [UIColor colorWithHexString:@"#35B2FF"];
            }
                break;
            default:
                break;
        }
        self.aryImages = [NSMutableArray new];
        for (NSString * strURL in self.urls) {
            ModelImage * model = [ModelImage new];
            model.url = strURL;
            [self.aryImages addObject:model];
        }
        self.ary9UrlImages = [NSMutableArray new];
               for (NSString * strURL in self.photo9Urls) {
                   ModelImage * model = [ModelImage new];
                   model.url = strURL;
                   [self.ary9UrlImages addObject:model];
               }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelWhistleListStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelWhistleListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.whistleTime] forKey:kModelWhistleListWhistleTime];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelWhistleListDescription];
    [mutableDict setValue:self.categoryName forKey:kModelWhistleListCategoryName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.urls] forKey:kModelWhistleListUrls];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.photo9Urls] forKey:@"photo9Urls"];

    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelWhistleListScore];
    [mutableDict setValue:self.evaluation forKey:kModelWhistleListEvaluation];
    [mutableDict setValue:self.result forKey:kModelWhistleListSolutionResult];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.results] forKey:kModelWhistleListResults];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handleTime] forKey:kModelWhistleListHandleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pushTime] forKey:kModelWhistleListPushTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.evaluateTime] forKey:kModelWhistleListEvaluateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isPlatform] forKey:kModelWhistleListIsPlatform];
    [mutableDict setValue:[NSNumber numberWithDouble:self.whistlerId] forKey:kModelWhistleListWhistlerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handlerAreaId] forKey:kModelWhistleListHandlerAreaId];
    [mutableDict setValue:self.countryName forKey:kModelWhistleListCountryName];
    [mutableDict setValue:self.roomName forKey:kModelWhistleListRoomName];
    [mutableDict setValue:self.handlerAreaName forKey:kModelWhistleListHandlerAreaName];
    [mutableDict setValue:self.unitName forKey:kModelWhistleListUnitName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelWhistleListEstateId];
    [mutableDict setValue:self.buildingName forKey:kModelWhistleListBuildingName];
    [mutableDict setValue:self.villageName forKey:kModelWhistleListVillageName];
    [mutableDict setValue:self.realName forKey:kModelWhistleListRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handlerAreaLv] forKey:kModelWhistleListHandlerAreaLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelWhistleListLng];
    [mutableDict setValue:self.pushDescription forKey:kModelWhistleListPushDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelWhistleListVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelWhistleListCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelWhistleListCountryId];
    [mutableDict setValue:self.countyName forKey:kModelWhistleListCountyName];
    [mutableDict setValue:self.provinceName forKey:kModelWhistleListProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelWhistleListCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelWhistleListProvinceId];
    [mutableDict setValue:self.serialNumber forKey:kModelWhistleListSerialNumber];
    [mutableDict setValue:self.townName forKey:kModelWhistleListTownName];
    [mutableDict setValue:self.cellPhone forKey:kModelWhistleListCellPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelWhistleListTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelWhistleListLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handlerId] forKey:kModelWhistleListHandlerId];
    [mutableDict setValue:self.whistlerName forKey:kModelWhistleListWhistlerName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelWhistleListCreateTime];
    [mutableDict setValue:self.estateName forKey:kModelWhistleListEstateName];
    [mutableDict setValue:self.cityName forKey:kModelWhistleListCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelWhistleListCategoryId];
    [mutableDict setValue:self.handlerName forKey:kModelWhistleListHandlerName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
