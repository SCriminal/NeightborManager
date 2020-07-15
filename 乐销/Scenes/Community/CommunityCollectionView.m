//
//  CommunityCollectionView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/7.
//Copyright © 2020 ping. All rights reserved.
//

#import "CommunityCollectionView.h"
#import "DevelopVC.h"
@interface CommunityCollectionView ()

@end

@implementation CommunityCollectionView

#pragma mark 懒加载

- (NSMutableArray *)aryModel{
    if (!_aryModel) {
        _aryModel = [NSMutableArray array];
    }
    return _aryModel;
}
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = [CommunityCollectionCell fetchHeight:[ModelBtn new]];
    }
    return _cellHeight;
}

#pragma mark-----  设置collectionview
- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = 1;
        layout.sectionInset = UIEdgeInsetsMake(1, W(4), 0, W(4));
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-W(8)) / 4 - 1 , self.cellHeight);
        
        //设定滚动方向，有UICollectionViewScrollDirectionVertical和UICollectionViewScrollDirectionHorizontal两个值。
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 6.创建UICollectionView
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _myCollectionView.collectionViewLayout = layout;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        // 9.注册cell(告诉collectionView将来创建怎样的cell)
        [_myCollectionView registerClass:[CommunityCollectionCell class] forCellWithReuseIdentifier:@"CommunityCollectionCell"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
            
    }
    return _myCollectionView;
}

#pragma mark - UICollectionView数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.aryModel.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    ModelBaseData * model = self.aryModel[section];
    return model.aryDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.获得cell
    
    CommunityCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommunityCollectionCell" forIndexPath:indexPath];
    ModelBaseData * modelSection = self.aryModel[indexPath.section];
    ModelBtn * model = modelSection.aryDatas[indexPath.row];
    [cell resetCellWithModel:model];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelBaseData * modelSection = self.aryModel[indexPath.section];
    ModelBtn * model = modelSection.aryDatas[indexPath.row];
    if (model.blockClick ) {
        if (model.tag) {
            model.blockClick();

        }else{
            [GlobalMethod judgeLoginState:^{
                model.blockClick();
            }];
        }
        
    }else{
        if (isStr(model.title)) {
            DevelopVC * vc = [DevelopVC new];
            vc.navTitle = model.title;
            [GB_Nav pushViewController:vc animated:true];
        }
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, W(47));
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        [view removeAllSubViews];
        ModelBaseData * modelSection = self.aryModel[indexPath.section];
        [view addSubview:^(){
            UILabel * l = [UILabel new];
            l.font = [UIFont systemFontOfSize:F(17) weight:UIFontWeightMedium];
            l.textColor = COLOR_333;
            l.backgroundColor = [UIColor clearColor];
            [l fitTitle:modelSection.string variable:SCREEN_WIDTH - W(30)];
            l.leftCenterY = XY(W(20), W(47)/2.0);
            return l;
        }()];
        return view;
    }
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
    [view  addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) color:COLOR_BACKGROUND];
    return view;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.myCollectionView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark reset view
- (void)resetWithAry:(NSMutableArray *)ary{
    self.aryModel = ary;
    int numLine = 0;
    for (ModelBaseData * item in self.aryModel) {
        numLine += (int)(item.aryDatas.count/4+(item.aryDatas.count%4==0?0:1));
    }
     
    self.width = SCREEN_WIDTH;
    self.height = (self.cellHeight+1)*numLine + W(49)*ary.count;
    
    self.myCollectionView.height = self.height;
    self.myCollectionView.width = SCREEN_WIDTH ;
    [self.myCollectionView reloadData];
}
@end



@implementation CommunityCollectionCell
#pragma mark 懒加载

- (UIImageView *)iconImg{
    if (_iconImg == nil) {
        _iconImg = [UIImageView new];
    }
    return _iconImg;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.fontNum = F(12);
        _nameLabel.textColor = [UIColor colorWithHexString:@"717273"];
    }
    return _nameLabel;
}
#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    //刷新view
    self.iconImg.widthHeight = XY(W(74),W(74));
    self.iconImg.centerXTop = XY(self.contentView.width / 2,W(0));
    
    //设置图片
    //    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:model.imageName] placeholderImage:[UIImage imageNamed:@"community_collection_home"]];
    self.iconImg.image = [UIImage imageNamed:model.imageName];
    //没有则不显示
    if (model.title.length == 0) {
        self.iconImg.image = nil;
    }
    [self.nameLabel  fitTitle:model.title  variable:0];
    self.nameLabel.centerXTop = XY(self.iconImg.centerX,W(70) + self.iconImg.top);
    
    self.height = self.nameLabel.bottom + W(15);
    
    
}


@end
