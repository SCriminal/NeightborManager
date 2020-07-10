//
//  CertificateDealImageView.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/5/25.
//Copyright © 2020 ping. All rights reserved.
//

#import "CertificateDealImageView.h"
//cell
#import "ImageDetailBigView.h"
@implementation CertificateDealImageView

#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(NSArray *)modelAry top:(CGFloat)top{
    [self removeAllSubViews];
    self.top = top;
    
    ModelQuestionnairDetailContent * modelFirst = modelAry.lastObject;
    
    
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(6);
    NSString * strTip = isStr(modelFirst.tip)?[NSString stringWithFormat:@"(%@)",modelFirst.tip]:@"";
    [l fitTitle:[NSString stringWithFormat:@"%@%@",modelFirst.name,strTip] variable:SCREEN_WIDTH - W(50)];
    l.leftTop = XY(W(25), 0);
    [self addSubview:l];
    
    if (modelFirst.isRequired) {
        UILabel *require = [UILabel new];
        require.textColor = [UIColor  redColor];
        require.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [require fitTitle:@"*" variable:0];
        require.rightTop = l.leftTop;
        [self addSubview:require];
    }
    
    
    top = l.bottom + W(28);
    CGFloat left = W(35);
    CGFloat bottom = 0;
    for (ModelQuestionnairDetailContent * modelItem in modelAry) {
        CertificateDealSingleImage * viewItem = [CertificateDealSingleImage new];
        viewItem.isParticipated = self.isParticipated;
        [viewItem resetViewWithModel:modelItem];
        viewItem.leftTop = XY(left, top);
        [self addSubview:viewItem];
        long index = [modelAry indexOfObject:modelItem];
        left = viewItem.right + W(13);
        if ((index+1)%3 == 0) {
            top  = viewItem.bottom + W(13);
            left = W(35);
        }
        bottom = viewItem.bottom;
    }
    
    UIView * viewBG = [UIView new];
    viewBG.backgroundColor = [UIColor whiteColor];
    viewBG.frame = CGRectMake(W(15), l.bottom + W(15), SCREEN_WIDTH - W(30), bottom + W(13) - l.bottom - W(15));
    [viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    [self insertSubview:viewBG atIndex:0];
    
    self.height = viewBG.bottom + W(20);
    return self.bottom;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
    }
    return self;
}


@end

@implementation CertificateDealSingleImage
#pragma mark 懒加载
- (UIImageView *)iv{
    if (_iv == nil) {
        _iv = [UIImageView new];
        _iv.image = [UIImage imageNamed:@"certificateDeal_add"];
        _iv.widthHeight = XY(W(93),W(93));
        [_iv addTarget:self action:@selector(ivClick)];
    }
    return _iv;
}
- (UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
        _title.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
        _title.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
    }
    return _title;
}
- (UILabel *)require{
    if (_require == nil) {
        _require = [UILabel new];
        _require.textColor = [UIColor  redColor];
        _require.font =  [UIFont systemFontOfSize:F(11) weight:UIFontWeightRegular];
        [_require fitTitle:@"*" variable:0];
    }
    return _require;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.widthHeight = XY(self.iv.width, self.iv.height);
        [self addSubView];
    }
    return self;
}
//添加subview
- (void)addSubView{
    [self addSubview:self.iv];
    [self addSubview:self.title];
    [self addSubview:self.require];
    
    //初始化页面
    [self resetViewWithModel:nil];
}

#pragma mark 刷新view
- (void)resetViewWithModel:(ModelQuestionnairDetailContent *)model{
    self.model = model;
    [self removeSubViewWithTag:TAG_LINE];//移除线
    //刷新view
    self.iv.image = [UIImage imageNamed:self.isParticipated?@"certificateDeal_empty":@"certificateDeal_add"];
    
    [self.title fitTitle:@"上传照片" variable:self.iv.width-W(8)];
    self.title.centerXTop = XY(self.iv.width/2.0,W(61));
    self.require.rightCenterY = XY(self.title.left-W(2),self.title.centerY);
    
    if (isStr(model.value)) {
        [self.iv sd_setImageWithURL:[NSURL URLWithString:model.value] placeholderImage:[UIImage imageNamed:IMAGE_BIG_DEFAULT]];
    }
    self.require.hidden = true;
    //    if (model.isRequired && !isStr(model.value)) {
    //        self.require.hidden = false;
    //    }
    self.title.hidden = isStr(model.value);
    
}

#pragma click
- (void)ivClick{
    [self showImageVC:1];
}
//选择图片
- (void)imageSelect:(BaseImage *)image{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_CERTIFICATE_DEAL;
    [[AliClient sharedInstance]updateImageAry:@[image] storageSuccess:^{
        
    } upSuccess:^{
        
    } fail:^{
        
    }];
    self.iv.image = image;
    self.require.hidden = true;
    self.title.hidden = true;
    self.model.value = image.imageURL;
}


@end



@implementation CertificateDealMultiImageView
#pragma mark 懒加载
- (NSMutableArray *)aryDatas {
    if (!_aryDatas) {
        _aryDatas = [NSMutableArray array];
    }
    return _aryDatas;
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        // 1.流水布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 1;
        layout.minimumLineSpacing = W(13);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        CGSize size = [self fetchCellSize];
        layout.itemSize = size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 6.创建UICollectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH- W(70), size.height) collectionViewLayout:layout];
        // 7.设置collectionView的背景色
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 8.设置代理
        _collectionView.collectionViewLayout = layout;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        [_collectionView registerClass:NSClassFromString(@"CollectionDealImageCell") forCellWithReuseIdentifier:@"CollectionDealImageCell"];
    }
    return _collectionView;
}

