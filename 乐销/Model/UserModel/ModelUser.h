//
//  ModelUser.h
//
//  Created by 林栋 隋 on 2020/3/24
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelUser : NSObject
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *cellPhone;
@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, assign) double areaID;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;


@end
