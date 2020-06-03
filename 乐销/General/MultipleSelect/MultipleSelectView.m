//
//  MultipleSelectView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/11.
//Copyright © 2020 ping. All rights reserved.
//

#import "MultipleSelectView.h"

@interface MultipleSelectView ()

@end

@implementation MultipleSelectView

#pragma mark 刷新view
- (void)resetViewWith:(NSArray *)aryStrs{
    [self removeAllSubViews];
    CGFloat left = 0;
    for (int i =0; i<aryStrs.count; i++) {
        NSString * str = aryStrs[i];
        MultipleSelectItemView * itemView = [MultipleSelectItemView new];
        [itemView resetViewWithModel:str];
        itemView.left = left;
        left = itemView.right + W(25);
        itemView.tag = i;
        [itemView addTarget:self action:@selector(itemClick:)];
        [self addSubview:itemView];
        if (i == 0) {
            itemView.isSelected = true;
        }
        self.height = itemView.height;
    }
    
    self.width = left;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
    }
    return self;
}

#pragma mark click
- (void)itemClick:(UITapGestureRecognizer *)ges{
    MultipleSelectItemView * item = (MultipleSelectItemView *)ges.view;
    if ([item isKindOfClass:MultipleSelectItemView.class]) {
        [self selectIndex:(int)item.tag];
    }
}
- (void)selectIndex:(int)index{
    for (MultipleSelectItemView * subView in self.subviews) {
        if ([subView isKindOfClass:MultipleSelectItemView.class]) {
            subView.isSelected = subView.tag == index;
        }
    }
    self.index = index;
    if (self.blockClick) {
        self.blockClick(index);
    }
}
@end


@implementation MultipleSelectItemView
#pragma mark 懒加载
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.font =  [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
        _title.textColor = COLOR_999;
        _title.numberOfLines = 1;
        _title.lineSpace = 0;
    }
    return _title;
}
- (UIImageView *)ivSelected{
    if (!_ivSelected) {
        _ivSelected = [UIImageView new];
        _ivSelected.image = [UIImage imageNamed:@"select_default"];
        _ivSelected.highlightedImage = [UIImage imageNamed:@"select_highlighted"];
        _ivSelected.widthHeight = XY(W(16), W(16));
    }
    return _ivSelected;
}
- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    [self reconfig];
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubView];

    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.title];
    [self addSubview:self.ivSelected];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(NSString *)title{
    
    self.height = W(25);
    self.ivSelected.centerY = self.height/2.0;
    [self.title fitTitle:title variable:0];
    self.title.leftCenterY = XY(self.ivSelected.right +W(4.5), self.ivSelected.centerY) ;
    self.width = self.title.right;


    [self reconfig];
}

- (void)reconfig{
    self.ivSelected.highlighted = self.isSelected;

}
@end
