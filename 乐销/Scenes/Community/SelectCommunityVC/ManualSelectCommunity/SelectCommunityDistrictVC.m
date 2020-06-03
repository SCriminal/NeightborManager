//
//  SelectCommunityDistrictVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/23.
//Copyright © 2020 ping. All rights reserved.
//

#import "SelectCommunityDistrictVC.h"
#import "ManualSelectCommunityVC.h"
@interface SelectCommunityDistrictVC ()
@property (nonatomic, strong) UIImageView *BG;

@end

@implementation SelectCommunityDistrictVC
- (UIImageView *)BG{
    if (!_BG) {
        _BG = [UIImageView new];
        _BG.image = [UIImage imageNamed:@"select_community_BG"];
        _BG.contentMode = UIViewContentModeScaleAspectFill;
        _BG.clipsToBounds = true;
        _BG.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return _BG;
}
- (NSMutableArray *)aryModel{
    if (!_aryModel) {
        _aryModel = [NSMutableArray array];
    }
    return _aryModel;
}
- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = [SelectCommunityDistrictCollectionCell fetchHeight:[ModelBtn new]];
    }
    return _cellHeight;
}

#pragma mark-----  设置collectionview
- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = W(15);
        layout.minimumLineSpacing = W(15);
        layout.sectionInset = UIEdgeInsetsMake(W(23), W(20), W(23), W(20));
        layout.itemSize = CGSizeMake(W(101) , self.cellHeight);
        
        //设定滚动方向，有UICollectionViewScrollDirectionVertical和UICollectionViewScrollDirectionHorizontal两个值。
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 6.创建UICollectionView
        _myCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT- NAVIGATIONBAR_HEIGHT) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _myCollectionView.backgroundColor = [UIColor clearColor];
        // 8.设置代理
        _myCollectionView.collectionViewLayout = layout;
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        _myCollectionView.scrollEnabled = YES;
        _myCollectionView.showsVerticalScrollIndicator = false;
        // 9.注册cell(告诉collectionView将来创建怎样的cell)
        [_myCollectionView registerClass:[SelectCommunityDistrictCollectionCell class] forCellWithReuseIdentifier:@"SelectCommunityDistrictCollectionCell"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        [_myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        
    }
    return _myCollectionView;
}

#pragma mark - UICollectionView数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.aryModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 1.获得cell
    SelectCommunityDistrictCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCommunityDistrictCollectionCell" forIndexPath:indexPath];
    ModelBtn * model = self.aryModel[indexPath.row];
    [cell resetCellWithModel:model];
    return cell;
}

#pragma mark - 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ModelBtn * model = self.aryModel[indexPath.row];
    [GB_Nav pushVCName:@"ManualSelectCommunityVC" animated:true];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, CGFLOAT_MIN);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        return view;
    }
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot" forIndexPath:indexPath];
    [view  addLineFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1) color:COLOR_BACKGROUND];
    return view;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.BG];
    [self.view addSubview:self.myCollectionView];
    self.myCollectionView.widthHeight = XY(SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
    self.myCollectionView.top = NAVIGATIONBAR_HEIGHT;
    //添加导航栏
    [self addNav];
    //request
    [self requestList];
}

#pragma mark 添加导航栏
- (void)addNav{
    BaseNavView * nav = [BaseNavView initNavBackTitle:@"选择区/县" rightView:nil];
    nav.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nav];
}

#pragma mark request
- (void)requestList{
    self.aryModel = @[^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"奎文区";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"坊子区";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"潍城区";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"高新区";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"开发区";
        return model;
    }(),^(){
        ModelBtn * model = [ModelBtn new];
        model.title = @"寒亭区";
        return model;
    }()].mutableCopy;
    [self.myCollectionView reloadData];
}


@end


@implementation SelectCommunityDistrictCollectionCell
#pragma mark 懒加载



- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = ^(){
            UILabel * label = [UILabel new];
            label.backgroundColor = [UIColor colorWithHexString:@"#FFF4B6"];
            label.fontNum = F(14);
            label.textColor = COLOR_333;
            label.widthHeight = XY( W(101), W(37));
            label.textAlignment = NSTextAlignmentCenter;
            [label addRoundCorner:UIRectCornerAllCorners radius:5 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#D9D9D9"]];
            return label;
        }();
       
        
    }
    return _nameLabel;
}
#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}


#pragma mark 刷新cell
- (void)resetCellWithModel:(ModelBtn *)model{
    self.model = model;
    //刷新view
    self.nameLabel.text = model.title;
    self.height = self.nameLabel.height;
}


@end
