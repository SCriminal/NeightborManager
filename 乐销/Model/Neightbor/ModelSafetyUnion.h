//
//  ModelSafetyUnion.h
//
//  Created by 林栋 隋 on 2020/7/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelSafetyUnion : NSObject

@property (nonatomic, strong) NSString *account;
@property (nonatomic, assign) double userId;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, assign) double estateId;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *estateName;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
