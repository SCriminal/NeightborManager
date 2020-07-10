//
//  ModelCertificateDealDetail.m
//
//  Created by 林栋 隋 on 2020/6/1
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelCertificateDealDetail.h"


NSString *const kModelCertificateDealDetailCategoryName = @"categoryName";
NSString *const kModelCertificateDealDetailIdNumber = @"idNumber";
NSString *const kModelCertificateDealDetailRealName = @"realName";
NSString *const kModelCertificateDealDetailHandlerName = @"handlerName";
NSString *const kModelCertificateDealDetailHandleTime = @"handleTime";
NSString *const kModelCertificateDealDetailCreateTime = @"createTime";
NSString *const kModelCertificateDealDetailCreatorName = @"creatorName";
NSString *const kModelCertificateDealDetailNumber = @"number";
NSString *const kModelCertificateDealDetailCategoryAlias = @"categoryAlias";
NSString *const kModelCertificateDealDetailSubmitterName = @"submitterName";
NSString *const kModelCertificateDealDetailSubmitTime = @"submitTime";
NSString *const kModelCertificateDealDetailCreatorId = @"creatorId";
NSString *const kModelCertificateDealDetailUserId = @"userId";
NSString *const kModelCertificateDealDetailStatus = @"status";
NSString *const kModelCertificateDealDetailParticipant = @"participant";
NSString *const kModelCertificateDealDetailOnekeyId = @"onekeyId";
NSString *const kModelCertificateDealDetailTitle = @"title";
NSString *const kModelCertificateDealDetailId = @"id";

@interface ModelCertificateDealDetail ()
@end

@implementation ModelCertificateDealDetail

@synthesize categoryName = _categoryName;
@synthesize idNumber = _idNumber;
@synthesize realName = _realName;
@synthesize handlerName = _handlerName;
@synthesize handleTime = _handleTime;
@synthesize createTime = _createTime;
@synthesize creatorName = _creatorName;
@synthesize number = _number;
@synthesize categoryAlias = _categoryAlias;
@synthesize submitterName = _submitterName;
@synthesize submitTime = _submitTime;
@synthesize creatorId = _creatorId;
@synthesize userId = _userId;
@synthesize status = _status;


#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.categoryName = [dict stringValueForKey:kModelCertificateDealDetailCategoryName];
            self.idNumber = [dict stringValueForKey:kModelCertificateDealDetailIdNumber];
            self.realName = [dict stringValueForKey:kModelCertificateDealDetailRealName];
            self.handlerName = [dict stringValueForKey:kModelCertificateDealDetailHandlerName];
            self.handleTime = [dict doubleValueForKey:kModelCertificateDealDetailHandleTime];
            self.createTime = [dict doubleValueForKey:kModelCertificateDealDetailCreateTime];
            self.creatorName = [dict stringValueForKey:kModelCertificateDealDetailCreatorName];
            self.number = [dict stringValueForKey:kModelCertificateDealDetailNumber];
            self.categoryAlias = [dict stringValueForKey:kModelCertificateDealDetailCategoryAlias];
            self.submitterName = [dict stringValueForKey:kModelCertificateDealDetailSubmitterName];
            self.submitTime = [dict doubleValueForKey:kModelCertificateDealDetailSubmitTime];
            self.creatorId = [dict doubleValueForKey:kModelCertificateDealDetailCreatorId];
            self.userId = [dict doubleValueForKey:kModelCertificateDealDetailUserId];
            self.status = [dict doubleValueForKey:kModelCertificateDealDetailStatus];
        self.onekeyId = [dict doubleValueForKey:kModelCertificateDealDetailOnekeyId];
        self.title = [dict stringValueForKey:kModelCertificateDealDetailTitle];
        self.iDProperty = [dict doubleValueForKey:kModelCertificateDealDetailId];

        self.participant =  [GlobalMethod exchangeDic:[dict objectForKey:kModelCertificateDealDetailParticipant] toAryWithModelName:@"ModelQuestionnairDetailContent"];

        if (self.status == 0) {
            self.status = [dict doubleValueForKey:@"onekeyStatus"];
        }
        //
        switch ((int)self.status) {
            case 1:
            {
                self.statusShow = @"已提交";
                self.statusColorShow = COLOR_ORANGE;
            }
                break;
        
            case 2:
            {
                self.statusShow = @"已办理";
                self.statusColorShow = COLOR_BLUE;

            }
                break;
            case 3:
            {
                self.statusShow = @"已退回";
                self.statusColorShow = COLOR_GREEN;
            }
                break;
           
            default:
                break;
        }

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.categoryName forKey:kModelCertificateDealDetailCategoryName];
    [mutableDict setValue:self.idNumber forKey:kModelCertificateDealDetailIdNumber];
    [mutableDict setValue:self.realName forKey:kModelCertificateDealDetailRealName];
    [mutableDict setValue:self.handlerName forKey:kModelCertificateDealDetailHandlerName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.handleTime] forKey:kModelCertificateDealDetailHandleTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.createTime] forKey:kModelCertificateDealDetailCreateTime];
    [mutableDict setValue:self.creatorName forKey:kModelCertificateDealDetailCreatorName];
    [mutableDict setValue:self.number forKey:kModelCertificateDealDetailNumber];
    [mutableDict setValue:self.categoryAlias forKey:kModelCertificateDealDetailCategoryAlias];
    [mutableDict setValue:self.submitterName forKey:kModelCertificateDealDetailSubmitterName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.submitTime] forKey:kModelCertificateDealDetailSubmitTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.creatorId] forKey:kModelCertificateDealDetailCreatorId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userId] forKey:kModelCertificateDealDetailUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.status] forKey:kModelCertificateDealDetailStatus];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.participant] forKey:kModelCertificateDealDetailParticipant];
    [mutableDict setValue:[NSNumber numberWithDouble:self.onekeyId] forKey:kModelCertificateDealDetailOnekeyId];
    [mutableDict setValue:self.title forKey:kModelCertificateDealDetailTitle];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iDProperty] forKey:kModelCertificateDealDetailId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
