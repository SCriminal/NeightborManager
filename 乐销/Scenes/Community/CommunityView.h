//
//  CommunityView.h
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityNavView : UIView
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *selectCommunity;
@property (nonatomic, strong) UIImageView *arrowLocal;
@property (nonatomic, strong) UIImageView *arrowDown;
@property (nonatomic, strong) void (^blockChangeDistrictClick)(void);



@end




@interface CommunityInfoCell : UITableViewCell

@property (strong, nonatomic) UILabel *infoTitle;
@property (strong, nonatomic) UILabel *infoTime;

#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelNews *)model;

@end


