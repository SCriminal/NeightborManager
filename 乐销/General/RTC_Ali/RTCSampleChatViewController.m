//
//  RTCSampleChatViewController.m
//  RtcSample
//
//  Created by daijian on 2019/2/27.
//  Copyright © 2019年 tiantian. All rights reserved.
//

#import "RTCSampleChatViewController.h"
#import "NSDate+YYAdd.h"

#define RTCREMOTE_CELL_SIZE CGSizeMake(W(110), W(160))


#if !(TARGET_IPHONE_SIMULATOR)
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+RTCSampleAlert.h"
#import "RTCSampleRemoteUserManager.h"
#import "RTCSampleRemoteUserModel.h"

@interface RTCSampleChatViewController ()<AliRtcEngineDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 @brief SDK实例
 */
@property (nonatomic, strong) AliRtcEngine *engine;
@property (nonatomic, strong) AliRenderView *viewLocal;

/**
 @brief 远端用户管理
 */
@property(nonatomic, strong) RTCSampleRemoteUserManager *remoteUserManager;

/**
 @brief 远端用户视图
 */
@property(nonatomic, strong) UICollectionView *remoteUserView;

/**
 @brief 是否入会
 */
@property(nonatomic, assign) BOOL isJoinChannel;

@property (nonatomic, strong) NSString * uidReplace;
@property (nonatomic, strong) UILabel *connecting;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) double timeReference;

@end

@implementation RTCSampleChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //导航栏名称等基本设置
    self.view.backgroundColor = [UIColor grayColor];
    
    //初始化SDK内容
    [self initializeSDK];
    
    //开启本地预览
    [self startPreview];
    
    //加入房间
    [self joinBegin];
    
    //添加页面控件
    [self addSubviews];
    
}

#pragma mark - initializeSDK
/**
 @brief 初始化SDK
 */
- (void)initializeSDK{
    // 创建SDK实例，注册delegate，extras可以为空
    [AliRtcEngine setH5CompatibleMode:true];
    _engine = [AliRtcEngine sharedInstance:self extras:@""];
    [_engine enableSpeakerphone:true];
}

- (void)startPreview{
    // 设置本地预览视频
    AliVideoCanvas *canvas   = [[AliVideoCanvas alloc] init];
    AliRenderView *viewLocal = [[AliRenderView alloc] initWithFrame:self.view.bounds];
    canvas.view = viewLocal;
    canvas.renderMode = AliRtcRenderModeAuto;
    self.viewLocal = viewLocal;
    [self.view addSubview:viewLocal];
    [self.engine setLocalViewConfig:canvas forTrack:AliRtcVideoTrackCamera];
    // 开启本地预览
    [self.engine startPreview];
}

#pragma mark - action (需手动填写鉴权信息)
/**
 @brief 登陆服务器，并开始推流
 */
- (void)joinBegin{
    //AliRtcAuthInfo 配置项
    
    NSString *AppID   =  self.model.appID;
    NSString *userID  =  self.model.userId;
    NSString *channelID  =  self.model.channelId;
    NSString *nonce  =  self.model.nonce;
    long long timestamp = self.model.timeStamp.longLongValue;
    NSString *token  =  self.model.token;
    NSArray <NSString *> *GSLB  =  self.model.gSLB;
    NSArray <NSString *> *agent =  @[@"agent"];
    
    //配置SDK
    //设置自动(手动)模式
    [self.engine setAutoPublish:YES withAutoSubscribe:YES];
    
    //随机生成用户名，仅是demo展示使用
    NSString *userName = [NSString stringWithFormat:@"%@",[GlobalData sharedInstance].GB_UserModel.account];
    
    //AliRtcAuthInfo:各项参数均需要客户App Server(客户的server端) 通过OpenAPI来获取，然后App Server下发至客户端，客户端将各项参数赋值后，即可joinChannel
    AliRtcAuthInfo *authInfo = [[AliRtcAuthInfo alloc] init];
    authInfo.appid = AppID;
    authInfo.user_id = userID;
    authInfo.channel = channelID;
    authInfo.nonce = nonce;
    authInfo.timestamp = timestamp;
    authInfo.token = token;
    authInfo.gslb = GSLB;
    authInfo.agent = agent;
    
    //加入频道
    [self.engine joinChannel:authInfo name:userName onResult:^(NSInteger errCode) {
        //加入频道回调处理
        NSLog(@"joinChannel result: %d", (int)errCode);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (errCode != 0) {
                //入会失败
            }
            _isJoinChannel = YES;
        });
    }];
    
    //防止屏幕锁定
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

