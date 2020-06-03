//
//  ModelActivity.h
//
//  Created by 林栋 隋 on 2020/4/8
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelActivity : NSObject

@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, assign) double eventType;
@property (nonatomic, assign) double applyStartTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double estateId;
@property (nonatomic, assign) double maxAmount;
@property (nonatomic, assign) double nowAmount;
@property (nonatomic, assign) double creatorId;
@property (nonatomic, assign) double areaLv;
@property (nonatomic, assign) double villageId;
@property (nonatomic, assign) double countyId;
@property (nonatomic, strong) NSString *eventNumber;
@property (nonatomic, assign) double countryId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double cityId;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double townId;
@property (nonatomic, assign) double eventEndTime;
@property (nonatomic, assign) double displayMode;
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, assign) double eventStartTime;
@property (nonatomic, assign) double applyEndTime;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, assign) double teamId;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) double isParticipant;

@property (nonatomic, strong) NSString *timeShow;
@property (nonatomic, strong) NSString *typeShow;
@property (nonatomic, strong) UIColor *colorShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
