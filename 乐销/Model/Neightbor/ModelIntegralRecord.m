//
//  ModelIntegralRecord.m
//
//  Created by 林栋 隋 on 2020/3/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelIntegralRecord.h"


NSString *const kModelIntegralRecordCreateTime = @"createTime";
NSString *const kModelIntegralRecordScore = @"score";
NSString *const kModelIntegralRecordChannel = @"channel";
NSString *const kModelIntegralRecordDescription = @"description";
NSString *const kModelIntegralRecordUserId = @"userId";
NSString *const kModelIntegralRecordDirection = @"direction";


@interface ModelIntegralRecord ()
@end

@implementation ModelIntegralRecord

@synthesize createTime = _createTime;
@synthesize score = _score;
@synthesize channel = _channel;
@synthesize internalBaseClassDescription = _internalBaseClassDescription;
@synthesize userId = _userId;
@synthesize direction = _direction;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.createTime = [dict doubleValueForKey:kModelIntegralRecordCreateTime];
            self.score = [dict doubleValueForKey:kModelIntegralRecordScore];
            self.channel = [dict doubleValueForKey:kModelIntegralRecordChannel];
            self.internalBaseClassDescription = [dict stringValueForKey:kModelIntegralRecordDescription];
            self.userId = [dict doubleValueForKey:kModelIntegralRecordUserId];
            self.direction = [dict doubleValueForKey:kModelIntegralRecordDirection];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelIntegralRecordCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.score] forKey:kModelIntegralRecordScore];
    [mutableDict setValue:[NSNumber numberWithDouble:self.channel] forKey:kModelIntegralRecordChannel];
    [mutableDict setValue:self.internalBaseClassDescription forKey:kModelIntegralRecordDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelIntegralRecordUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.direction] forKey:kModelIntegralRecordDirection];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
