//
//  ModelDepartment.h
//
//  Created by 林栋 隋 on 2020/3/24
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelDepartment : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double areaLv;
@property (nonatomic, assign) double nowTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, assign) double scopeId;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, assign) BOOL isSelected;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
