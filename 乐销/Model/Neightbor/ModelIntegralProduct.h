//
//  ModelIntegralProduct.h
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelIntegralProduct : NSObject

@property (nonatomic, assign) double score;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double stockAmount;
@property (nonatomic, strong) NSString *descriptionUrl;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
