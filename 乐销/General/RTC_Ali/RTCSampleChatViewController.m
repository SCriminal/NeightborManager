//
//  RTCSampleChatViewController.m
//  RtcSample
//
//  Created by daijian on 2019/2/27.
//  Copyright © 2019年 tiantian. All rights reserved.
//

#import "RTCSampleChatViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIViewController+RTCSampleAlert.h"
#import "RTCSampleRemoteUserManager.h"
#import "RTCSampleRemoteUserModel.h"
#import "NSDate+YYAdd.h"

@interface RTCSampleChatViewController ()<AliRtcEngineDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 @brief SDK实例
 */
@property (nonatomic, strong) AliRtcEngine *engine;


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
    _engine = [AliRtcEngine sharedInstance:self extras:@""];
    [AliRtcEngine setH5CompatibleMode:true];
}

- (void)startPreview{
    // 设置本地预览视频
    AliVideoCanvas *canvas   = [[AliVideoCanvas alloc] init];
    AliRenderView *viewLocal = [[AliRenderView alloc] initWithFrame:self.view.bounds];
    canvas.view = viewLocal;
    canvas.renderMode = AliRtcRenderModeAuto;
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
    
//    NSString *AppID   =  @"phhs6mt3";
//    NSString *userID  =  @"4";
//    NSString *channelID  =  @"2";
//    NSString *nonce  =  @"AK-470f12b0-2597-46fa-a47d-cec564986f58";
//    long long timestamp = 1594689816;
//    NSString *token  =  @"08556d8cff08a0fc3ed3f122279914dde4c60ed4ccdb1c33d317dc796ccf9256";
//    NSArray <NSString *> *GSLB  =  @[@"https://rgslb.rtc.aliyuncs.com"];
//    NSArray <NSString *> *agent =  @[@"agent"];
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
    
    [self.remoteUserManager removeAllUser];
    
    //停止本地预览
    [self.engine stopPreview];
    
    if (_isJoinChannel) {
        //离开频道
        [self.engine leaveChannel];
    }
    
    [self.remoteUserView removeFromSuperview];
    
    //销毁SDK实例
    [AliRtcEngine destroy];
    
    [GB_Nav popViewControllerAnimated:false];

}

- (void)exitApplication{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.5f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(window.bounds.size.width/2.0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma mark - uicollectionview delegate & datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.remoteUserManager allOnlineUsers].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RTCRemoterUserView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    RTCSampleRemoteUserModel *model =  [self.remoteUserManager allOnlineUsers][indexPath.row];
    AliRenderView *view = model.view;
    [cell updateUserRenderview:view];
    
//    //记录UID
//    NSString *uid = model.uid;

    return cell;
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
    [GlobalMethod showAlert:@"sld onSubscribeChangedNotify"];
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
    [GlobalMethod showAlert:@"onRemoteUserOnLineNotify"];
    NSLog(@"sld onRemoteUserOnLineNotify");
}

- (void)onRemoteUserOffLineNotify:(NSString *)uid {
    [GlobalMethod showAlert:@"onRemoteUserOffLineNotify"];
    NSLog(@"sld onRemoteUserOffLineNotify");
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.remoteUserManager remoteUserOffLine:uid];
        [self.remoteUserView reloadData];
    });
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
    
    CGRect rcScreen = [UIScreen mainScreen].bounds;
    CGRect rc = rcScreen;
    rc.origin.x = 10;
    rc.origin.y = [UIApplication sharedApplication].statusBarFrame.size.height+20+44;
    rc.size = CGSizeMake(self.view.frame.size.width-20, 280);
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(140, 280);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.remoteUserView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.remoteUserView.frame = rc;
    self.remoteUserView.backgroundColor = [UIColor clearColor];
    self.remoteUserView.delegate   = self;
    self.remoteUserView.dataSource = self;
    self.remoteUserView.showsHorizontalScrollIndicator = NO;
    [self.remoteUserView registerClass:[RTCRemoterUserView class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.remoteUserView];
    
    _remoteUserManager = [RTCSampleRemoteUserManager shareManager];
    
}

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
        CGRect rc  = CGRectMake(0, 0, 140, 200);
        viewRemote = [[AliRenderView alloc] initWithFrame:rc];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)updateUserRenderview:(AliRenderView *)view {
    view.backgroundColor = [UIColor clearColor];
    view.frame = viewRemote.frame;
    viewRemote = view;
    [self addSubview:viewRemote];
}
@end
