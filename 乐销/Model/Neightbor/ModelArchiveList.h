//
//  ModelArchiveList.h
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelArchiveList : NSObject

@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *unitName;
@property (nonatomic, assign) double architectId;
@property (nonatomic, assign) double estateId;
@property (nonatomic, strong) NSString *buildingName;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *architectName;
@property (nonatomic, assign) double lng;
@property (nonatomic, assign) double tag;
@property (nonatomic, assign) double villageId;
@property (nonatomic, assign) double countyId;
@property (nonatomic, assign) double countryId;
@property (nonatomic, strong) NSString *job;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, assign) double addrId;
@property (nonatomic, assign) double cityId;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, assign) double townId;
@property (nonatomic, assign) double lat;
@property (nonatomic, strong) NSString *townName;
@property (nonatomic, strong) NSString *enterprise;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, assign) double isParty;
@property (nonatomic, strong) NSString *typeShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
