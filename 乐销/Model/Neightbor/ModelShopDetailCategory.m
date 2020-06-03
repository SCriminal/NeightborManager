//
//  ModelShopDetailCategory2.m
//
//  Created by 林栋 隋 on 2020/3/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelShopDetailCategory.h"


NSString *const kModelShopDetailCategory2Id = @"id";
NSString *const kModelShopDetailCategory2StoreId = @"storeId";
NSString *const kModelShopDetailCategory2Name = @"name";
NSString *const kModelShopDetailCategory2SkuList = @"skuList";


@interface ModelShopDetailCategory ()
@end

@implementation ModelShopDetailCategory

@synthesize iDProperty = _iDProperty;
@synthesize storeId = _storeId;
@synthesize name = _name;
@synthesize skuList = _skuList;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.iDProperty = [dict doubleValueForKey:kModelShopDetailCategory2Id];
        self.storeId = [dict doubleValueForKey:kModelShopDetailCategory2StoreId];
        self.name = [dict stringValueForKey:kModelShopDetailCategory2Name];
        self.skuList = [GlobalMethod exchangeDic:[dict objectForKey:kModelShopDetailCategory2SkuList] toAryWithModelName:@"ModelShopDetailProduct"];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelShopDetailCategory2Id];
    [mutableDict setValue:[NSNumber numberWithDouble:self.storeId] forKey:kModelShopDetailCategory2StoreId];
    [mutableDict setValue:self.name forKey:kModelShopDetailCategory2Name];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.skuList] forKey:kModelShopDetailCategory2SkuList];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
