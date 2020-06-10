//
//  ModelTrolley2.m
//
//  Created by 林栋 隋 on 2020/4/17
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelTrolley.h"


NSString *const kModelTrolley2Id = @"id";
NSString *const kModelTrolley2Name = @"name";
NSString *const kModelTrolley2Skus = @"skus";


@interface ModelTrolley ()
@end

@implementation ModelTrolley

@synthesize iDProperty = _iDProperty;
@synthesize name = _name;
@synthesize skus = _skus;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDProperty = [dict doubleValueForKey:kModelTrolley2Id];
            self.name = [dict stringValueForKey:kModelTrolley2Name];
        self.skus = [GlobalMethod exchangeDic:[dict objectForKey:kModelTrolley2Skus] toAryWithModelName:NSStringFromClass(ModelIntegralProduct.class)];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelTrolley2Id];
    [mutableDict setValue:self.name forKey:kModelTrolley2Name];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.skus] forKey:kModelTrolley2Skus];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
