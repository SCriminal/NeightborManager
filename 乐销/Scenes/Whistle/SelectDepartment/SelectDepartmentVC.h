//
//  SelectDepartmentVC.h
//  NeighborManager
//
//  Created by 隋林栋 on 2020/3/24.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

@interface SelectDepartmentVC : BaseTableVC
@property (nonatomic, strong) NSMutableArray *arySelected;
@property (nonatomic, strong) void (^blockSelected)(NSMutableArray *);

@end
