//
//  ArchiveListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "ArchiveListCell.h"

@interface ArchiveListCell ()

@end

@implementation ArchiveListCell
#pragma mark 懒加载
- (UILabel *)buildingNo{
    if (_buildingNo == nil) {
        _buildingNo = [UILabel new];
        _buildingNo.textColor = COLOR_333;
        _buildingNo.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _buildingNo.numberOfLines = 1;
        _buildingNo.lineSpace = 0;
    }
    return _buildingNo;
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
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_999;
        _name.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
-(UIButton *)btnEdit{
    if (_btnEdit == nil) {
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnEdit.tag = 1;
        _btnEdit.userInteractionEnabled = false;
        [_btnEdit addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        _btnEdit.backgroundColor = [UIColor clearColor];
        _btnEdit.widthHeight = XY(W(55),W(55));
        [_btnEdit addSubview:^(){
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"address_edit"];
            icon.widthHeight = XY(W(25),W(25));
            icon.centerXCenterY = XY(W(55)/2.0, W(55)/2.0);
            return icon;
        }()];
    }
    return _btnEdit;
}



#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.buildingNo];
        [self.contentView addSubview:self.labelBg];
        [self.contentView addSubview:self.membership];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.btnEdit];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelArchiveList *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    [self.buildingNo fitTitle:[NSString stringWithFormat:@"%@号楼%@单元%@",UnPackStr(model.buildingName),UnPackStr(model.unitName),UnPackStr(model.roomName)] variable:W(270)];
    self.buildingNo.leftTop = XY(W(15),W(18));
    
    [self.membership fitTitle:UnPackStr(model.typeShow) variable:0];
    
    self.labelBg.widthHeight = XY(self.membership.width + W(13), W(18));
    self.labelBg.leftCenterY = XY(self.buildingNo.right + W(10),self.buildingNo.centerY);
    [self.labelBg addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:2 lineWidth:0 lineColor:[UIColor clearColor]];

    self.membership.center = self.labelBg.center;
    
    [self.name fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(model.realName),UnPackStr(model.cellPhone)] variable:W(270)];
    self.name.leftTop = XY(W(15),self.buildingNo.bottom+W(13));
    
    
    //设置总高度
    self.height = self.name.bottom + W(18);
    
    self.btnEdit.rightCenterY = XY(SCREEN_WIDTH ,self.height/2.0);
    
    [self.contentView addLineFrame:CGRectMake(W(15), self.height - 1, SCREEN_WIDTH - W(30), 1)];


}

#pragma mark click
- (void)btnClick{
    if (self.blockEditClick) {
        self.blockEditClick(self.model);
    }
}

@end
