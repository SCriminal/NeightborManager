//
//  ModelAPNSRTC.h
//
//  Created by 林栋 隋 on 2020/7/11
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ModelAPNSRTC : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSArray *gSLB;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *appID;
@property (nonatomic, strong) NSString *timeStamp;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *nonce;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