#pragma mark - private

/**
 @brief 离开频需要取消本地预览、离开频道、销毁SDK
 */
- (void)leaveChannel {
    
    [self timerStop];
    
    [self.remoteUserManager removeAllUser];
    
    //停止本地预览
    [self.engine stopPreview];
            
    [self.engine leaveChannel];
    
    [self.remoteUserView removeFromSuperview];
    
    //销毁SDK实例
    [AliRtcEngine destroy];
    
    [GB_Nav popViewControllerAnimated:false];
    
}


#pragma mark - uicollectionview delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.remoteUserManager allOnlineUsers].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTCRemoterUserView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    RTCSampleRemoteUserModel *model =  [self.remoteUserManager allOnlineUsers][indexPath.row];
    if ([model.uid isEqualToString:self.uidReplace]) {
        // 设置本地预览视频
        [self.viewLocal removeFromSuperview];
        [cell updateUserRenderview:self.viewLocal];
    }else {
        AliRenderView *view = model.view;
        [cell updateUserRenderview:view];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RTCSampleRemoteUserModel *model =  [self.remoteUserManager allOnlineUsers][indexPath.row];
    if ([self.uidReplace isEqualToString:model.uid]) {
        self.uidReplace = nil;
        [self.remoteUserView reloadData];
        
        [self.viewLocal removeFromSuperview];
        self.viewLocal.frame = self.view.bounds;
        [self.view insertSubview:self.viewLocal atIndex:0];
    }else {
        self.uidReplace = model.uid;
        [self.remoteUserView reloadData];
        [model.view removeFromSuperview];
        model.view.frame = self.view.bounds;
        [self.view insertSubview:model.view atIndex:0];
    }
    
    
}
//远端用户镜像按钮点击事件
- (void)switchClick:(BOOL)isOn track:(AliRtcVideoTrack)track uid:(NSString *)uid {
    AliVideoCanvas *canvas = [[AliVideoCanvas alloc] init];
    canvas.renderMode = AliRtcRenderModeFill;
    if (track == AliRtcVideoTrackCamera) {
        canvas.view = (AliRenderView *)[self.remoteUserManager cameraView:uid];
    }
    else if (track == AliRtcVideoTrackScreen) {
        canvas.view = (AliRenderView *)[self.remoteUserManager screenView:uid];
    }
    if (isOn) {
        canvas.mirrorMode = AliRtcRenderMirrorModeAllEnabled;
    }else{
        canvas.mirrorMode = AliRtcRenderMirrorModeAllDisabled;
    }
    [self.engine setRemoteViewConfig:canvas uid:uid forTrack:track];
}


#pragma mark - alirtcengine delegate

