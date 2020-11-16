//
//  DisposalWhistleVC.m
//  NeighborManager
//
//  Created by 隋林栋 on 2020/3/24.
//Copyright © 2020 ping. All rights reserved.
//

#import "DisposalWhistleVC.h"
#import "YellowButton.h"
#import "PlaceHolderTextView.h"
//request
#import "RequestApi+Neighbor.h"
#import "BaseVC+BaseImageSelectVC.h"
//上传图片
#import "AliClient.h"

@interface DisposalWhistleVC ()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) YellowButton *btn;
@property (nonatomic, strong) UILabel *result;
@property (nonatomic, strong) UILabel *imageAlert;
@property (nonatomic, strong) UIView *bg;
@property (nonatomic, strong) PlaceHolderTextView *textView;
@property (nonatomic, strong) NSMutableArray *aryDatas;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isEditing;


@end

@implementation DisposalWhistleVC
#pragma mark 懒加载
- (YellowButton *)btn{
    if (!_btn) {
        _btn = [YellowButton new];
        [_btn resetViewWithWidth:W(335) :W(45) :@"确认处理"];
        WEAKSELF
        _btn.blockClick = ^{
            [weakSelf requestDisposal];
        };
    }
    return _btn;
}
- (UILabel *)result{
    if (_result == nil) {
        _result = [UILabel new];
        _result.textColor = COLOR_333;
        _result.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _result.numberOfLines = 1;
        _result.lineSpace = 0;
        [_result fitTitle:@"处理结果" variable:0];
        
    }
    return _result;
}
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
        [_collectionView registerClass:NSClassFromString(@"CollectionDisposalImageCell") forCellWithReuseIdentifier:@"CollectionDisposalImageCell"];
    }
    return _collectionView;
}

#pragma mark fetch cell size
- (CGSize)fetchCellSize{
    
    return [CollectionDisposalImageCell fetchHeight];
}

- (UILabel *)imageAlert{
    if (_imageAlert == nil) {
        _imageAlert = [UILabel new];
        _imageAlert.textColor = COLOR_333;
        _imageAlert.font =  [UIFont systemFontOfSize:F(13) weight:UIFontWeightRegular];
        _imageAlert.numberOfLines = 1;
        _imageAlert.lineSpace = 0;
        [_imageAlert fitTitle:@"添加图片(可选)" variable:0];
        
    }
    return _imageAlert;
}

- (UIView *)bg{
    if (_bg == nil) {
        _bg = [UIView new];
        _bg.backgroundColor = [UIColor colorWithHexString:@"#FCFCFC"];
        _bg.widthHeight = XY(W(345), W(200));
        [_bg     addRoundCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft| UIRectCornerBottomRight radius:10 lineWidth:1 lineColor:[UIColor colorWithHexString:@"#EFF2F1"]];
        
        
    }
    return _bg;
}
- (PlaceHolderTextView *)textView{
    if (_textView == nil) {
        _textView = [PlaceHolderTextView new];
        _textView.backgroundColor = [UIColor clearColor];
        //        _textView.delegate = self;
        [GlobalMethod setLabel:_textView.placeHolder widthLimit:0 numLines:0 fontNum:F(15) textColor:COLOR_999 text:@"请填写处理信息结果"];
        [_textView setTextColor:COLOR_333];
        _textView.font = [UIFont systemFontOfSize:F(15) weight:UIFontWeightRegular];
    }
    return _textView;
}


#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    //添加subView
    [self.view addSubview:self.btn];
    [self.view addSubview:self.result];
    [self.view addSubview:self.bg];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.imageAlert];
    self.isEditing = true;
    [self.view addSubview:self.collectionView];

    //刷新view
    
    self.result.leftTop = XY(W(25),W(25)+NAVIGATIONBAR_HEIGHT);
    
    self.bg.leftTop = XY(W(15),self.result.bottom+W(15));
    self.textView.widthHeight = XY(self.bg.width - W(30),self.bg.height - W(30));
    self.textView.leftTop = XY( self.bg.left + W(15),self.bg.top+W(15));
    
    self.imageAlert.leftTop = XY(self.result.left, self.bg.bottom + W(15));
    self.collectionView.leftTop = XY(self.result.left, self.imageAlert.bottom + W(15));
    
    self.btn.centerXTop = XY(SCREEN_WIDTH/2.0,self.collectionView.bottom + W(35));
    [self.viewBG addTarget:self action:@selector(hideKeyboardClick)];
}
-(void)hideKeyboardClick{
    [GlobalMethod endEditing];
}
- (void)imageClick{
    [self showImageVC:1];

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
    CollectionDisposalImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionDisposalImageCell" forIndexPath:indexPath];
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
    }
}
- (void)showSelectImage{
   
    if (self.aryDatas.count>=3) {
        [GlobalMethod showAlert:@"最多3张，请先删除再添加"];
        return;
    }
    [self showImageVC:3-self.aryDatas.count];
}
#pragma mark 选择图片
- (void)imagesSelect:(NSArray *)aryImages
{
    [AliClient sharedInstance].imageType = ENUM_UP_IMAGE_TYPE_WHISTLE;
    
    [[AliClient sharedInstance]updateImageAry:aryImages  storageSuccess:nil upSuccess:nil fail:nil];
    for (BaseImage *image in aryImages) {
        ModelImage * modelImageInfo = [ModelImage new];
        modelImageInfo.url = image.imageURL;
        modelImageInfo.image = image;
        modelImageInfo.width = image.size.width;
        modelImageInfo.height = image.size.height;
        [self.aryDatas insertObject:modelImageInfo atIndex:0];
    }
    [self.collectionView reloadData];
}

#pragma mark 添加导航栏
- (void)addNav{
    [self.view addSubview:[BaseNavView initNavBackTitle:@"问题处理" rightView:nil]];
}
- (void)requestDisposal{
    if (!isStr(self.textView.text)) {
        [GlobalMethod showAlert:self.textView.placeHolder.text];
        return;
    }
    
    [RequestApi requestDisposalWhistleWithResult:self.textView.text areaId:0 id:self.model.iDProperty scope:nil scopeId:0 urls:[[self.aryDatas fetchValues:@"url"] componentsJoinedByString:@","] delegate:self success:^(NSDictionary * _Nonnull response, id  _Nonnull mark) {
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTICE_WHISTLE_REFERSH object:nil];
        self.requestState = 1;
        [GlobalMethod showAlert:@"处理成功"];
        [GB_Nav popViewControllerAnimated:true];
    } failure:^(NSString * _Nonnull errorStr, id  _Nonnull mark) {
        
    }];
}
@end


@implementation CollectionDisposalImageCell
#pragma mark 懒加载
- (UIImageView *)ivImage{
    if (_ivImage == nil) {
        _ivImage = [UIImageView new];
        _ivImage.backgroundColor = [UIColor clearColor];
        _ivImage.image = nil;
        _ivImage.contentMode = UIViewContentModeScaleAspectFill;
        _ivImage.clipsToBounds = true;
        _ivImage.widthHeight = XY(W(100),W(100));
    }
    return _ivImage;
}
#pragma mark 获取高度
+ (CGSize)fetchHeight{
    static CollectionDisposalImageCell * cell;
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
