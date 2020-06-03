//
//  WebInterActionVC.m
//  Neighbor
//
//  Created by 隋林栋 on 2020/3/15.
//Copyright © 2020 ping. All rights reserved.
//

#import "WebInterActionVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebInterActionVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webDetails;

@end

@implementation WebInterActionVC
- (NSString *)navTitle{
    if (!_navTitle) {
        _navTitle = @"网页";
    }
    return _navTitle;
}
#pragma mark lazy init

- (UIWebView *)webDetails{
    if (!_webDetails) {
        _webDetails = [UIWebView new];
        _webDetails.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT);
        _webDetails.delegate = self;
         if (@available(iOS 11.0, *)) {
                       _webDetails.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        JSContext *context=[_webDetails valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        context[@"jsToApp"] =^(){
            [GlobalMethod relogin];
        };
    }
    return _webDetails;
}

#pragma mark view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏
    [self addNav];
    [self.view addSubview:self.webDetails];
    
    [self loadUrl];

}

- (void)loadUrl{
    [self showLoadingView];
    [self.webDetails loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}
#pragma mark 添加导航栏
- (void)addNav{
    WEAKSELF
    BaseNavView * nav = [BaseNavView initNavBackWithTitle:self.navTitle rightImageName:@"nav_refresh" rightImageSize:CGSizeMake(W(25), W(25)) righBlock:^{
        [weakSelf loadUrl];
    }];
    nav.backgroundColor = COLOR_GRAY;
    [self.view addSubview:nav];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.loadingView hideLoading];

    ModelAddress * modelAddress = [GlobalMethod readModelForKey:LOCAL_LOCATION  modelName:@"ModelAddress" exchange:false];
    NSDictionary * dicCommunity = [[GlobalData sharedInstance].community dictionaryRepresentation];
    NSDictionary * dicJson = @{@"token":[GlobalData sharedInstance].GB_Key,@"areaInfo":dicCommunity,@"positionInfo":@{@"lng":NSNumber.dou(modelAddress.lng),@"lat":NSNumber.dou(modelAddress.lat)}};
    NSString * strJson = [GlobalMethod exchangeDicToJson:dicJson];
    [self.webDetails stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"appNativeCallToUser('%@')",[strJson base64Encode]]];
}


//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    NSLog(@"%@",request.URL.absoluteString);
//    if ([request.URL.absoluteString hasPrefix:@"jxaction://scan"]) {
//        //调用原生扫描二维码
//        return NO;
//    }
//    return YES;
//}
#pragma mark status bar
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
