//
//  ModelMsg.m
//
//  Created by 林栋 隋 on 2020/5/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelMsg.h"


NSString *const kModelMsgCategory = @"category";
NSString *const kModelMsgCreateTime = @"createTime";
NSString *const kModelMsgContent = @"content";
NSString *const kModelMsgFromNumber = @"fromNumber";
NSString *const kModelMsgType = @"type";
NSString *const kModelMsgFromId = @"fromId";


@interface ModelMsg ()
@end

@implementation ModelMsg

@synthesize category = _category;
@synthesize createTime = _createTime;
@synthesize content = _content;
@synthesize fromNumber = _fromNumber;
@synthesize type = _type;
@synthesize fromId = _fromId;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.category = [dict doubleValueForKey:kModelMsgCategory];
            self.createTime = [dict doubleValueForKey:kModelMsgCreateTime];
            self.content = [dict stringValueForKey:kModelMsgContent];
            self.fromNumber = [dict stringValueForKey:kModelMsgFromNumber];
            self.type = [dict doubleValueForKey:kModelMsgType];
            self.fromId = [dict doubleValueForKey:kModelMsgFromId];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.category] forKey:kModelMsgCategory];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelMsgCreateTime];
    [mutableDict setValue:self.content forKey:kModelMsgContent];
    [mutableDict setValue:self.fromNumber forKey:kModelMsgFromNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelMsgType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.fromId] forKey:kModelMsgFromId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
