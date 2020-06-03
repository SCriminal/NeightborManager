//
//  ModelShopDetailProduct.h
//
//  Created by 林栋 隋 on 2020/3/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelShopDetailProduct : NSObject

@property (nonatomic, assign) double monthAmount;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double stockAmount;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, strong) NSString *descriptionUrl;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, assign) double storeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *categoryName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
