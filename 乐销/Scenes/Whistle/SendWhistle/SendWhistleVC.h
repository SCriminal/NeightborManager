//
//  SendWhistleVC.h
//  Neighbor
//
//  Sendd by 隋林栋 on 2020/3/17.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SendWhistleVC : BaseTableVC
@property (nonatomic, strong) void (^blockRequestSuccess)(void);

@end
