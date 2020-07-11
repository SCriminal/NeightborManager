//
//  ModelAPNSRTC.m
//
//  Created by 林栋 隋 on 2020/7/11
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelAPNSRTC.h"


NSString *const kModelAPNSRTCUserId = @"userId";
NSString *const kModelAPNSRTCGSLB = @"gSLB";
NSString *const kModelAPNSRTCChannelId = @"channelId";
NSString *const kModelAPNSRTCAppID = @"appID";
NSString *const kModelAPNSRTCTimeStamp = @"timeStamp";
NSString *const kModelAPNSRTCToken = @"token";
NSString *const kModelAPNSRTCNonce = @"nonce";


@interface ModelAPNSRTC ()
@end

@implementation ModelAPNSRTC

@synthesize userId = _userId;
@synthesize gSLB = _gSLB;
@synthesize channelId = _channelId;
@synthesize appID = _appID;
@synthesize timeStamp = _timeStamp;
@synthesize token = _token;
@synthesize nonce = _nonce;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userId = [dict stringValueForKey:kModelAPNSRTCUserId];
            self.gSLB =  [dict arrayValueForKey:kModelAPNSRTCGSLB];
            self.channelId = [dict stringValueForKey:kModelAPNSRTCChannelId];
            self.appID = [dict stringValueForKey:kModelAPNSRTCAppID];
            self.timeStamp = [dict stringValueForKey:kModelAPNSRTCTimeStamp];
            self.token = [dict stringValueForKey:kModelAPNSRTCToken];
            self.nonce = [dict stringValueForKey:kModelAPNSRTCNonce];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kModelAPNSRTCUserId];
    [mutableDict setValue:[GlobalMethod exchangeDicToJson:self.gSLB] forKey:kModelAPNSRTCGSLB];
    [mutableDict setValue:self.channelId forKey:kModelAPNSRTCChannelId];
    [mutableDict setValue:self.appID forKey:kModelAPNSRTCAppID];
    [mutableDict setValue:self.timeStamp forKey:kModelAPNSRTCTimeStamp];
    [mutableDict setValue:self.token forKey:kModelAPNSRTCToken];
    [mutableDict setValue:self.nonce forKey:kModelAPNSRTCNonce];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
