//
//  ModelQuestionariList.h
//
//  Created by 林栋 隋 on 2020/4/10
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelQuestionariList : NSObject

@property (nonatomic, strong) NSString *number;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, assign) double inputStartTime;
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, assign) double inputEndTime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double createTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
