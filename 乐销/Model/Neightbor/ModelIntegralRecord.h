//
//  ModelIntegralRecord.h
//
//  Created by 林栋 隋 on 2020/3/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelIntegralRecord : NSObject

@property (nonatomic, assign) double createTime;
@property (nonatomic, assign) double score;
@property (nonatomic, assign) double channel;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double direction;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
