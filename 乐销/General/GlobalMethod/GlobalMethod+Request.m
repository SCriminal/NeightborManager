//
//  GlobalMethod+Request.m
//中车运
//
//  Created by 隋林栋 on 2017/2/21.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "GlobalMethod+Request.h"
#import "VersionUpView.h"
//阿里云推送
#import <CloudPushSDK/CloudPushSDK.h>
#import "ModelVersionUp.h"

//request
#import "RequestApi+Neighbor.h"

@implementation GlobalMethod (Request)
#pragma mark read Local data
+ (NSDictionary *)readLocalRequestData:(NSString *)key
{
    NSString * strPath = [[NSBundle mainBundle]pathForResource:key ofType:@".json"];
    return [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithContentsOfFile:strPath] options:NSJSONReadingMutableContainers error:nil];
}
#pragma mark request

//请求bind device token
+ (void)requestBindDeviceToken{
    if ([self isLoginSuccess]) {
        __block BOOL isSuccess = NO;
        if (!isSuccess) {
            [CloudPushSDK bindAccount:UnPackStr([GlobalData sharedInstance].GB_UserModel.account) withCallback:^(CloudPushCallbackResult *res) {
                if (res.success) {
                    isSuccess = YES;
                }
            }];
        }
        [RequestApi requestBindDeviceIdWithDeviceID:nil delegate:nil success:nil failure:nil];
    }
    
}
// requestCellPhoneBinded
+ (void)requestCellPhoneBinded{
    if ([self isLoginSuccess]) {
        
        [RequestApi requestPersonlInfoWithDelegate:nil success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
            [GlobalData sharedInstance].GB_UserModel.cellPhone = [response stringValueForKey:@"cellPhone"];
        } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
            
        }];
    }
}
//request version
+ (void)requestVersion:(void(^)(void))blockSuccess{
    [RequestApi requestVersionWithDelegate:nil success:^(NSDictionary *response, id mark) {
        ModelVersionUp * modelVersion = [GlobalMethod exchangeDicToModel:response modelName:@"ModelVersionUp"];
        if (modelVersion.versionNumber.doubleValue) {
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            VersionUpView *view = [VersionUpView sharedInstance];
            [view resetViewWithModel:modelVersion];
            view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [window addSubview:view];
        }else{
            if (blockSuccess) {
                blockSuccess();
            }
        }
    } failure:^(NSString *errorStr, id mark) {
        
    }];
}




@end
