//
//  ModelNews.m
//
//  Created by 林栋 隋 on 2020/3/17
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelNews.h"


NSString *const kModelNewsSummary = @"summary";
NSString *const kModelNewsPublishTime = @"publishTime";
NSString *const kModelNewsId = @"id";
NSString *const kModelNewsTitle = @"title";
NSString *const kModelNewsCategoryId = @"categoryId";
NSString *const kModelNewsCoverUrl = @"coverUrl";
NSString *const kModelNewsBody = @"body";
NSString *const kModelNewsDisplayMode = @"displayMode";
NSString *const kModelNewsReadAmount = @"readAmount";
NSString *const kModelNewsIsReader = @"isReader";


@interface ModelNews ()
@end

@implementation ModelNews

@synthesize summary = _summary;
@synthesize publishTime = _publishTime;
@synthesize iDProperty = _iDProperty;
@synthesize title = _title;
@synthesize categoryId = _categoryId;
@synthesize coverUrl = _coverUrl;
@synthesize body = _body;
@synthesize displayMode = _displayMode;
@synthesize readAmount = _readAmount;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.summary = [dict stringValueForKey:kModelNewsSummary];
        self.publishTime = [dict doubleValueForKey:kModelNewsPublishTime];
        self.iDProperty = [dict doubleValueForKey:kModelNewsId];
        self.title = [dict stringValueForKey:kModelNewsTitle];
        self.categoryId = [dict doubleValueForKey:kModelNewsCategoryId];
        self.coverUrl = [dict stringValueForKey:kModelNewsCoverUrl];
        self.body = [dict stringValueForKey:kModelNewsBody];
        self.displayMode = [dict doubleValueForKey:kModelNewsDisplayMode];
        self.readAmount = [dict doubleValueForKey:kModelNewsReadAmount];
        self.isReader = [dict doubleValueForKey:kModelNewsIsReader];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.summary forKey:kModelNewsSummary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.publishTime] forKey:kModelNewsPublishTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelNewsId];
    [mutableDict setValue:self.title forKey:kModelNewsTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.categoryId] forKey:kModelNewsCategoryId];
    [mutableDict setValue:self.coverUrl forKey:kModelNewsCoverUrl];
    [mutableDict setValue:self.body forKey:kModelNewsBody];
    [mutableDict setValue:[NSNumber numberWithDouble:self.displayMode] forKey:kModelNewsDisplayMode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.readAmount] forKey:kModelNewsReadAmount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isReader] forKey:kModelNewsIsReader];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
