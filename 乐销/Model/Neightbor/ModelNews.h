//
//  ModelNews.h
//
//  Created by 林栋 隋 on 2020/3/17
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelNews : NSObject

@property (nonatomic, strong) NSString *summary;
@property (nonatomic, assign) double publishTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) double categoryId;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *body;
@property (nonatomic, assign) double displayMode;
@property (nonatomic, assign) double readAmount;
@property (nonatomic, assign) double isReader;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