- (void)onSubscribeChangedNotify:(NSString *)uid audioTrack:(AliRtcAudioTrack)audioTrack videoTrack:(AliRtcVideoTrack)videoTrack {
    NSLog(@"sld onSubscribeChangedNotify");
    
    //收到远端订阅回调
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.remoteUserManager updateRemoteUser:uid forTrack:videoTrack];
        if (videoTrack == AliRtcVideoTrackCamera) {
            AliVideoCanvas *canvas = [[AliVideoCanvas alloc] init];
            canvas.renderMode = AliRtcRenderModeAuto;
            canvas.view = [self.remoteUserManager cameraView:uid];
            [self.engine setRemoteViewConfig:canvas uid:uid forTrack:AliRtcVideoTrackCamera];
        }else if (videoTrack == AliRtcVideoTrackScreen) {
            AliVideoCanvas *canvas2 = [[AliVideoCanvas alloc] init];
            canvas2.renderMode = AliRtcRenderModeAuto;
            canvas2.view = [self.remoteUserManager screenView:uid];
            [self.engine setRemoteViewConfig:canvas2 uid:uid forTrack:AliRtcVideoTrackScreen];
        }else if (videoTrack == AliRtcVideoTrackBoth) {
            
            AliVideoCanvas *canvas = [[AliVideoCanvas alloc] init];
            canvas.renderMode = AliRtcRenderModeAuto;
            canvas.view = [self.remoteUserManager cameraView:uid];
            [self.engine setRemoteViewConfig:canvas uid:uid forTrack:AliRtcVideoTrackCamera];
            
            AliVideoCanvas *canvas2 = [[AliVideoCanvas alloc] init];
            canvas2.renderMode = AliRtcRenderModeAuto;
            canvas2.view = [self.remoteUserManager screenView:uid];
            [self.engine setRemoteViewConfig:canvas2 uid:uid forTrack:AliRtcVideoTrackScreen];
        }
        [self.remoteUserView reloadData];
        
    });
}

- (void)onRemoteUserOnLineNotify:(NSString *)uid {
    NSLog(@"sld onRemoteUserOnLineNotify");
}

- (void)onRemoteUserOffLineNotify:(NSString *)uid {
    NSLog(@"sld onRemoteUserOffLineNotify");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.remoteUserManager remoteUserOffLine:uid];
        if ([self.remoteUserManager allOnlineUsers].count <= 0) {
            [self leaveChannel];
        }else {
            if ([uid isEqualToString:self.uidReplace]) {
                       self.uidReplace = nil;
                       [self startPreview];
                   }
                   [self.remoteUserView reloadData];
        }
    });
}

- (void)onFirstPacketReceivedWithAudioTrack:(AliRtcAudioTrack)audioTrack videoTrack:(AliRtcVideoTrack)videoTrack{
    if (!self.timeReference) {
        [self timerStart];
    }
    RTCSampleRemoteUserModel *model =  [self.remoteUserManager allOnlineUsers].lastObject;
    if (self.uidReplace == nil && model.view) {
        [GlobalMethod mainQueueBlock:^{
            self.uidReplace = model.uid;
            [self.remoteUserView reloadData];
            [model.view removeFromSuperview];
            model.view.frame = self.view.bounds;
            [self.view insertSubview:model.view atIndex:0];
        }];
    }
}

- (void)onOccurError:(int)error {
    NSLog(@"sld onOccurError");
    [self showAlertWithMessage:@"视频出错，请重新开启" handler:^(UIAlertAction * _Nonnull action) {
        [self leaveChannel];
    }];
    
}

- (void)onBye:(int)code {
    if (code == AliRtcOnByeChannelTerminated) {
        // channel结束
        [self showAlertWithMessage:@"视频结束" handler:^(UIAlertAction * _Nonnull action) {
            [self leaveChannel];
        }];
    }
}

#pragma mark - add subviews

