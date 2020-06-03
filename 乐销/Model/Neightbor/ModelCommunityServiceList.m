//
//  ModelCommunityServiceList.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/4/7.
//  Copyright © 2020 ping. All rights reserved.
//

#import "ModelCommunityServiceList.h"


NSString *const kModelServiceListStatus = @"status";
NSString *const kModelServiceListId = @"id";
NSString *const kModelServiceListWhistleTime = @"whistleTime";
NSString *const kModelServiceListDescription = @"description";
NSString *const kModelServiceListCategoryName = @"categoryName";
NSString *const kModelServiceListUrls = @"urls";
NSString *const kModelServiceListScore = @"score";
NSString *const kModelServiceListEvaluation = @"evaluation";
NSString *const kModelServiceListSolutionResult = @"result";
NSString *const kModelServiceListResults = @"results";
NSString *const kModelServiceListHandleTime = @"handleTime";
NSString *const kModelServiceListPushTime = @"pushTime";
NSString *const kModelServiceListEvaluateTime = @"evaluateTime";
NSString *const kModelServiceListIsPlatform = @"isPlatform";
NSString *const kModelServiceListWhistlerId = @"whistlerId";
NSString *const kModelServiceListHandlerAreaId = @"handlerAreaId";
NSString *const kModelServiceListCountryName = @"countryName";
NSString *const kModelServiceListRoomName = @"roomName";
NSString *const kModelServiceListHandlerAreaName = @"handlerAreaName";
NSString *const kModelServiceListUnitName = @"unitName";
NSString *const kModelServiceListEstateId = @"estateId";
NSString *const kModelServiceListBuildingName = @"buildingName";
NSString *const kModelServiceListVillageName = @"villageName";
NSString *const kModelServiceListRealName = @"realName";
NSString *const kModelServiceListHandlerAreaLv = @"handlerAreaLv";
NSString *const kModelServiceListLng = @"lng";
NSString *const kModelServiceListPushDescription = @"pushDescription";
NSString *const kModelServiceListVillageId = @"villageId";
NSString *const kModelServiceListCountyId = @"countyId";
NSString *const kModelServiceListCountryId = @"countryId";
NSString *const kModelServiceListCountyName = @"countyName";
NSString *const kModelServiceListProvinceName = @"provinceName";
NSString *const kModelServiceListCityId = @"cityId";
NSString *const kModelServiceListProvinceId = @"provinceId";
NSString *const kModelServiceListSerialNumber = @"serialNumber";
NSString *const kModelServiceListTownName = @"townName";
NSString *const kModelServiceListCellPhone = @"cellphone";
NSString *const kModelServiceListTownId = @"townId";
NSString *const kModelServiceListLat = @"lat";
NSString *const kModelServiceListHandlerId = @"handlerId";
NSString *const kModelServiceListWhistlerName = @"whistlerName";
NSString *const kModelServiceListCreateTime = @"createTime";
NSString *const kModelServiceListEstateName = @"estateName";
NSString *const kModelServiceListCityName = @"cityName";
NSString *const kModelServiceListCategoryId = @"categoryId";
NSString *const kModelServiceListHandlerName = @"handlerName";
NSString *const kModelCommunityServiceListFindTime = @"findTime";
NSString *const kModelCommunityServiceListNumber = @"number";

@interface ModelCommunityServiceList ()
@end

