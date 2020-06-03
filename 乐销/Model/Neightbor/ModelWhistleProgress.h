//
//  ModelWhistleProgress.h
//
//  Created by 林栋 隋 on 2020/3/18
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelWhistleProgress : NSObject

@property (nonatomic, strong) NSString *opsTime;
@property (nonatomic, strong) NSString *deptId;
@property (nonatomic, strong) NSString *deptName;
@property (nonatomic, strong) NSString *internalBaseClassDescription;
@property (nonatomic, strong) NSString *opsId;
@property (nonatomic, strong) NSString *opsName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