- (void)addSubviews {
    {
        UIButton *btnRefuse = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnRefuse addTarget:self action:@selector(leaveChannel) forControlEvents:UIControlEventTouchUpInside];
        btnRefuse.backgroundColor = [UIColor clearColor];
        btnRefuse.widthHeight = XY(W(65),W(65));
        [btnRefuse setBackgroundImage:[UIImage imageNamed:@"rtc_refuse"] forState:UIControlStateNormal];
        btnRefuse.centerXBottom = XY(SCREEN_WIDTH/2.0, SCREEN_HEIGHT - iphoneXBottomInterval - W(64));
        [self.view addSubview:btnRefuse];
        
        UILabel *refuse = [UILabel new];
        refuse.textColor = [UIColor whiteColor];
        refuse.font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [refuse fitTitle:@"挂断" variable:0];
        refuse.centerXTop = XY(btnRefuse.centerX, btnRefuse.bottom + W(15));
        [self.view addSubview:refuse];
        
        UILabel * l = [UILabel new];
        l.font = [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        l.textColor = [UIColor whiteColor];
        l.backgroundColor = [UIColor clearColor];
        l.numberOfLines = 0;
        l.lineSpace = W(0);
        [l fitTitle:@"正在连接中" variable:SCREEN_WIDTH - W(30)];
        l.centerXBottom = XY(SCREEN_WIDTH/2.0, btnRefuse.top - W(20));
        self.connecting = l;
        [self.view addSubview:l];
    }
    
    {
        UIButton *btnSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnSwitch addTarget:self action:@selector(btnSwitchClick) forControlEvents:UIControlEventTouchUpInside];
        btnSwitch.backgroundColor = [UIColor clearColor];
        btnSwitch.widthHeight = XY(W(65),W(65));
        [btnSwitch setBackgroundImage:[UIImage imageNamed:@"rtc_revolve"] forState:UIControlStateNormal];
        btnSwitch.rightBottom = XY(SCREEN_WIDTH-W(30), SCREEN_HEIGHT - iphoneXBottomInterval - W(64));
        [self.view addSubview:btnSwitch];
        
        UILabel *s = [UILabel new];
        s .textColor = [UIColor whiteColor];
        s .font =  [UIFont systemFontOfSize:F(14) weight:UIFontWeightRegular];
        [s  fitTitle:@"切换摄像头" variable:0];
        s.centerXTop = XY(btnSwitch.centerX, btnSwitch.bottom + W(15));
        [self.view addSubview:s];
    }
    
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = RTCREMOTE_CELL_SIZE;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.remoteUserView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.remoteUserView.frame = CGRectMake(0, STATUSBAR_HEIGHT + W(30), SCREEN_WIDTH, RTCREMOTE_CELL_SIZE.height);
    self.remoteUserView.contentInset = UIEdgeInsetsMake(0, W(10), 0, W(10));
    self.remoteUserView.backgroundColor = [UIColor clearColor];
    self.remoteUserView.delegate   = self;
    self.remoteUserView.dataSource = self;
    self.remoteUserView.showsHorizontalScrollIndicator = NO;
    [self.remoteUserView registerClass:[RTCRemoterUserView class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.remoteUserView];
    if (@available(iOS 9.0, *)) {
        self.remoteUserView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    }
    _remoteUserManager = [RTCSampleRemoteUserManager shareManager];
    
}

#pragma mark timer
- (void)timerStart{
    //开启定时器
    if (_timer == nil) {
        [GlobalMethod mainQueueBlock:^{
            self.timeReference = [NSDate timeIntervalSinceReferenceDate];
            _timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        }];
    }
}

- (void)timerRun{
    [GlobalMethod mainQueueBlock:^{
        double timeInterval = ([NSDate timeIntervalSinceReferenceDate]-self.timeReference);
        int min = timeInterval/60;
        int sec = ((long) timeInterval)%60;
        [self.connecting fitTitle:[NSString stringWithFormat:@"%02d:%02d",min,sec] variable:0];
        self.connecting.centerX = SCREEN_WIDTH/2.0;
    }];
}

- (void)timerStop{
    //停止定时器
    if (_timer != nil) {
        [_timer invalidate];
        self.timer = nil;
    }
}
#pragma mark click
- (void)btnSwitchClick{
    [self.engine switchCamera];
}
@end






@implementation RTCRemoterUserView
{
    AliRenderView *viewRemote;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //设置远端流界面
        CGRect rc  = CGRectMake(0, 0, RTCREMOTE_CELL_SIZE.width, RTCREMOTE_CELL_SIZE.height);
        viewRemote = [[AliRenderView alloc] initWithFrame:rc];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)updateUserRenderview:(AliRenderView *)view {
    view.backgroundColor = [UIColor clearColor];
    view.frame = CGRectMake(0, 0, RTCREMOTE_CELL_SIZE.width, RTCREMOTE_CELL_SIZE.height);
    viewRemote = view;
    [self addSubview:viewRemote];
}
@end


#else
@implementation RTCSampleChatViewController
@end
#endif
