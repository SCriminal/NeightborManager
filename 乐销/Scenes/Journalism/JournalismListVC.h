//
//  JournalismListVC.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "BaseTableVC.h"

typedef NS_ENUM(NSUInteger, ENUM_NEWS_LIST_TYPE) {
    ENUM_NEWS_LIST_DYNAMIC=0,
    ENUM_NEWS_LIST_HELP,
    ENUM_NEWS_LIST_ABOUT,
};
@interface JournalismListVC : BaseTableVC
@property (nonatomic, assign) ENUM_NEWS_LIST_TYPE type;
@end
