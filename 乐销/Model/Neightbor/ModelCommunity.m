//
//  ModelCommunity.m
//
//  Created by 林栋 隋 on 2020/3/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelCommunity.h"


NSString *const kModelCommunityPolicePhone = @"policePhone";
NSString *const kModelCommunityId = @"id";
NSString *const kModelCommunityManagerName = @"managerName";
NSString *const kModelCommunityManagerPhone = @"managerPhone";
NSString *const kModelCommunityName = @"name";
NSString *const kModelCommunityPoliceName = @"policeName";


@interface ModelCommunity ()
@end

@implementation ModelCommunity

@synthesize policePhone = _policePhone;
@synthesize iDProperty = _iDProperty;
@synthesize managerName = _managerName;
@synthesize managerPhone = _managerPhone;
@synthesize name = _name;
@synthesize policeName = _policeName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.policePhone = [dict stringValueForKey:kModelCommunityPolicePhone];
            self.iDProperty = [dict doubleValueForKey:kModelCommunityId];
            self.managerName = [dict stringValueForKey:kModelCommunityManagerName];
            self.managerPhone = [dict stringValueForKey:kModelCommunityManagerPhone];
            self.name = [dict stringValueForKey:kModelCommunityName];
            self.policeName = [dict stringValueForKey:kModelCommunityPoliceName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.policePhone forKey:kModelCommunityPolicePhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCommunityId];
    [mutableDict setValue:self.managerName forKey:kModelCommunityManagerName];
    [mutableDict setValue:self.managerPhone forKey:kModelCommunityManagerPhone];
    [mutableDict setValue:self.name forKey:kModelCommunityName];
    [mutableDict setValue:self.policeName forKey:kModelCommunityPoliceName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
