//
//  BPViewController.m
//  家有宝贝
//
//  Created by wuli萍萍 on 16/5/21.
//  Copyright © 2016年 wuli萍萍. All rights reserved.
//

#import "CustomTabBarController.h"
#import "CustomTabBar.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉分割线
    GB_Nav.navigationBar.shadowImage = [UIImage new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.view setBackgroundColor:COLOR_BACKGROUND];
    // 添加子控制器
    [self setUpChildVC:[NSClassFromString(@"CommunityVC") new] title:@"主页" image:@"tab_community_default" selectedImage:@"tab_community_selected"];
    [self setUpChildVC:[NSClassFromString(@"PersonalCenterVC") new] title:@"我的" image:@"tab_mine_default" selectedImage:@"tab_mine_selected"];

    CustomTabBar *tabBar = [[CustomTabBar alloc] init];
       //针对ios13 进行设置
       if (@available(iOS 13.0, *)) {
           UITabBarAppearance *appearance = [tabBar.standardAppearance copy];
           appearance.stackedLayoutAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName : COLOR_BLUE ,NSFontAttributeName:[UIFont systemFontOfSize:F(10)]};
           appearance.stackedLayoutAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName :  [UIColor colorWithHexString:@"757F84"],NSFontAttributeName:[UIFont systemFontOfSize:F(10)]};
           appearance.backgroundImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)];
           appearance.shadowColor = [UIColor whiteColor];
           tabBar.standardAppearance = appearance;
       } else {
           [[CustomTabBar appearance]setBackgroundColor:[UIColor whiteColor]];
           [[CustomTabBar appearance]setShadowImage:[UIImage new]];//将TabBar上的黑线去掉
           [[CustomTabBar appearance]setBackgroundImage:[UIImage new]];
       }
    // 设置代理
    tabBar.delegate = self;
    [self setValue:tabBar forKey:@"tabBar"];
    [self setupTabBar];
}

- (void)setupTabBar{
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    //[self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.opaque = YES;
}

#pragma mark ---- 初始化子控制器
- (void)setUpChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.title = title;
    
    vc.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 禁用图片渲染
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置字体和图片的距离
    [self configTabbarImageAndTitle:vc];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    [self addChildViewController:vc];
}

- (void)configTabbarImageAndTitle:(UIViewController *)vc{
    //设置字体和图片的距离
    CGFloat spaceTop;
    CGFloat imageTop;
    CGFloat fontSize;
    if (SCREEN_WIDTH == 320) {
        imageTop = 0;
        fontSize = 9;
        spaceTop = -6;
    }else if (SCREEN_WIDTH == 375){
        imageTop = 0;
        fontSize = 11;
        spaceTop = -3;
    }else if (SCREEN_WIDTH == 414){
        imageTop = 0;
        fontSize = 12;
        spaceTop = -7;
    }else{
        imageTop = 0;
        fontSize = 11;
        spaceTop = -7;
    }
    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(imageTop,0, -imageTop, 0)];
    
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, spaceTop)];
    
    // 设置文字的样式
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName :  [UIColor colorWithHexString:@"757F84"],NSFontAttributeName:[UIFont systemFontOfSize:F(10)]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_BLUE ,NSFontAttributeName:[UIFont systemFontOfSize:F(10)]} forState:UIControlStateSelected];
}

- (void)viewWillLayoutSubviews
{
    CGFloat tabberHeight = TABBAR_HEIGHT;
    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
    tabFrame.size.height = tabberHeight;
    tabFrame.origin.y = self.view.frame.size.height - tabberHeight;
    self.tabBar.frame = tabFrame;
}

#pragma mark tabbarVC delegate
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    /*
    if ([viewController isKindOfClass:MarketVC.class]) {
        MarketVC * vcCurrent = [self.viewControllers objectAtIndex:self.selectedIndex];
        if ([vcCurrent isKindOfClass:MarketVC.class]) {
            [vcCurrent quickClick];
        }else{
            viewController.tabBarItem.image = [[UIImage imageNamed:@"market_publish"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            // 禁用图片渲染
            viewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"market_publish"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(W(4),0, -W(4), 0)];
            viewController.title = nil;
        }
    }else{
        if (self.viewControllers.count > 2) {
            MarketVC * vc = [self.viewControllers objectAtIndex:2];
            if ([vc isKindOfClass:MarketVC.class]) {
                vc.title = @"集市";
                vc.tabBarItem.image = [[UIImage imageNamed:@"bazaar-normal"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                // 禁用图片渲染
                vc.tabBarItem.selectedImage = [[UIImage imageNamed:@"bazaar-active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                //设置字体和图片的距离
                [self configTabbarImageAndTitle:vc];
            }
        }
    }
     */
    return true;
}



@end
