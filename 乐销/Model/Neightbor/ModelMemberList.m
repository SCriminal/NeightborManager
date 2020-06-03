//
//  ModelMemberList.m
//
//  Created by 林栋 隋 on 2020/3/14
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelMemberList.h"


NSString *const kModelMemberListName = @"name";
NSString *const kModelMemberListPhone = @"phone";
NSString *const kModelMemberListTag = @"tag";


@interface ModelMemberList ()
@end

@implementation ModelMemberList

@synthesize name = _name;
@synthesize phone = _phone;
@synthesize tag = _tag;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.name = [dict stringValueForKey:kModelMemberListName];
            self.phone = [dict stringValueForKey:kModelMemberListPhone];
            self.tag = [dict doubleValueForKey:kModelMemberListTag];
        
        //1业主2亲友3租户
        switch ((int)self.tag) {
            case 1:
                self.memeberShow = @"业主";
                break;
            case 2:
                self.memeberShow = @"亲友";
                break;
            case 3:
                self.memeberShow = @"租户";
                break;
            default:
                break;
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kModelMemberListName];
    [mutableDict setValue:self.phone forKey:kModelMemberListPhone];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tag] forKey:kModelMemberListTag];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
