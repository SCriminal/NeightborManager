//
//  ModelAD.h
//
//  Created by 林栋 隋 on 2020/3/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAD : NSObject

@property (nonatomic, strong) NSString *summary;
@property (nonatomic, assign) double publishTime;
@property (nonatomic, assign) double iDProperty;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *bodyUrl;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, assign) double displayMode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
