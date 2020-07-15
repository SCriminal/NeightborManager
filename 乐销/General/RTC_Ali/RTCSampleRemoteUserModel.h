//
//  RTCSampleRemoteUserModel.h
//  RtcSample
//
//  Created by daijian on 2019/4/11.
//  Copyright © 2019年 tiantian. All rights reserved.
//


#import <Foundation/Foundation.h>




NS_ASSUME_NONNULL_BEGIN
@class AliRenderView;
@interface RTCSampleRemoteUserModel : NSObject

@property (nonatomic, strong) AliRenderView *view;

@property (nonatomic, strong) NSString *uid;

@property (nonatomic, assign) NSUInteger track;

@end

NS_ASSUME_NONNULL_END
