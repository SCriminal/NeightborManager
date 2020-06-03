//
//  ModelQuestionnairDetail.m
//
//  Created by 林栋 隋 on 2020/4/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelQuestionnairDetail.h"
#import "ModelQuestionnairDetailContent.h"


NSString *const kModelQuestionnairDetailParticipateTime = @"participateTime";
NSString *const kModelQuestionnairDetailEstateId = @"estateId";
NSString *const kModelQuestionnairDetailTitle = @"title";
NSString *const kModelQuestionnairDetailContactPhone = @"contactPhone";
NSString *const kModelQuestionnairDetailCreatorId = @"creatorId";
NSString *const kModelQuestionnairDetailAreaLv = @"areaLv";
NSString *const kModelQuestionnairDetailVillageId = @"villageId";
NSString *const kModelQuestionnairDetailInputEndTime = @"inputEndTime";
NSString *const kModelQuestionnairDetailCountyId = @"countyId";
NSString *const kModelQuestionnairDetailParticipation = @"participation";
NSString *const kModelQuestionnairDetailCountryId = @"countryId";
NSString *const kModelQuestionnairDetailId = @"id";
NSString *const kModelQuestionnairDetailCityId = @"cityId";
NSString *const kModelQuestionnairDetailNumber = @"number";
NSString *const kModelQuestionnairDetailProvinceId = @"provinceId";
NSString *const kModelQuestionnairDetailIsParticipant = @"isParticipant";
NSString *const kModelQuestionnairDetailTownId = @"townId";
NSString *const kModelQuestionnairDetailCreatorName = @"creatorName";
NSString *const kModelQuestionnairDetailCreateTime = @"createTime";
NSString *const kModelQuestionnairDetailEstateName = @"estateName";
NSString *const kModelQuestionnairDetailInputStartTime = @"inputStartTime";
NSString *const kModelQuestionnairDetailContent = @"content";
NSString *const kModelQuestionnairDetailDescription = @"description";


@interface ModelQuestionnairDetail ()
@end

@implementation ModelQuestionnairDetail

@synthesize participateTime = _participateTime;
@synthesize estateId = _estateId;
@synthesize title = _title;
@synthesize contactPhone = _contactPhone;
@synthesize creatorId = _creatorId;
@synthesize areaLv = _areaLv;
@synthesize villageId = _villageId;
@synthesize inputEndTime = _inputEndTime;
@synthesize countyId = _countyId;
@synthesize participation = _participation;
@synthesize countryId = _countryId;
@synthesize iDProperty = _iDProperty;
@synthesize cityId = _cityId;
@synthesize number = _number;
@synthesize provinceId = _provinceId;
@synthesize isParticipant = _isParticipant;
@synthesize townId = _townId;
@synthesize creatorName = _creatorName;
@synthesize createTime = _createTime;
@synthesize estateName = _estateName;
@synthesize inputStartTime = _inputStartTime;
@synthesize content = _content;
@synthesize iDPropertyDescription = _iDPropertyDescription;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.participateTime = [dict doubleValueForKey:kModelQuestionnairDetailParticipateTime];
            self.estateId = [dict doubleValueForKey:kModelQuestionnairDetailEstateId];
            self.title = [dict stringValueForKey:kModelQuestionnairDetailTitle];
            self.contactPhone = [dict stringValueForKey:kModelQuestionnairDetailContactPhone];
            self.creatorId = [dict doubleValueForKey:kModelQuestionnairDetailCreatorId];
            self.areaLv = [dict doubleValueForKey:kModelQuestionnairDetailAreaLv];
            self.villageId = [dict doubleValueForKey:kModelQuestionnairDetailVillageId];
            self.inputEndTime = [dict doubleValueForKey:kModelQuestionnairDetailInputEndTime];
            self.countyId = [dict doubleValueForKey:kModelQuestionnairDetailCountyId];
            self.participation =  [GlobalMethod exchangeDic:[dict objectForKey:kModelQuestionnairDetailParticipation] toAryWithModelName:@"ModelQuestionnairDetailContent"];
            self.countryId = [dict doubleValueForKey:kModelQuestionnairDetailCountryId];
            self.iDProperty = [dict doubleValueForKey:kModelQuestionnairDetailId];
            self.cityId = [dict doubleValueForKey:kModelQuestionnairDetailCityId];
            self.number = [dict stringValueForKey:kModelQuestionnairDetailNumber];
            self.provinceId = [dict doubleValueForKey:kModelQuestionnairDetailProvinceId];
            self.isParticipant = [dict doubleValueForKey:kModelQuestionnairDetailIsParticipant];
            self.townId = [dict doubleValueForKey:kModelQuestionnairDetailTownId];
            self.creatorName = [dict stringValueForKey:kModelQuestionnairDetailCreatorName];
            self.createTime = [dict doubleValueForKey:kModelQuestionnairDetailCreateTime];
            self.estateName = [dict stringValueForKey:kModelQuestionnairDetailEstateName];
            self.inputStartTime = [dict doubleValueForKey:kModelQuestionnairDetailInputStartTime];
        self.content = [GlobalMethod exchangeDic:[dict objectForKey:kModelQuestionnairDetailContent] toAryWithModelName:NSStringFromClass(ModelQuestionnairDetailContent.class)];
            self.iDPropertyDescription = [dict stringValueForKey:kModelQuestionnairDetailDescription];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.participateTime] forKey:kModelQuestionnairDetailParticipateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelQuestionnairDetailEstateId];
    [mutableDict setValue:self.title forKey:kModelQuestionnairDetailTitle];
    [mutableDict setValue:self.contactPhone forKey:kModelQuestionnairDetailContactPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creatorId] forKey:kModelQuestionnairDetailCreatorId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaLv] forKey:kModelQuestionnairDetailAreaLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelQuestionnairDetailVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inputEndTime] forKey:kModelQuestionnairDetailInputEndTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelQuestionnairDetailCountyId];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.participation] forKey:kModelQuestionnairDetailParticipation];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelQuestionnairDetailCountryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelQuestionnairDetailId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelQuestionnairDetailCityId];
    [mutableDict setValue:self.number forKey:kModelQuestionnairDetailNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelQuestionnairDetailProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isParticipant] forKey:kModelQuestionnairDetailIsParticipant];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelQuestionnairDetailTownId];
    [mutableDict setValue:self.creatorName forKey:kModelQuestionnairDetailCreatorName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelQuestionnairDetailCreateTime];
    [mutableDict setValue:self.estateName forKey:kModelQuestionnairDetailEstateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inputStartTime] forKey:kModelQuestionnairDetailInputStartTime];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.content] forKey:kModelQuestionnairDetailContent];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelQuestionnairDetailDescription];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
