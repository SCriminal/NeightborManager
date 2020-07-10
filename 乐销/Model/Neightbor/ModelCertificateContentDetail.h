//
//  ModelCertificateContentDetail.h
//
//  Created by 林栋 隋 on 2020/5/29
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelCertificateContentDetail : NSObject

@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *categoryAlias;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, strong) NSString *iDPropertyDescription;
@property (nonatomic, assign) double displayMode;
@property (nonatomic, strong) NSArray *template;
@property (nonatomic, strong) NSArray *participant;
@property (nonatomic, strong) NSString *categoryName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
