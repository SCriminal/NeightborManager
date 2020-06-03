//
//  ModelHelpList.h
//
//  Created by 林栋 隋 on 2020/4/7
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelHelpList : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, assign) double villageId;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *personName;
@property (nonatomic, assign) double areaLv;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, assign) double countryId;
@property (nonatomic, assign) double countyId;
@property (nonatomic, strong) NSString *help;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double townId;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, assign) double provinceId;
@property (nonatomic, assign) double isOpen;
@property (nonatomic, assign) double cityId;
@property (nonatomic, assign) double estateId;
@property (nonatomic, strong) NSString *helpNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
