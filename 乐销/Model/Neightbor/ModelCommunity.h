//
//  ModelCommunity.h
//
//  Created by 林栋 隋 on 2020/3/15
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCommunity : NSObject

@property (nonatomic, strong) NSString *policePhone;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *managerName;
@property (nonatomic, strong) NSString *managerPhone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *policeName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
