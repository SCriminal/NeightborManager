//
//  ModelCertificateDealDetail.h
//
//  Created by 林栋 隋 on 2020/6/1
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCertificateDealDetail : NSObject

@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *handlerName;
@property (nonatomic, assign) double handleTime;
@property (nonatomic, assign) double createTime;
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *categoryAlias;
@property (nonatomic, strong) NSString *submitterName;
@property (nonatomic, assign) double submitTime;
@property (nonatomic, assign) double creatorId;
@property (nonatomic, assign) double userId;
@property (nonatomic, assign) double status;
@property (nonatomic, strong) NSArray *participant;
@property (nonatomic, assign) double onekeyId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double iDProperty;

//logical
@property (nonatomic, strong) NSString *statusShow;
@property (nonatomic, strong) UIColor *statusColorShow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
