//
//  HEBBaseTabBarViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseTabBarViewController.h"
#import "HEBLocalLifeViewController.h"
#import "HEBVicinityViewController.h"
#import "HEBIntegratedMallViewController.h"
#import "HEBOrderViewController.h"
#import "HEBMyCenterViewController.h"

@interface HEBBaseTabBarViewController ()

@end

@implementation HEBBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[[HEBLocalLifeViewController alloc] init] title:@"本地生活"];
    
    [self addChildViewController:[[HEBVicinityViewController alloc] init] title:@"附近"];
    
    [self addChildViewController:[[HEBIntegratedMallViewController alloc] init] title:@"积分商城"];
    
    [self addChildViewController:[[HEBOrderViewController alloc] init] title:@"订单"];
    
    [self addChildViewController:[[HEBMyCenterViewController alloc] init] title:@"个人中心"];
    
}

- (void)addChildViewController:(HEBBaseViewController *)childViewController title:(NSString *)title {
    childViewController.tabBarItem.image = [UIImageMake(title) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSString *selectImgName = [NSString stringWithFormat:@"%@-active", title];
    childViewController.tabBarItem.selectedImage = [UIImageMake(selectImgName) imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    HEBBaseNavigationController *navigation = [[HEBBaseNavigationController alloc] initWithRootViewController:childViewController];
    childViewController.title = title;
    [self addChildViewController:navigation];
}

@end
