//
//  ModelUser2.m
//
//  Created by 林栋 隋 on 2020/3/24
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelUserAuthority.h"

NSString *const kModelUserId = @"id";
NSString *const kModelUserParentId = @"parentId";
NSString *const kModelUserName = @"name";
NSString *const kModelUserChildren = @"children";


@interface ModelUserAuthority ()
@end

@implementation ModelUserAuthority

@synthesize iDProperty = _iDProperty;
@synthesize parentId = _parentId;
@synthesize name = _name;
@synthesize children = _children;


- (double)fetchAreaID{
    if (self.children.count) {
        ModelUserAuthority * m = self.children.firstObject;
        return [m fetchAreaID];
    }
    return self.iDProperty;
}

#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.iDProperty = [dict doubleValueForKey:kModelUserId];
        self.parentId = [dict doubleValueForKey:kModelUserParentId];
        self.name = [dict stringValueForKey:kModelUserName];
        self.children = [GlobalMethod exchangeDic:[dict objectForKey:kModelUserChildren] toAryWithModelName:NSStringFromClass(ModelUserAuthority.class)];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.parentId] forKey:kModelUserParentId];
    [mutableDict setValue:self.name forKey:kModelUserName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.children] forKey:kModelUserChildren];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