@implementation ModelCommunityServiceList

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
            self.status = [dict doubleValueForKey:kModelServiceListStatus];
            self.iDProperty = [dict doubleValueForKey:kModelServiceListId];
            self.whistleTime = [dict doubleValueForKey:kModelServiceListWhistleTime];
            self.iDPropertyDescription = [dict stringValueForKey:kModelServiceListDescription];
            self.categoryName = [dict stringValueForKey:kModelServiceListCategoryName];
        self.urls =  [dict arrayValueForKey:kModelServiceListUrls];
        self.score = [dict doubleValueForKey:kModelServiceListScore];
        self.evaluation = [dict stringValueForKey:kModelServiceListEvaluation];
        self.result = [dict stringValueForKey:kModelServiceListSolutionResult];
        self.results = [GlobalMethod exchangeDic:[dict arrayValueForKey:kModelServiceListResults] toAryWithModelName:@"ModelWhistleProgress"] ;
        self.handleTime = [dict doubleValueForKey:kModelServiceListHandleTime];
        self.pushTime = [dict doubleValueForKey:kModelServiceListPushTime];
        self.evaluateTime = [dict doubleValueForKey:kModelServiceListEvaluateTime];
        self.isPlatform = [dict doubleValueForKey:kModelServiceListIsPlatform];
        self.whistlerId = [dict doubleValueForKey:kModelServiceListWhistlerId];
        self.handlerAreaId = [dict doubleValueForKey:kModelServiceListHandlerAreaId];
        self.countryName = [dict stringValueForKey:kModelServiceListCountryName];
        self.roomName = [dict stringValueForKey:kModelServiceListRoomName];
        self.handlerAreaName = [dict stringValueForKey:kModelServiceListHandlerAreaName];
        self.unitName = [dict stringValueForKey:kModelServiceListUnitName];
        self.estateId = [dict doubleValueForKey:kModelServiceListEstateId];
        self.buildingName = [dict stringValueForKey:kModelServiceListBuildingName];
        self.villageName = [dict stringValueForKey:kModelServiceListVillageName];
        self.realName = [dict stringValueForKey:kModelServiceListRealName];
        self.handlerAreaLv = [dict doubleValueForKey:kModelServiceListHandlerAreaLv];
        self.lng = [dict doubleValueForKey:kModelServiceListLng];
        self.pushDescription = [dict stringValueForKey:kModelServiceListPushDescription];
        self.villageId = [dict doubleValueForKey:kModelServiceListVillageId];
        self.countyId = [dict doubleValueForKey:kModelServiceListCountyId];
        self.countryId = [dict doubleValueForKey:kModelServiceListCountryId];
        self.countyName = [dict stringValueForKey:kModelServiceListCountyName];
        self.provinceName = [dict stringValueForKey:kModelServiceListProvinceName];
        self.cityId = [dict doubleValueForKey:kModelServiceListCityId];
        self.provinceId = [dict doubleValueForKey:kModelServiceListProvinceId];
        self.serialNumber = [dict stringValueForKey:kModelServiceListSerialNumber];
        self.townName = [dict stringValueForKey:kModelServiceListTownName];
        self.cellPhone = [dict stringValueForKey:kModelServiceListCellPhone];
        self.townId = [dict doubleValueForKey:kModelServiceListTownId];
        self.lat = [dict doubleValueForKey:kModelServiceListLat];
        self.handlerId = [dict doubleValueForKey:kModelServiceListHandlerId];
        self.whistlerName = [dict stringValueForKey:kModelServiceListWhistlerName];
        self.createTime = [dict doubleValueForKey:kModelServiceListCreateTime];
        self.estateName = [dict stringValueForKey:kModelServiceListEstateName];
        self.cityName = [dict stringValueForKey:kModelServiceListCityName];
        self.categoryId = [dict doubleValueForKey:kModelServiceListCategoryId];
        self.handlerName = [dict stringValueForKey:kModelServiceListHandlerName];
        self.findTime = [dict doubleValueForKey:kModelCommunityServiceListFindTime];
        self.number = [dict stringValueForKey:kModelCommunityServiceListNumber];

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
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelServiceListStatus];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelServiceListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.whistleTime] forKey:kModelServiceListWhistleTime];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelServiceListDescription];
    [mutableDict setValue:self.categoryName forKey:kModelServiceListCategoryName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.urls] forKey:kModelServiceListUrls];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelServiceListScore];
    [mutableDict setValue:self.evaluation forKey:kModelServiceListEvaluation];
    [mutableDict setValue:self.result forKey:kModelServiceListSolutionResult];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.results] forKey:kModelServiceListResults];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handleTime] forKey:kModelServiceListHandleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pushTime] forKey:kModelServiceListPushTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.evaluateTime] forKey:kModelServiceListEvaluateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isPlatform] forKey:kModelServiceListIsPlatform];
    [mutableDict setValue:[NSNumber numberWithDouble:self.whistlerId] forKey:kModelServiceListWhistlerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handlerAreaId] forKey:kModelServiceListHandlerAreaId];
    [mutableDict setValue:self.countryName forKey:kModelServiceListCountryName];
    [mutableDict setValue:self.roomName forKey:kModelServiceListRoomName];
    [mutableDict setValue:self.handlerAreaName forKey:kModelServiceListHandlerAreaName];
    [mutableDict setValue:self.unitName forKey:kModelServiceListUnitName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelServiceListEstateId];
    [mutableDict setValue:self.buildingName forKey:kModelServiceListBuildingName];
    [mutableDict setValue:self.villageName forKey:kModelServiceListVillageName];
    [mutableDict setValue:self.realName forKey:kModelServiceListRealName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handlerAreaLv] forKey:kModelServiceListHandlerAreaLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelServiceListLng];
    [mutableDict setValue:self.pushDescription forKey:kModelServiceListPushDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelServiceListVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelServiceListCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelServiceListCountryId];
    [mutableDict setValue:self.countyName forKey:kModelServiceListCountyName];
    [mutableDict setValue:self.provinceName forKey:kModelServiceListProvinceName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelServiceListCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelServiceListProvinceId];
    [mutableDict setValue:self.serialNumber forKey:kModelServiceListSerialNumber];
    [mutableDict setValue:self.townName forKey:kModelServiceListTownName];
    [mutableDict setValue:self.cellPhone forKey:kModelServiceListCellPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelServiceListTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelServiceListLat];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handlerId] forKey:kModelServiceListHandlerId];
    [mutableDict setValue:self.whistlerName forKey:kModelServiceListWhistlerName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelServiceListCreateTime];
    [mutableDict setValue:self.estateName forKey:kModelServiceListEstateName];
    [mutableDict setValue:self.cityName forKey:kModelServiceListCityName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelServiceListCategoryId];
    [mutableDict setValue:self.handlerName forKey:kModelServiceListHandlerName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.findTime] forKey:kModelCommunityServiceListFindTime];
    [mutableDict setValue:self.number forKey:kModelCommunityServiceListNumber];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
