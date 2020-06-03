//
//  Content.m
//
//  Created by 林栋 隋 on 2020/4/13
//  Copyright (c) 2020 __MyCompanyName__. All rights reserved.
//

#import "ModelQuestionnairDetailContent.h"
#import "ModelQuestionnairDetailValues.h"


NSString *const kContentValue = @"value";
NSString *const kContentIsRequired = @"isRequired";
NSString *const kContentName = @"name";
NSString *const kContentType = @"type";
NSString *const kContentValues = @"values";


@interface ModelQuestionnairDetailContent ()
@end

@implementation ModelQuestionnairDetailContent

@synthesize value = _value;
@synthesize isRequired = _isRequired;
@synthesize name = _name;
@synthesize type = _type;
@synthesize values = _values;

- (NSString *)judgeRequirement{
    if (!self.isRequired) {
        return @"";
    }
    switch ((int)self.type) {//类型，1-单选  2-多选 3-文本
           case 1:
               {
                   for (ModelQuestionnairDetailValues * item in self.values) {
                       if (item.isSelected) {
                           return @"";
                       }
                   }
                   return [NSString stringWithFormat:@"请选择%@",self.name];
               }
               break;
               case 2:
               {
                   NSArray * ary = [self.values fetchSelectModelsKeyPath:@"isSelected" value:@1];
                   if (ary.count == 0) {
                       return [NSString stringWithFormat:@"请选择%@",self.name];
                   }
               }
               break;
               case 3:
               {
                   return isStr(self.value)?@"":[NSString stringWithFormat:@"请填写%@",self.name];
               }
               break;
           default:
               break;
       }
    return @"";
}
- (void)exchangeValue{
    switch ((int)self.type) {//类型，1-单选  2-多选 3-文本
           case 1:
               {
                   for (ModelQuestionnairDetailValues * item in self.values) {
                       if (item.isSelected) {
                           self.value = item.key;
                           break;
                       }
                   }
               }
               break;
               case 2:
               {
                   NSArray * ary = [self.values fetchSelectModelsKeyPath:@"isSelected" value:@1];
                   NSArray * aryValues = [ary fetchValues:@"key"];
                   self.value = [GlobalMethod exchangeDicToJson:aryValues];
               }
               break;
           default:
               break;
       }
}

#pragma mark init
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.value = [dict stringValueForKey:kContentValue];
            self.isRequired = [dict doubleValueForKey:kContentIsRequired];
            self.name = [dict stringValueForKey:kContentName];
            self.type = [dict doubleValueForKey:kContentType];
        self.values = [GlobalMethod exchangeDic:[dict objectForKey:kContentValues] toAryWithModelName:NSStringFromClass(ModelQuestionnairDetailValues.class)];
        //disposal data
        if (self.type == 1 && isStr(self.value)) {
            for (ModelQuestionnairDetailValues * item in self.values) {
                                   item.isSelected = [self.value isEqualToString:item.key];
            }
        }else if(self.type == 2 && isStr(self.value)){
            NSArray * aryItems = [NSJSONSerialization JSONObjectWithData:[self.value dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            NSMutableDictionary * dicItem = [aryItems exchangeStrAryToDic];
            for (ModelQuestionnairDetailValues * item in self.values) {
                if ([dicItem objectForKey:item.key]) {
                    item.isSelected = true;
                }
            }
        }
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.value forKey:kContentValue];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isRequired] forKey:kContentIsRequired];
    [mutableDict setValue:self.name forKey:kContentName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kContentType];
    [mutableDict setValue:[GlobalMethod exchangeAryModelToAryDic:self.values] forKey:kContentValues];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


@end
