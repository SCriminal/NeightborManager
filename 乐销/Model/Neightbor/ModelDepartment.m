//
//  ModelDepartment.m
//
//  Created by 林栋 隋 on 2020/3/24
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelDepartment.h"


NSString *const kModelDepartmentName = @"name";
NSString *const kModelDepartmentAreaLv = @"areaLv";
NSString *const kModelDepartmentNowTime = @"nowTime";
NSString *const kModelDepartmentId = @"id";
NSString *const kModelDepartmentCode = @"code";
NSString *const kModelDepartmentScopeId = @"scopeId";
NSString *const kModelDepartmentCreateTime = @"createTime";
NSString *const kModelDepartmentAreaName = @"areaName";


@interface ModelDepartment ()
@end

@implementation ModelDepartment

@synthesize name = _name;
@synthesize areaLv = _areaLv;
@synthesize nowTime = _nowTime;
@synthesize iDProperty = _iDProperty;
@synthesize code = _code;
@synthesize scopeId = _scopeId;
@synthesize createTime = _createTime;
@synthesize areaName = _areaName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [dict stringValueForKey:kModelDepartmentName];
            self.areaLv = [dict doubleValueForKey:kModelDepartmentAreaLv];
            self.nowTime = [dict doubleValueForKey:kModelDepartmentNowTime];
            self.iDProperty = [dict doubleValueForKey:kModelDepartmentId];
            self.code = [dict stringValueForKey:kModelDepartmentCode];
            self.scopeId = [dict doubleValueForKey:kModelDepartmentScopeId];
            self.createTime = [dict doubleValueForKey:kModelDepartmentCreateTime];
            self.areaName = [dict stringValueForKey:kModelDepartmentAreaName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kModelDepartmentName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.areaLv] forKey:kModelDepartmentAreaLv];
    [mutableDict setValue:[NSNumber numberWithDouble:self.nowTime] forKey:kModelDepartmentNowTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelDepartmentId];
    [mutableDict setValue:self.code forKey:kModelDepartmentCode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.scopeId] forKey:kModelDepartmentScopeId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelDepartmentCreateTime];
    [mutableDict setValue:self.areaName forKey:kModelDepartmentAreaName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
