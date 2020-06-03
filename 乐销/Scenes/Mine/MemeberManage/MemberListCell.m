//
//  MemberListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "MemberListCell.h"

@interface MemberListCell ()

@end

@implementation MemberListCell
#pragma mark 懒加载
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)membership{
    if (_membership == nil) {
        _membership = [UILabel new];
        _membership.textColor = [UIColor whiteColor];
        _membership.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        _membership.numberOfLines = 1;
        _membership.lineSpace = 0;
    }
    return _membership;
}

- (UIView *)labelBg{
    if (_labelBg == nil) {
        _labelBg = [UIView new];
        _labelBg.backgroundColor = COLOR_ORANGE;

    }
    return _labelBg;
}

- (UIImageView *)headLogo{
    if (_headLogo == nil) {
        _headLogo = [UIImageView new];
        _headLogo.image = [UIImage imageNamed:@"personal_gray_head"];
        _headLogo.widthHeight = XY(W(50),W(50));
        [_headLogo addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:_headLogo.width/2.0 lineWidth:0 lineColor:[UIColor clearColor]];
        

    }
    return _headLogo;
}
- (UILabel *)phone{
    if (_phone == nil) {
        _phone = [UILabel new];
        _phone.textColor = COLOR_999;
        _phone.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _phone.numberOfLines = 1;
        _phone.lineSpace = 0;
    }
    return _phone;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.labelBg];
        [self.contentView addSubview:self.membership];
        [self.contentView addSubview:self.headLogo];
        [self.contentView addSubview:self.phone];

    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelMemberList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    self.headLogo.leftTop = XY(W(15),W(15));

    //刷新view
    [self.name fitTitle:[NSString stringWithFormat:@"%@",UnPackStr(model.name)] variable:SCREEN_WIDTH-self.headLogo.right - W(80)];
    self.name.leftTop = XY(self.headLogo.right + W(10),self.headLogo.top+W(3));
    
    [self.membership fitTitle:UnPackStr(model.memeberShow) variable:0];

    self.labelBg.widthHeight = XY(self.membership.width + W(13), W(18));
    self.labelBg.leftCenterY = XY(self.name.right + W(10),self.name.centerY);
    [self.labelBg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0 lineColor:[UIColor clearColor]];

    
    self.membership.center = self.labelBg.center;
    
    [self.phone fitTitle:UnPackStr(model.phone) variable:SCREEN_WIDTH - self.headLogo.right - W(30)];
                                  
    self.phone.leftBottom = XY(self.name.left, self.headLogo.bottom- W(3));
    //设置总高度
    self.height = self.headLogo.bottom + W(15);
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];
}

@end
