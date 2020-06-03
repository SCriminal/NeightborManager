//
//  ModelWhistleProgress.m
//
//  Created by 林栋 隋 on 2020/3/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelWhistleProgress.h"


NSString *const kModelWhistleProgressOpsTime = @"opsTime";
NSString *const kModelWhistleProgressDeptId = @"deptId";
NSString *const kModelWhistleProgressDeptName = @"deptName";
NSString *const kModelWhistleProgressDescription = @"description";
NSString *const kModelWhistleProgressOpsId = @"opsId";
NSString *const kModelWhistleProgressOpsName = @"opsName";


@interface ModelWhistleProgress ()
@end

@implementation ModelWhistleProgress

@synthesize opsTime = _opsTime;
@synthesize deptId = _deptId;
@synthesize deptName = _deptName;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize opsId = _opsId;
@synthesize opsName = _opsName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.opsTime = [dict stringValueForKey:kModelWhistleProgressOpsTime];
            self.deptId = [dict stringValueForKey:kModelWhistleProgressDeptId];
            self.deptName = [dict stringValueForKey:kModelWhistleProgressDeptName];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelWhistleProgressDescription];
            self.opsId = [dict stringValueForKey:kModelWhistleProgressOpsId];
            self.opsName = [dict stringValueForKey:kModelWhistleProgressOpsName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.opsTime forKey:kModelWhistleProgressOpsTime];
    [mutableDict setValue:self.deptId forKey:kModelWhistleProgressDeptId];
    [mutableDict setValue:self.deptName forKey:kModelWhistleProgressDeptName];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelWhistleProgressDescription];
    [mutableDict setValue:self.opsId forKey:kModelWhistleProgressOpsId];
    [mutableDict setValue:self.opsName forKey:kModelWhistleProgressOpsName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
