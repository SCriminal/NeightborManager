//
//  ModelCommunityServiceList.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/4/7.
//  Copyright © 2020 ping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ModelCommunityServiceList : NSObject

@property (nonatomic, assign) double status;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double whistleTime;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSArray *urls;
@property (nonatomic, assign) double score;
@property (nonatomic, strong) NSString *evaluation;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSArray *results;
@property (nonatomic, assign) double handleTime;
@property (nonatomic, assign) double pushTime;
@property (nonatomic, assign) double evaluateTime;
@property (nonatomic, assign) double isPlatform;
@property (nonatomic, assign) double whistlerId;
@property (nonatomic, assign) double handlerAreaId;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString *handlerAreaName;
@property (nonatomic, strong) NSString *unitName;
@property (nonatomic, assign) double estateId;
@property (nonatomic, strong) NSString *buildingName;
@property (nonatomic, strong) NSString *villageName;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, assign) double handlerAreaLv;
@property (nonatomic, assign) double lng;
@property (nonatomic, strong) NSString *pushDescription;
@property (nonatomic, assign) double villageId;
@property (nonatomic, assign) double countyId;
@property (nonatomic, assign) double countryId;
@property (nonatomic, strong) NSString *countyName;
@property (nonatomic, strong) NSString *provinceName;
@property (nonatomic, assign) double cityId;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSString *townName;
@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, assign) double townId;
@property (nonatomic, assign) double lat;
@property (nonatomic, assign) double handlerId;
@property (nonatomic, strong) NSString *whistlerName;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, strong) NSString *handlerName;
@property (nonatomic, assign) double findTime;
@property (nonatomic, strong) NSString *number;

//logical
@property (nonatomic, strong) NSString *statusShow;
@property (nonatomic, strong) UIColor *statusColorShow;
@property (nonatomic, strong) NSMutableArray *aryImages;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END
