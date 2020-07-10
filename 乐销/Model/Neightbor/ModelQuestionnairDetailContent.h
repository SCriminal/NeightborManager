//
//  Content.h
//
//  Created by 林栋 隋 on 2020/4/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelQuestionnairDetailContent : NSObject

@property (nonatomic, strong) NSString *value;
@property (nonatomic, assign) double isRequired;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSArray *values;
@property (nonatomic, assign) double min;
@property (nonatomic, assign) double max;
@property (nonatomic, strong) NSString *tip;

- (NSString *)judgeRequirement;
- (void)exchangeValue;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
