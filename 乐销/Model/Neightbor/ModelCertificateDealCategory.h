//
//  ModelCertificateDealCategory.h
//
//  Created by 林栋 隋 on 2020/5/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCertificateDealCategory : NSObject

@property (nonatomic, strong) NSString *categoryAlias;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

@interface ModelCertificateDealCategoryItem : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *title;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
