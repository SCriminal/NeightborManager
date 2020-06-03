//
//  ModelAD.m
//
//  Created by 林栋 隋 on 2020/3/16
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelAD.h"


NSString *const kModelADSummary = @"summary";
NSString *const kModelADPublishTime = @"publishTime";
NSString *const kModelADId = @"id";
NSString *const kModelADTitle = @"title";
NSString *const kModelADBodyUrl = @"bodyUrl";
NSString *const kModelADCoverUrl = @"coverUrl";
NSString *const kModelADDisplayMode = @"displayMode";


@interface ModelAD ()
@end

@implementation ModelAD

@synthesize summary = _summary;
@synthesize publishTime = _publishTime;
@synthesize iDProperty = _iDProperty;
@synthesize title = _title;
@synthesize bodyUrl = _bodyUrl;
@synthesize coverUrl = _coverUrl;
@synthesize displayMode = _displayMode;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.summary = [dict stringValueForKey:kModelADSummary];
            self.publishTime = [dict doubleValueForKey:kModelADPublishTime];
            self.iDProperty = [dict doubleValueForKey:kModelADId];
            self.title = [dict stringValueForKey:kModelADTitle];
            self.bodyUrl = [dict stringValueForKey:kModelADBodyUrl];
            self.coverUrl = [dict stringValueForKey:kModelADCoverUrl];
            self.displayMode = [dict doubleValueForKey:kModelADDisplayMode];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.summary forKey:kModelADSummary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.publishTime] forKey:kModelADPublishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelADId];
    [mutableDict setValue:self.title forKey:kModelADTitle];
    [mutableDict setValue:self.bodyUrl forKey:kModelADBodyUrl];
    [mutableDict setValue:self.coverUrl forKey:kModelADCoverUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayMode] forKey:kModelADDisplayMode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
