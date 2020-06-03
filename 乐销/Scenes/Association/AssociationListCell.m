//
//  AssociationListCell.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/10.
//Copyright © 2020 ping. All rights reserved.
//

#import "AssociationListCell.h"

@interface AssociationListCell ()

@end

@implementation AssociationListCell
#pragma mark 懒加载
-(UIButton *)btnEdit{
    if (_btnEdit == nil) {
        _btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnEdit addTarget:self action:@selector(btnEditClick) forControlEvents:UIControlEventTouchUpInside];
        _btnEdit.backgroundColor = [UIColor clearColor];
        _btnEdit.widthHeight = XY(W(25+20),W(60+25));
        [_btnEdit addSubview:^(){
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"address_edit"];
            icon.widthHeight = XY(W(25),W(25));
            icon.centerXCenterY = XY(W(45)/2.0, W(85)/2.0);
            return icon;
        }()];
    }
    return _btnEdit;
}
-(UIButton *)btnDelete{
    if (_btnDelete == nil) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnDelete addTarget:self action:@selector(btnDeleteClick) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.backgroundColor = [UIColor clearColor];
        _btnDelete.widthHeight = XY(W(25+30),W(60+25));
        [_btnDelete addSubview:^(){
            UIImageView *icon = [UIImageView new];
            icon.image = [UIImage imageNamed:@"address_delete"];
            icon.widthHeight = XY(W(25),W(25));
            icon.centerXCenterY = XY(W(55)/2.0, W(85)/2.0);
            return icon;
        }()];
    }
    return _btnDelete;
}
- (UILabel *)name{
    if (_name == nil) {
        _name = [UILabel new];
        _name.textColor = COLOR_333;
        _name.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightMedium];
        _name.numberOfLines = 1;
        _name.lineSpace = 0;
    }
    return _name;
}
- (UILabel *)address{
    if (_address == nil) {
        _address = [UILabel new];
        _address.textColor = COLOR_999;
        _address.font =  [UIFont systemFontOfSize:F(12) weight:UIFontWeightRegular];
        _address.numberOfLines = 0;
        _address.lineSpace = W(4);
    }
    return _address;
}

#pragma mark 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.btnEdit];
        [self.contentView addSubview:self.btnDelete];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.address];
        
    }
    return self;
}
#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelAssociation *)model{
    self.model = model;
    [self.contentView removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.btnDelete.rightTop = XY(SCREEN_WIDTH,0);

    self.btnEdit.rightTop = XY(self.btnDelete.left,0);

    [self.name fitTitle: [NSString stringWithFormat:@"%@",UnPackStr(model.name)] variable:self.btnEdit.left - W(15)];
    self.name.leftTop = XY(W(15),W(18));
    [self.address fitTitle:[NSString stringWithFormat:@"%@ %@",UnPackStr(model.leaderName),UnPackStr(model.phone)] variable:self.btnEdit.left - W(15)];
    self.address.leftTop = XY(W(15),self.name.bottom+W(13));
    
    //设置总高度
    self.height = MAX(self.address.bottom + W(18), self.btnEdit.height);
}
#pragma mark 点击事件
- (void)btnEditClick{
    if (self.blockEditClick) {
        self.blockEditClick(self.model);
    }
}
- (void)btnDeleteClick{
    if (self.blockDeleteClick) {
        self.blockDeleteClick(self.model);
    }
}


@end
