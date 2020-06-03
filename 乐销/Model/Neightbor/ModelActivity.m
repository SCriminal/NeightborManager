//
//  ModelActivity.m
//
//  Created by 林栋 隋 on 2020/4/8
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelActivity.h"


NSString *const kModelActivityTeamName = @"teamName";
NSString *const kModelActivityEventType = @"eventType";
NSString *const kModelActivityApplyStartTime = @"applyStartTime";
NSString *const kModelActivityTitle = @"title";
NSString *const kModelActivityEstateId = @"estateId";
NSString *const kModelActivityMaxAmount = @"maxAmount";
NSString *const kModelActivityNowAmount = @"nowAmount";
NSString *const kModelActivityCreatorId = @"creatorId";
NSString *const kModelActivityAreaLv = @"areaLv";
NSString *const kModelActivityVillageId = @"villageId";
NSString *const kModelActivityCountyId = @"countyId";
NSString *const kModelActivityEventNumber = @"eventNumber";
NSString *const kModelActivityCountryId = @"countryId";
NSString *const kModelActivityId = @"id";
NSString *const kModelActivityCityId = @"cityId";
NSString *const kModelActivityProvinceId = @"provinceId";
NSString *const kModelActivityTownId = @"townId";
NSString *const kModelActivityEventEndTime = @"eventEndTime";
NSString *const kModelActivityDisplayMode = @"displayMode";
NSString *const kModelActivityCreatorName = @"creatorName";
NSString *const kModelActivityEventStartTime = @"eventStartTime";
NSString *const kModelActivityApplyEndTime = @"applyEndTime";
NSString *const kModelActivityCreateTime = @"createTime";
NSString *const kModelActivityEstateName = @"estateName";
NSString *const kModelActivityTeamId = @"teamId";
NSString *const kModelActivityContent = @"content";
NSString *const kModelActivityIsParticipant = @"isParticipant";


@interface ModelActivity ()
@end

@implementation ModelActivity

@synthesize teamName = _teamName;
@synthesize eventType = _eventType;
@synthesize applyStartTime = _applyStartTime;
@synthesize title = _title;
@synthesize estateId = _estateId;
@synthesize maxAmount = _maxAmount;
@synthesize nowAmount = _nowAmount;
@synthesize creatorId = _creatorId;
@synthesize areaLv = _areaLv;
@synthesize villageId = _villageId;
@synthesize countyId = _countyId;
@synthesize eventNumber = _eventNumber;
@synthesize countryId = _countryId;
@synthesize iDProperty = _iDProperty;
@synthesize cityId = _cityId;
@synthesize provinceId = _provinceId;
@synthesize townId = _townId;
@synthesize eventEndTime = _eventEndTime;
@synthesize displayMode = _displayMode;
@synthesize creatorName = _creatorName;
@synthesize eventStartTime = _eventStartTime;
@synthesize applyEndTime = _applyEndTime;
@synthesize createTime = _createTime;
@synthesize estateName = _estateName;
@synthesize teamId = _teamId;
@synthesize content = _content;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.teamName = [dict stringValueForKey:kModelActivityTeamName];
            self.eventType = [dict doubleValueForKey:kModelActivityEventType];
            self.applyStartTime = [dict doubleValueForKey:kModelActivityApplyStartTime];
            self.title = [dict stringValueForKey:kModelActivityTitle];
            self.estateId = [dict doubleValueForKey:kModelActivityEstateId];
            self.maxAmount = [dict doubleValueForKey:kModelActivityMaxAmount];
            self.nowAmount = [dict doubleValueForKey:kModelActivityNowAmount];
            self.creatorId = [dict doubleValueForKey:kModelActivityCreatorId];
            self.areaLv = [dict doubleValueForKey:kModelActivityAreaLv];
            self.villageId = [dict doubleValueForKey:kModelActivityVillageId];
            self.countyId = [dict doubleValueForKey:kModelActivityCountyId];
            self.eventNumber = [dict stringValueForKey:kModelActivityEventNumber];
            self.countryId = [dict doubleValueForKey:kModelActivityCountryId];
            self.iDProperty = [dict doubleValueForKey:kModelActivityId];
            self.cityId = [dict doubleValueForKey:kModelActivityCityId];
            self.provinceId = [dict doubleValueForKey:kModelActivityProvinceId];
            self.townId = [dict doubleValueForKey:kModelActivityTownId];
            self.eventEndTime = [dict doubleValueForKey:kModelActivityEventEndTime];
            self.displayMode = [dict doubleValueForKey:kModelActivityDisplayMode];
            self.creatorName = [dict stringValueForKey:kModelActivityCreatorName];
            self.eventStartTime = [dict doubleValueForKey:kModelActivityEventStartTime];
            self.applyEndTime = [dict doubleValueForKey:kModelActivityApplyEndTime];
            self.createTime = [dict doubleValueForKey:kModelActivityCreateTime];
            self.estateName = [dict stringValueForKey:kModelActivityEstateName];
            self.teamId = [dict doubleValueForKey:kModelActivityTeamId];
            self.content = [dict stringValueForKey:kModelActivityContent];
        self.isParticipant = [dict doubleValueForKey:kModelActivityIsParticipant];

        //logical
        self.timeShow = @"";
        if (self.eventStartTime) {
            if (self.eventStartTime == self.eventEndTime ) {
                self.timeShow = [NSString stringWithFormat:@"活动时间:%@",[GlobalMethod exchangeTimeWithStamp:self.eventStartTime andFormatter:TIME_MIN_SHOW]];
            }else if(self.eventEndTime){
                 self.timeShow = [NSString stringWithFormat:@"开始时间:%@\n结束时间:%@",[GlobalMethod exchangeTimeWithStamp:self.eventStartTime andFormatter:TIME_MIN_SHOW],[GlobalMethod exchangeTimeWithStamp:self.eventEndTime andFormatter:TIME_MIN_SHOW]];
            }
        }
        self.typeShow = self.eventType == 1?@"社区活动":@"社团活动";
        self.colorShow = self.eventType == 1?COLOR_BLUE:[UIColor colorWithHexString:@"#FF6A00"];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.teamName forKey:kModelActivityTeamName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eventType] forKey:kModelActivityEventType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyStartTime] forKey:kModelActivityApplyStartTime];
    [mutableDict setValue:self.title forKey:kModelActivityTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelActivityEstateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.maxAmount] forKey:kModelActivityMaxAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.nowAmount] forKey:kModelActivityNowAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creatorId] forKey:kModelActivityCreatorId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaLv] forKey:kModelActivityAreaLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.villageId] forKey:kModelActivityVillageId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countyId] forKey:kModelActivityCountyId];
    [mutableDict setValue:self.eventNumber forKey:kModelActivityEventNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.countryId] forKey:kModelActivityCountryId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelActivityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cityId] forKey:kModelActivityCityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.provinceId] forKey:kModelActivityProvinceId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.townId] forKey:kModelActivityTownId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eventEndTime] forKey:kModelActivityEventEndTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayMode] forKey:kModelActivityDisplayMode];
    [mutableDict setValue:self.creatorName forKey:kModelActivityCreatorName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eventStartTime] forKey:kModelActivityEventStartTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.applyEndTime] forKey:kModelActivityApplyEndTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelActivityCreateTime];
    [mutableDict setValue:self.estateName forKey:kModelActivityEstateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.teamId] forKey:kModelActivityTeamId];
    [mutableDict setValue:self.content forKey:kModelActivityContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isParticipant] forKey:kModelActivityIsParticipant];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
