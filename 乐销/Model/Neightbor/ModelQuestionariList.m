//
//  ModelQuestionariList.m
//
//  Created by 林栋 隋 on 2020/4/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelQuestionariList.h"


NSString *const kModelQuestionariListNumber = @"number";
NSString *const kModelQuestionariListId = @"id";
NSString *const kModelQuestionariListInputStartTime = @"inputStartTime";
NSString *const kModelQuestionariListCreatorName = @"creatorName";
NSString *const kModelQuestionariListInputEndTime = @"inputEndTime";
NSString *const kModelQuestionariListTitle = @"title";
NSString *const kModelQuestionariListContactPhone = @"contactPhone";
NSString *const kModelQuestionariListDescription = @"description";
NSString *const kModelQuestionariListCreateTime = @"createTime";


@interface ModelQuestionariList ()
@end

@implementation ModelQuestionariList

@synthesize number = _number;
@synthesize iDProperty = _iDProperty;
@synthesize inputStartTime = _inputStartTime;
@synthesize creatorName = _creatorName;
@synthesize inputEndTime = _inputEndTime;
@synthesize title = _title;
@synthesize contactPhone = _contactPhone;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize createTime = _createTime;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.number = [dict stringValueForKey:kModelQuestionariListNumber];
            self.iDProperty = [dict doubleValueForKey:kModelQuestionariListId];
            self.inputStartTime = [dict doubleValueForKey:kModelQuestionariListInputStartTime];
            self.creatorName = [dict stringValueForKey:kModelQuestionariListCreatorName];
            self.inputEndTime = [dict doubleValueForKey:kModelQuestionariListInputEndTime];
            self.title = [dict stringValueForKey:kModelQuestionariListTitle];
            self.contactPhone = [dict stringValueForKey:kModelQuestionariListContactPhone];
            self.iDPropertyDescription = [dict stringValueForKey:kModelQuestionariListDescription];
            self.createTime = [dict doubleValueForKey:kModelQuestionariListCreateTime];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.number forKey:kModelQuestionariListNumber];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelQuestionariListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inputStartTime] forKey:kModelQuestionariListInputStartTime];
    [mutableDict setValue:self.creatorName forKey:kModelQuestionariListCreatorName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.inputEndTime] forKey:kModelQuestionariListInputEndTime];
    [mutableDict setValue:self.title forKey:kModelQuestionariListTitle];
    [mutableDict setValue:self.contactPhone forKey:kModelQuestionariListContactPhone];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelQuestionariListDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelQuestionariListCreateTime];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
