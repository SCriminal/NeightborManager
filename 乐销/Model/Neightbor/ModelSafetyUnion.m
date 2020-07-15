//
//  ModelSafetyUnion.m
//
//  Created by 林栋 隋 on 2020/7/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelSafetyUnion.h"


NSString *const kModelSafetyUnionAccount = @"account";
NSString *const kModelSafetyUnionUserId = @"userId";
NSString *const kModelSafetyUnionHeadUrl = @"headUrl";
NSString *const kModelSafetyUnionEstateId = @"estateId";
NSString *const kModelSafetyUnionId = @"id";
NSString *const kModelSafetyUnionEstateName = @"estateName";
NSString *const kModelSafetyUnionType = @"type";
NSString *const kModelSafetyUnionName = @"name";


@interface ModelSafetyUnion ()
@end

@implementation ModelSafetyUnion

@synthesize account = _account;
@synthesize userId = _userId;
@synthesize headUrl = _headUrl;
@synthesize estateId = _estateId;
@synthesize iDProperty = _iDProperty;
@synthesize estateName = _estateName;
@synthesize type = _type;
@synthesize name = _name;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.account = [dict stringValueForKey:kModelSafetyUnionAccount];
            self.userId = [dict doubleValueForKey:kModelSafetyUnionUserId];
            self.headUrl = [dict stringValueForKey:kModelSafetyUnionHeadUrl];
            self.estateId = [dict doubleValueForKey:kModelSafetyUnionEstateId];
            self.iDProperty = [dict doubleValueForKey:kModelSafetyUnionId];
            self.estateName = [dict stringValueForKey:kModelSafetyUnionEstateName];
            self.type = [dict doubleValueForKey:kModelSafetyUnionType];
            self.name = [dict stringValueForKey:kModelSafetyUnionName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.account forKey:kModelSafetyUnionAccount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelSafetyUnionUserId];
    [mutableDict setValue:self.headUrl forKey:kModelSafetyUnionHeadUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.estateId] forKey:kModelSafetyUnionEstateId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelSafetyUnionId];
    [mutableDict setValue:self.estateName forKey:kModelSafetyUnionEstateName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kModelSafetyUnionType];
    [mutableDict setValue:self.name forKey:kModelSafetyUnionName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
