//
//  CertificateDealResultVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/26.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"
typedef NS_ENUM(NSUInteger,ENUM_CERTIFICATE_DISPOSAL_RESULT_TYPE) {
    ENUM_CERTIFICATE_DISPOSAL_RESULT_SUBMIT = 1,
    ENUM_CERTIFICATE_DISPOSAL_RESULT_SUCCESS = 2,
    ENUM_CERTIFICATE_DISPOSAL_RESULT_RETURN = 3
};
@interface CertificateDealResultVC : BaseTableVC
@property (nonatomic, assign) ENUM_CERTIFICATE_DISPOSAL_RESULT_TYPE type;
@property (nonatomic, strong) void (^blockRequestSuccess)(void);

@end
