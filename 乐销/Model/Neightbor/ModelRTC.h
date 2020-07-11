//
//  ModelRTC.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/7/11.
//Copyright © 2020 ping. All rights reserved.

#import <Foundation/Foundation.h>

@interface ModelRTC : NSObject
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
