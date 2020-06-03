//
//  ModelAssociation.m
//
//  Created by 林栋 隋 on 2020/4/9
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelAssociation.h"


NSString *const kModelAssociationId = @"id";
NSString *const kModelAssociationDescription = @"description";
NSString *const kModelAssociationVillageId = @"villageId";
NSString *const kModelAssociationPhone = @"phone";
NSString *const kModelAssociationCityId = @"cityId";
NSString *const kModelAssociationLogoUrl = @"logoUrl";
NSString *const kModelAssociationCountyId = @"countyId";
NSString *const kModelAssociationTownId = @"townId";
NSString *const kModelAssociationCountryId = @"countryId";
NSString *const kModelAssociationCreateTime = @"createTime";
NSString *const kModelAssociationNumber = @"number";
NSString *const kModelAssociationEstateName = @"estateName";
NSString *const kModelAssociationLeaderName = @"leaderName";
NSString *const kModelAssociationProvinceId = @"provinceId";
NSString *const kModelAssociationEstateId = @"estateId";
NSString *const kModelAssociationAreaLv = @"areaLv";
NSString *const kModelAssociationName = @"name";


@interface ModelAssociation ()
@end

@implementation ModelAssociation

@synthesize iDProperty = _iDProperty;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize villageId = _villageId;
@synthesize phone = _phone;
@synthesize cityId = _cityId;
@synthesize logoUrl = _logoUrl;
@synthesize countyId = _countyId;
@synthesize townId = _townId;
@synthesize countryId = _countryId;
@synthesize createTime = _createTime;
@synthesize number = _number;
@synthesize estateName = _estateName;
@synthesize leaderName = _leaderName;
@synthesize provinceId = _provinceId;
@synthesize estateId = _estateId;
@synthesize areaLv = _areaLv;
@synthesize name = _name;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDProperty = [dict doubleValueForKey:kModelAssociationId];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelAssociationDescription];
            self.villageId = [dict doubleValueForKey:kModelAssociationVillageId];
            self.phone = [dict stringValueForKey:kModelAssociationPhone];
            self.cityId = [dict doubleValueForKey:kModelAssociationCityId];
            self.logoUrl = [dict stringValueForKey:kModelAssociationLogoUrl];
            self.countyId = [dict doubleValueForKey:kModelAssociationCountyId];
            self.townId = [dict doubleValueForKey:kModelAssociationTownId];
            self.countryId = [dict doubleValueForKey:kModelAssociationCountryId];
            self.createTime = [dict doubleValueForKey:kModelAssociationCreateTime];
            self.number = [dict stringValueForKey:kModelAssociationNumber];
            self.estateName = [dict stringValueForKey:kModelAssociationEstateName];
            self.leaderName = [dict stringValueForKey:kModelAssociationLeaderName];
            self.provinceId = [dict doubleValueForKey:kModelAssociationProvinceId];
            self.estateId = [dict doubleValueForKey:kModelAssociationEstateId];
            self.areaLv = [dict doubleValueForKey:kModelAssociationAreaLv];
            self.name = [dict stringValueForKey:kModelAssociationName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelAssociationId];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelAssociationDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelAssociationVillageId];
    [mutableDict setValue:self.phone forKey:kModelAssociationPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelAssociationCityId];
    [mutableDict setValue:self.logoUrl forKey:kModelAssociationLogoUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelAssociationCountyId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelAssociationTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelAssociationCountryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelAssociationCreateTime];
    [mutableDict setValue:self.number forKey:kModelAssociationNumber];
    [mutableDict setValue:self.estateName forKey:kModelAssociationEstateName];
    [mutableDict setValue:self.leaderName forKey:kModelAssociationLeaderName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelAssociationProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelAssociationEstateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaLv] forKey:kModelAssociationAreaLv];
    [mutableDict setValue:self.name forKey:kModelAssociationName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
