//
//  ModelCertificateContentDetail.m
//
//  Created by 林栋 隋 on 2020/5/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelCertificateContentDetail.h"


NSString *const kModelCertificateContentDetailId = @"id";
NSString *const kModelCertificateContentDetailCategoryAlias = @"categoryAlias";
NSString *const kModelCertificateContentDetailCategoryId = @"categoryId";
NSString *const kModelCertificateContentDetailDescription = @"description";
NSString *const kModelCertificateContentDetailDisplayMode = @"displayMode";
NSString *const kModelCertificateContentDetailTemplate = @"template";
NSString *const kModelCertificateContentDetailCategoryName = @"categoryName";


@interface ModelCertificateContentDetail ()
@end

@implementation ModelCertificateContentDetail

@synthesize iDProperty = _iDProperty;
@synthesize categoryAlias = _categoryAlias;
@synthesize categoryId = _categoryId;
@synthesize iDPropertyDescription = _iDPropertyDescription;
@synthesize displayMode = _displayMode;
@synthesize template = _template;
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
            self.iDProperty = [dict doubleValueForKey:kModelCertificateContentDetailId];
            self.categoryAlias = [dict stringValueForKey:kModelCertificateContentDetailCategoryAlias];
            self.categoryId = [dict doubleValueForKey:kModelCertificateContentDetailCategoryId];
            self.iDPropertyDescription = [dict stringValueForKey:kModelCertificateContentDetailDescription];
            self.displayMode = [dict doubleValueForKey:kModelCertificateContentDetailDisplayMode];
            self.template =  [GlobalMethod exchangeDic:[dict objectForKey:kModelCertificateContentDetailTemplate] toAryWithModelName:@"ModelQuestionnairDetailContent"];
            self.categoryName = [dict stringValueForKey:kModelCertificateContentDetailCategoryName];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCertificateContentDetailId];
    [mutableDict setValue:self.categoryAlias forKey:kModelCertificateContentDetailCategoryAlias];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelCertificateContentDetailCategoryId];
    [mutableDict setValue:self.iDPropertyDescription forKey:kModelCertificateContentDetailDescription];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayMode] forKey:kModelCertificateContentDetailDisplayMode];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.template] forKey:kModelCertificateContentDetailTemplate];
    [mutableDict setValue:self.categoryName forKey:kModelCertificateContentDetailCategoryName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
