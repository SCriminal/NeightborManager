//
//  ModelShopDetailCategory.h
//
//  Created by 林栋 隋 on 2020/3/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelShopDetailCategory : NSObject
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double storeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *skuList;
@property (nonatomic, assign) BOOL isSelected;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
