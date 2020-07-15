//
//  RTCSampleChatViewController.h
//  RtcSample
//
//  Created by daijian on 2019/2/27.
//  Copyright © 2019年 tiantian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AliRTCSdk/AliRTCSdk.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTCSampleChatViewController : UIViewController
@property (nonatomic, strong) ModelRTC *model;
@end

@class AliRenderView;
@interface RTCRemoterUserView : UICollectionViewCell
/**
 @brief 用户流视图
 
 @param view renderview
 */
- (void)updateUserRenderview:(AliRenderView *)view;
@end

NS_ASSUME_NONNULL_END
