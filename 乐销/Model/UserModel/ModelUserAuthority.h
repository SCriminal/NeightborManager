//
//  ModelUser2.h
//
//  Created by 林栋 隋 on 2020/3/24
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelUserAuthority : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double parentId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *children;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

- (double)fetchAreaID;

@end
