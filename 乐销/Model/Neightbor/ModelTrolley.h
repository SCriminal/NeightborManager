//
//  ModelTrolley2.h
//
//  Created by 林栋 隋 on 2020/4/17
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelTrolley : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *skus;
@property (nonatomic, readonly) BOOL selected;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
