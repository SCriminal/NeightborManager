//
//  Values.m
//
//  Created by 林栋 隋 on 2020/4/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelQuestionnairDetailValues.h"


NSString *const kValuesKey = @"key";
NSString *const kValuesValue = @"value";


@interface ModelQuestionnairDetailValues ()
@end

@implementation ModelQuestionnairDetailValues

@synthesize key = _key;
@synthesize value = _value;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.key = [dict stringValueForKey:kValuesKey];
            self.value = [dict stringValueForKey:kValuesValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.key forKey:kValuesKey];
    [mutableDict setValue:self.value forKey:kValuesValue];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
