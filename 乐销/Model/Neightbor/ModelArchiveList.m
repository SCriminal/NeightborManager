//
//  ModelArchiveList.m
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelArchiveList.h"


NSString *const kModelArchiveListCountryName = @"countryName";
NSString *const kModelArchiveListRoomName = @"roomName";
NSString *const kModelArchiveListUnitName = @"unitName";
NSString *const kModelArchiveListArchitectId = @"architectId";
NSString *const kModelArchiveListEstateId = @"estateId";
NSString *const kModelArchiveListBuildingName = @"buildingName";
NSString *const kModelArchiveListVillageName = @"villageName";
NSString *const kModelArchiveListRealName = @"realName";
NSString *const kModelArchiveListArchitectName = @"architectName";
NSString *const kModelArchiveListLng = @"lng";
NSString *const kModelArchiveListTag = @"tag";
NSString *const kModelArchiveListVillageId = @"villageId";
NSString *const kModelArchiveListCountyId = @"countyId";
NSString *const kModelArchiveListCountryId = @"countryId";
NSString *const kModelArchiveListJob = @"job";
NSString *const kModelArchiveListId = @"id";
NSString *const kModelArchiveListCountyName = @"countyName";
NSString *const kModelArchiveListAddrId = @"addrId";
NSString *const kModelArchiveListCityId = @"cityId";
NSString *const kModelArchiveListIdNumber = @"idNumber";
NSString *const kModelArchiveListProvinceId = @"provinceId";
NSString *const kModelArchiveListProvinceName = @"provinceName";
NSString *const kModelArchiveListCellPhone = @"cellPhone";
NSString *const kModelArchiveListTownId = @"townId";
NSString *const kModelArchiveListLat = @"lat";
NSString *const kModelArchiveListTownName = @"townName";
NSString *const kModelArchiveListEnterprise = @"enterprise";
NSString *const kModelArchiveListCityName = @"cityName";
NSString *const kModelArchiveListEstateName = @"estateName";
NSString *const kModelArchiveListIsParty = @"isParty";


@interface ModelArchiveList ()
@end

@implementation ModelArchiveList

