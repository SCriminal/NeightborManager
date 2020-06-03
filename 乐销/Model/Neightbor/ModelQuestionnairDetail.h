//
//  ModelQuestionnairDetail.h
//
//  Created by 林栋 隋 on 2020/4/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelQuestionnairDetail : NSObject

@property (nonatomic, assign) double participateTime;
@property (nonatomic, assign) double estateId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, assign) double creatorId;
@property (nonatomic, assign) double areaLv;
@property (nonatomic, assign) double villageId;
@property (nonatomic, assign) double inputEndTime;
@property (nonatomic, assign) double countyId;
@property (nonatomic, strong) NSArray *participation;
@property (nonatomic, assign) double countryId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double isParticipant;
@property (nonatomic, assign) double townId;
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, assign) double inputStartTime;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSString *iDPropertyDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
