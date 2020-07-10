//
//  ModelCertificateDealCategory.m
//
//  Created by 林栋 隋 on 2020/5/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelCertificateDealCategory.h"


NSString *const kModelCertificateDealCategoryCategoryAlias = @"categoryAlias";
NSString *const kModelCertificateDealCategoryCategoryId = @"categoryId";
NSString *const kModelCertificateDealCategoryCategoryName = @"categoryName";
NSString *const kModelCertificateDealCategoryList = @"list";


@interface ModelCertificateDealCategory ()
@end

@implementation ModelCertificateDealCategory

@synthesize categoryAlias = _categoryAlias;
@synthesize categoryId = _categoryId;
@synthesize categoryName = _categoryName;
@synthesize list = _list;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.categoryAlias = [dict stringValueForKey:kModelCertificateDealCategoryCategoryAlias];
            self.categoryId = [dict doubleValueForKey:kModelCertificateDealCategoryCategoryId];
            self.categoryName = [dict stringValueForKey:kModelCertificateDealCategoryCategoryName];
        self.list = [GlobalMethod exchangeDic:[dict objectForKey:kModelCertificateDealCategoryList] toAryWithModelName:NSStringFromClass(ModelCertificateDealCategoryItem.class)];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.categoryAlias forKey:kModelCertificateDealCategoryCategoryAlias];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelCertificateDealCategoryCategoryId];
    [mutableDict setValue:self.categoryName forKey:kModelCertificateDealCategoryCategoryName];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.list] forKey:kModelCertificateDealCategoryList];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end


NSString *const kModelCertificateDealCategoryItemId = @"id";
NSString *const kModelCertificateDealCategoryItemTitle = @"title";




@implementation ModelCertificateDealCategoryItem

@synthesize iDProperty = _iDProperty;
@synthesize title = _title;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.iDProperty = [dict doubleValueForKey:kModelCertificateDealCategoryItemId];
            self.title = [dict stringValueForKey:kModelCertificateDealCategoryItemTitle];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCertificateDealCategoryItemId];
    [mutableDict setValue:self.title forKey:kModelCertificateDealCategoryItemTitle];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