@synthesize countryName = _countryName;
@synthesize roomName = _roomName;
@synthesize unitName = _unitName;
@synthesize architectId = _architectId;
@synthesize estateId = _estateId;
@synthesize buildingName = _buildingName;
@synthesize villageName = _villageName;
@synthesize realName = _realName;
@synthesize architectName = _architectName;
@synthesize lng = _lng;
@synthesize tag = _tag;
@synthesize villageId = _villageId;
@synthesize countyId = _countyId;
@synthesize countryId = _countryId;
@synthesize job = _job;
@synthesize iDProperty = _iDProperty;
@synthesize countyName = _countyName;
@synthesize addrId = _addrId;
@synthesize cityId = _cityId;
@synthesize idNumber = _idNumber;
@synthesize provinceId = _provinceId;
@synthesize provinceName = _provinceName;
@synthesize cellPhone = _cellPhone;
@synthesize townId = _townId;
@synthesize lat = _lat;
@synthesize townName = _townName;
@synthesize enterprise = _enterprise;
@synthesize cityName = _cityName;
@synthesize estateName = _estateName;
@synthesize isParty = _isParty;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.countryName = [dict stringValueForKey:kModelArchiveListCountryName];
            self.roomName = [dict stringValueForKey:kModelArchiveListRoomName];
            self.unitName = [dict stringValueForKey:kModelArchiveListUnitName];
            self.architectId = [dict doubleValueForKey:kModelArchiveListArchitectId];
            self.estateId = [dict doubleValueForKey:kModelArchiveListEstateId];
            self.buildingName = [dict stringValueForKey:kModelArchiveListBuildingName];
            self.villageName = [dict stringValueForKey:kModelArchiveListVillageName];
            self.realName = [dict stringValueForKey:kModelArchiveListRealName];
            self.architectName = [dict stringValueForKey:kModelArchiveListArchitectName];
            self.lng = [dict doubleValueForKey:kModelArchiveListLng];
            self.tag = [dict doubleValueForKey:kModelArchiveListTag];
            self.villageId = [dict doubleValueForKey:kModelArchiveListVillageId];
            self.countyId = [dict doubleValueForKey:kModelArchiveListCountyId];
            self.countryId = [dict doubleValueForKey:kModelArchiveListCountryId];
            self.job = [dict stringValueForKey:kModelArchiveListJob];
            self.iDProperty = [dict doubleValueForKey:kModelArchiveListId];
            self.countyName = [dict stringValueForKey:kModelArchiveListCountyName];
            self.addrId = [dict doubleValueForKey:kModelArchiveListAddrId];
            self.cityId = [dict doubleValueForKey:kModelArchiveListCityId];
            self.idNumber = [dict stringValueForKey:kModelArchiveListIdNumber];
            self.provinceId = [dict doubleValueForKey:kModelArchiveListProvinceId];
            self.provinceName = [dict stringValueForKey:kModelArchiveListProvinceName];
            self.cellPhone = [dict stringValueForKey:kModelArchiveListCellPhone];
        if (!isStr(self.cellPhone)) {
            self.cellPhone = [dict stringValueForKey:@"cellphone"];
        }
            self.townId = [dict doubleValueForKey:kModelArchiveListTownId];
            self.lat = [dict doubleValueForKey:kModelArchiveListLat];
            self.townName = [dict stringValueForKey:kModelArchiveListTownName];
            self.enterprise = [dict stringValueForKey:kModelArchiveListEnterprise];
            self.cityName = [dict stringValueForKey:kModelArchiveListCityName];
            self.estateName = [dict stringValueForKey:kModelArchiveListEstateName];
            self.isParty = [dict doubleValueForKey:kModelArchiveListIsParty];
        
        switch ((int)self.tag) {
            case 1:
                self.typeShow = @"业主";
                break;
            case 2:
                self.typeShow = @"亲友";
                break;
            case 3:
                self.typeShow = @"租户";
                break;
            default:
                break;
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.countryName forKey:kModelArchiveListCountryName];
    [mutableDict setValue:self.roomName forKey:kModelArchiveListRoomName];
    [mutableDict setValue:self.unitName forKey:kModelArchiveListUnitName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.architectId] forKey:kModelArchiveListArchitectId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelArchiveListEstateId];
    [mutableDict setValue:self.buildingName forKey:kModelArchiveListBuildingName];
    [mutableDict setValue:self.villageName forKey:kModelArchiveListVillageName];
    [mutableDict setValue:self.realName forKey:kModelArchiveListRealName];
    [mutableDict setValue:self.architectName forKey:kModelArchiveListArchitectName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lng] forKey:kModelArchiveListLng];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tag] forKey:kModelArchiveListTag];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelArchiveListVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelArchiveListCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelArchiveListCountryId];
    [mutableDict setValue:self.job forKey:kModelArchiveListJob];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelArchiveListId];
    [mutableDict setValue:self.countyName forKey:kModelArchiveListCountyName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.addrId] forKey:kModelArchiveListAddrId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelArchiveListCityId];
    [mutableDict setValue:self.idNumber forKey:kModelArchiveListIdNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelArchiveListProvinceId];
    [mutableDict setValue:self.provinceName forKey:kModelArchiveListProvinceName];
    [mutableDict setValue:self.cellPhone forKey:kModelArchiveListCellPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelArchiveListTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kModelArchiveListLat];
    [mutableDict setValue:self.townName forKey:kModelArchiveListTownName];
    [mutableDict setValue:self.enterprise forKey:kModelArchiveListEnterprise];
    [mutableDict setValue:self.cityName forKey:kModelArchiveListCityName];
    [mutableDict setValue:self.estateName forKey:kModelArchiveListEstateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isParty] forKey:kModelArchiveListIsParty];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
