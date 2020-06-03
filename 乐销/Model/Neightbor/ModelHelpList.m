//
//  ModelHelpList.m
//
//  Created by 林栋 隋 on 2020/4/7
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelHelpList.h"


NSString *const kModelHelpListId = @"id";
NSString *const kModelHelpListDescription = @"description";
NSString *const kModelHelpListVillageId = @"villageId";
NSString *const kModelHelpListPhone = @"phone";
NSString *const kModelHelpListPersonName = @"personName";
NSString *const kModelHelpListAreaLv = @"areaLv";
NSString *const kModelHelpListAddr = @"addr";
NSString *const kModelHelpListCountryId = @"countryId";
NSString *const kModelHelpListCountyId = @"countyId";
NSString *const kModelHelpListHelp = @"help";
NSString *const kModelHelpListTitle = @"title";
NSString *const kModelHelpListCreateTime = @"createTime";
NSString *const kModelHelpListTownId = @"townId";
NSString *const kModelHelpListEstateName = @"estateName";
NSString *const kModelHelpListProvinceId = @"provinceId";
NSString *const kModelHelpListIsOpen = @"isOpen";
NSString *const kModelHelpListCityId = @"cityId";
NSString *const kModelHelpListEstateId = @"estateId";
NSString *const kModelHelpListHelpNumber = @"helpNumber";


@interface ModelHelpList ()
@end

@implementation ModelHelpList

@synthesize iDProperty = _iDProperty;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize villageId = _villageId;
@synthesize phone = _phone;
@synthesize personName = _personName;
@synthesize areaLv = _areaLv;
@synthesize addr = _addr;
@synthesize countryId = _countryId;
@synthesize countyId = _countyId;
@synthesize help = _help;
@synthesize title = _title;
@synthesize createTime = _createTime;
@synthesize townId = _townId;
@synthesize estateName = _estateName;
@synthesize provinceId = _provinceId;
@synthesize isOpen = _isOpen;
@synthesize cityId = _cityId;
@synthesize estateId = _estateId;
@synthesize helpNumber = _helpNumber;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDProperty = [dict doubleValueForKey:kModelHelpListId];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelHelpListDescription];
            self.villageId = [dict doubleValueForKey:kModelHelpListVillageId];
            self.phone = [dict stringValueForKey:kModelHelpListPhone];
            self.personName = [dict stringValueForKey:kModelHelpListPersonName];
            self.areaLv = [dict doubleValueForKey:kModelHelpListAreaLv];
            self.addr = [dict stringValueForKey:kModelHelpListAddr];
            self.countryId = [dict doubleValueForKey:kModelHelpListCountryId];
            self.countyId = [dict doubleValueForKey:kModelHelpListCountyId];
            self.help = [dict stringValueForKey:kModelHelpListHelp];
            self.title = [dict stringValueForKey:kModelHelpListTitle];
            self.createTime = [dict doubleValueForKey:kModelHelpListCreateTime];
            self.townId = [dict doubleValueForKey:kModelHelpListTownId];
            self.estateName = [dict stringValueForKey:kModelHelpListEstateName];
            self.provinceId = [dict doubleValueForKey:kModelHelpListProvinceId];
            self.isOpen = [dict doubleValueForKey:kModelHelpListIsOpen];
            self.cityId = [dict doubleValueForKey:kModelHelpListCityId];
            self.estateId = [dict doubleValueForKey:kModelHelpListEstateId];
            self.helpNumber = [dict stringValueForKey:kModelHelpListHelpNumber];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelHelpListId];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelHelpListDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelHelpListVillageId];
    [mutableDict setValue:self.phone forKey:kModelHelpListPhone];
    [mutableDict setValue:self.personName forKey:kModelHelpListPersonName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaLv] forKey:kModelHelpListAreaLv];
    [mutableDict setValue:self.addr forKey:kModelHelpListAddr];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelHelpListCountryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelHelpListCountyId];
    [mutableDict setValue:self.help forKey:kModelHelpListHelp];
    [mutableDict setValue:self.title forKey:kModelHelpListTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelHelpListCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelHelpListTownId];
    [mutableDict setValue:self.estateName forKey:kModelHelpListEstateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelHelpListProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isOpen] forKey:kModelHelpListIsOpen];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelHelpListCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelHelpListEstateId];
    [mutableDict setValue:self.helpNumber forKey:kModelHelpListHelpNumber];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
