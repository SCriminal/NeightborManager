//
//  ModelAssociation.h
//
//  Created by 林栋 隋 on 2020/4/9
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAssociation : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, assign) double villageId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *logoUrl;
@property (nonatomic, assign) double countyId;
@property (nonatomic, assign) double townId;
@property (nonatomic, assign) double countryId;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, strong) NSString *leaderName;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double estateId;
@property (nonatomic, assign) double areaLv;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
