//
//  ModelUser.m
//
//  Created by 林栋 隋 on 2020/3/24
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelUser.h"



NSString *const kModelUser2HeadUrl = @"headUrl";
NSString *const kModelUser2Account = @"account";
NSString *const kModelUser2Nickname = @"nickname";
NSString *const kModelUser2Areas = @"areas";


@interface ModelUser ()
@end

@implementation ModelUser

@synthesize headUrl = _headUrl;
@synthesize account = _account;
@synthesize nickname = _nickname;
@synthesize areas = _areas;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.headUrl = [dict stringValueForKey:kModelUser2HeadUrl];
        self.account = [dict stringValueForKey:kModelUser2Account];
        self.nickname = [dict stringValueForKey:kModelUser2Nickname];
        self.areas = [GlobalMethod exchangeDic:[dict objectForKey:kModelUser2Areas] toAryWithModelName:NSStringFromClass(ModelUserAuthority.class)];
        [self fetchAreaID];
    }
    
    return self;
    
}
- (void)fetchAreaID{
    if (self.areas.count) {
        ModelUserAuthority * modelAuthority = self.areas.firstObject;
        self.areaID = [modelAuthority fetchAreaID];
    }
}
- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.headUrl forKey:kModelUser2HeadUrl];
    [mutableDict setValue:self.account forKey:kModelUser2Account];
    [mutableDict setValue:self.nickname forKey:kModelUser2Nickname];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.areas] forKey:kModelUser2Areas];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
