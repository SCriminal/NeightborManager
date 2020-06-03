//
//  ModelShopDetailProduct.m
//
//  Created by 林栋 隋 on 2020/3/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelShopDetailProduct.h"


NSString *const kModelShopDetailProductMonthAmount = @"monthAmount";
NSString *const kModelShopDetailProductId = @"id";
NSString *const kModelShopDetailProductPrice = @"price";
NSString *const kModelShopDetailProductStockAmount = @"stockAmount";
NSString *const kModelShopDetailProductCategoryId = @"categoryId";
NSString *const kModelShopDetailProductDescriptionUrl = @"descriptionUrl";
NSString *const kModelShopDetailProductCoverUrl = @"coverUrl";
NSString *const kModelShopDetailProductStoreId = @"storeId";
NSString *const kModelShopDetailProductName = @"name";
NSString *const kModelShopDetailProductCategoryName = @"categoryName";


@interface ModelShopDetailProduct ()
@end

@implementation ModelShopDetailProduct

@synthesize monthAmount = _monthAmount;
@synthesize iDProperty = _iDProperty;
@synthesize price = _price;
@synthesize stockAmount = _stockAmount;
@synthesize categoryId = _categoryId;
@synthesize descriptionUrl = _descriptionUrl;
@synthesize coverUrl = _coverUrl;
@synthesize storeId = _storeId;
@synthesize name = _name;
@synthesize categoryName = _categoryName;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.monthAmount = [dict doubleValueForKey:kModelShopDetailProductMonthAmount];
            self.iDProperty = [dict doubleValueForKey:kModelShopDetailProductId];
            self.price = [dict doubleValueForKey:kModelShopDetailProductPrice];
            self.stockAmount = [dict doubleValueForKey:kModelShopDetailProductStockAmount];
            self.categoryId = [dict doubleValueForKey:kModelShopDetailProductCategoryId];
            self.descriptionUrl = [dict stringValueForKey:kModelShopDetailProductDescriptionUrl];
            self.coverUrl = [dict stringValueForKey:kModelShopDetailProductCoverUrl];
            self.storeId = [dict doubleValueForKey:kModelShopDetailProductStoreId];
            self.name = [dict stringValueForKey:kModelShopDetailProductName];
            self.categoryName = [dict stringValueForKey:kModelShopDetailProductCategoryName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.monthAmount] forKey:kModelShopDetailProductMonthAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelShopDetailProductId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.price] forKey:kModelShopDetailProductPrice];
    [mutableDict setValue:[NSNumber numberWithDouble:self.stockAmount] forKey:kModelShopDetailProductStockAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelShopDetailProductCategoryId];
    [mutableDict setValue:self.descriptionUrl forKey:kModelShopDetailProductDescriptionUrl];
    [mutableDict setValue:self.coverUrl forKey:kModelShopDetailProductCoverUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.storeId] forKey:kModelShopDetailProductStoreId];
    [mutableDict setValue:self.name forKey:kModelShopDetailProductName];
    [mutableDict setValue:self.categoryName forKey:kModelShopDetailProductCategoryName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
