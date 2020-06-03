//
//  CollectionImageCell.m
//中车运
//
//  Created by 隋林栋 on 2017/3/14.
//  Copyright © 2017年 ping. All rights reserved.
//

#import "CollectionImageCell.h"


@implementation CollectionImageCell
#pragma mark 懒加载
- (UIButton *)btnDelete{
    if (_btnDelete == nil) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.tag = 1;
        [_btnDelete addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _btnDelete.backgroundColor = [UIColor redColor];
        _btnDelete.widthHeight = XY(W(20),W(20));
        _btnDelete.hidden = true;
    }
    return _btnDelete;
}
- (UIImageView *)ivImage{
    if (_ivImage == nil) {
        _ivImage = [UIImageView new];
        _ivImage.backgroundColor = [UIColor clearColor];
        _ivImage.image = nil;
        _ivImage.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage.clipsToBounds = true;
        _ivImage.widthHeight = XY(W(89),W(89));
    }
    return _ivImage;
}
- (UILabel *)labelTitleBottom{
    if (!_labelTitleBottom) {
        _labelTitleBottom = [UILabel new];
        _labelTitleBottom.textColor = COLOR_SUBTITLE;
        _labelTitleBottom.fontNum = F(13);
        _labelTitleBottom.numLimit = 4;
        _labelTitleBottom.backgroundColor = [UIColor clearColor];
        _labelTitleBottom.hidden = true;
    }
    return _labelTitleBottom;
}
#pragma mark 获取高度
+ (CGSize)fetchHeight{
    static CollectionImageCell * cell;
    if (cell == nil) {
        cell = [self new];
    }
    return [cell resetCellWithModel:nil];
}
+ (CGSize)fetchHeightWithTitle{
    static CollectionImageCell * cell;
    if (cell == nil) {
        cell = [self new];
    }
    cell.isShowTitleBottom = true;
    return [cell resetCellWithModel:nil];
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.ivImage];
        [self.contentView addSubview:self.btnDelete];
        [self.contentView addSubview:self.labelTitleBottom];
    }
    return self;
}


#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model{
    //iv
    self.ivImage.centerXTop = XY(self.width/2.0,0);
    [self.ivImage sd_setImageWithModel:model placeholderImageName:IMAGE_BIG_DEFAULT];
    //label bottom
    [self.labelTitleBottom fitTitle:UnPackStr(model.desc) variable:0];
    self.labelTitleBottom.centerXTop = XY(self.ivImage.centerX, self.ivImage.bottom + W(5));
    self.labelTitleBottom.hidden = !self.isShowTitleBottom;
    //btn delete
    self.btnDelete.centerXCenterY = XY(self.ivImage.right,self.ivImage.top);
    return CGSizeMake(self.ivImage.width, self.ivImage.height+(self.isShowTitleBottom?self.labelTitleBottom.bottom - self.ivImage.bottom:0));
}
//照相机 cell
- (void)resetCellWithCamera{
    [self resetCellWithModel:^(){
        ModelImage * model = [ModelImage new];
        model.desc = @"添加";
        return model;
    }()];
    self.ivImage.image = [UIImage imageNamed:@"whistle_add"];
}

#pragma mark 点击事件
- (void)btnClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://删除
        {
            if (self.blockDelete) {
                self.blockDelete(self);
            }
        }
            break;
        default:
            break;
    }
}


@end