#pragma mark fetch cell size
- (CGSize)fetchCellSize{
    
    return [CollectionDealImageCell fetchHeight];
}
#pragma mark 刷新view
- (CGFloat)resetViewWithModel:(ModelQuestionnairDetailContent *)model top:(CGFloat)top{
    self.model = model;
    [self removeAllSubViews];
    self.top = top;
    
    
    
    UILabel * l = [UILabel new];
    l.font = [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
    l.textColor = COLOR_333;
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 0;
    l.lineSpace = W(6);
    NSString * strTip = isStr(model.tip)?[NSString stringWithFormat:@"(%@)",model.tip]:@"";
    
    [l fitTitle:[NSString stringWithFormat:@"%@%@",UnPackStr(model.name),strTip] variable:SCREEN_WIDTH - W(50)];
    l.leftTop = XY(W(25), 0);
    [self addSubview:l];
    
    if (model.isRequired) {
        UILabel *require = [UILabel new];
        require.textColor = [UIColor  redColor];
        require.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        [require fitTitle:@"*" variable:0];
        require.rightTop = l.leftTop;
        [self addSubview:require];
    }
    
    top = l.bottom + W(28);
    
    [self addSubview:self.collectionView];
    self.collectionView.leftTop = XY(W(35), top);
    
    
    UIView * viewBG = [UIView new];
    viewBG.backgroundColor = [UIColor whiteColor];
    viewBG.frame = CGRectMake(W(15), l.bottom + W(15), SCREEN_WIDTH - W(30), self.collectionView.height +W(26));
    [viewBG addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
    [self insertSubview:viewBG atIndex:0];
    
    self.height = viewBG.bottom + W(20);
    return self.bottom;
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//背景色
        self.width = SCREEN_WIDTH;//默认宽度
        self.isEditing = true;
    }
    return self;
}

#pragma mark - UICollectionView数据源方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.isEditing? self.aryDatas.count + 1:self.aryDatas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionDealImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionDealImageCell" forIndexPath:indexPath];
    if (self.isEditing && indexPath.row == 0) {
        [cell resetCellWithCamera];
        return cell;
    }
    [cell resetCellWithModel:self.aryDatas[self.isEditing?indexPath.row -1:indexPath.row]];
    return cell;
}
//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self fetchCellSize];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditing && indexPath.item == 0) {
        [self showSelectImage];
    } else {
        ImageDetailBigView * detailView = [ImageDetailBigView new];
        WEAKSELF
        detailView.blockRefresh = ^(void){
            [weakSelf exchangeModelValue];
            [weakSelf.collectionView reloadData];
        };
        
        [detailView resetView:self.aryDatas isEdit:self.isEditing index: self.isEditing?indexPath.row-1:indexPath.row];
        CollectionDealImageCell * cell = (CollectionDealImageCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [detailView showInView:GB_Nav.lastVC.view imageViewShow:cell.ivImage];
    }
}
- (void)showSelectImage{
    if (self.model.max == 0) {
        self.model.max = 20;
    }
    if (self.aryDatas.count>=self.model.max) {
        [GlobalMethod showAlert:[NSString stringWithFormat:@"最多%.f张，请先删除再添加",self.model.max]];
        return;
    }
    [self showImageVC:self.model.max-self.aryDatas.count];
}
#pragma mark 选择图片
- (void)imagesSelect:(NSArray *)aryImages
{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_CERTIFICATE_DEAL;
    
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        [self.aryDatas insertObject:modelImageInfo atIndex:0];
    }
    [self exchangeModelValue];
    [self.collectionView reloadData];
}
- (void)exchangeModelValue{
    NSMutableArray * ary = [NSMutableArray new];
    for (ModelImage * modelItem in self.aryDatas) {
        [ary addObject:^(){
            ModelQuestionnairDetailValues * model = [ModelQuestionnairDetailValues new];
            model.value = modelItem.url;
            return model;
        }()];
    }
    self.model.values = ary;
}
@end



@implementation CollectionDealImageCell
#pragma mark 懒加载
- (UIImageView *)ivImage{
    if (_ivImage == nil) {
        _ivImage = [UIImageView new];
        _ivImage.backgroundColor = [UIColor clearColor];
        _ivImage.image = nil;
        _ivImage.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage.clipsToBounds = true;
        _ivImage.widthHeight = XY(W(93),W(93));
    }
    return _ivImage;
}
#pragma mark 获取高度
+ (CGSize)fetchHeight{
    static CollectionDealImageCell * cell;
    if (cell == nil) {
        cell = [self new];
    }
    return [cell resetCellWithModel:nil];
}

#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.ivImage];
    }
    return self;
}


#pragma mark 刷新cell
- (CGSize)resetCellWithModel:(ModelImage *)model{
    //iv
    self.ivImage.centerXTop = XY(self.width/2.0,0);
    [self.ivImage sd_setImageWithModel:model placeholderImageName:IMAGE_BIG_DEFAULT];
    
    return CGSizeMake(self.ivImage.width, self.ivImage.height);
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



@end



