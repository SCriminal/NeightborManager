//
//  ModelMsg.h
//
//  Created by 林栋 隋 on 2020/5/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelMsg : NSObject

@property (nonatomic, assign) double category;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *fromNumber;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double fromId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
