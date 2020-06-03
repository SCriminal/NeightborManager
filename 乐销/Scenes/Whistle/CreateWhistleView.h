//
//  CreateWhistleView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceHolderTextView.h"
//图片选择collection
#import "Collection_Image.h"

@interface MCreateWhistleTopView : UIView
@property (nonatomic, strong) Collection_Image *collection_Image;
@property (strong, nonatomic) PlaceHolderTextView *textView;

@end
