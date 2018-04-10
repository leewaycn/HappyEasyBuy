//
//  HEBBaseViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBBaseViewController.h"
#import <IQKeyboardManager.h>
#import <JPFPSStatus.h>

@interface HEBBaseViewController ()

@end

@implementation HEBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMemoryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    if (IS_DEBUG)[[JPFPSStatus sharedInstance] open];
    [self setUI];
    HEBBaseNavigationController *navController = (HEBBaseNavigationController *)self.navigationController;
    if ([navController screenEdgePanGestureRecognizer]) {
        [self.baseView.panGestureRecognizer requireGestureRecognizerToFail:[navController screenEdgePanGestureRecognizer]];
    }
}

- (void)setUI {
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
    if ([self isKindOfClass:objc_getClass("HEBLocalLifeViewController")] ||
        [self isKindOfClass:objc_getClass("HEBMyCenterViewController")]) {
        self.navigationController.navigationBar.barTintColor = BASECOLOR;
        [self.navigationController.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:objc_getClass("_UIBarBackground")]) {
                obj.backgroundColor = BASECOLOR;
            }
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}



- (void)dealloc {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if( self.view.window == nil && [self isViewLoaded]) {
        self.view = nil;
    }
}

- (void)handleMemoryWarning {
    if( self.view.window == nil && [self isViewLoaded]) {
        self.view = nil;
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIScrollView *)baseView {
    if (!_baseView) {
        _baseView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _baseView.backgroundColor = self.view.backgroundColor;
        _baseView.showsHorizontalScrollIndicator = NO;
        _baseView.showsVerticalScrollIndicator = NO;
        _baseView.alwaysBounceVertical = YES;
        _baseView.scrollEnabled = NO;
        [self.view addSubview:self.baseView];
        [self.view sendSubviewToBack:_baseView];
    }
    return _baseView;
}

- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _progressHUD;
}

- (void)dismissProgressHUD {
    [self.progressHUD hideAnimated:YES];
    self.progressHUD = nil;
}

- (void)setNavigationBarTransparence {
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏"] forBarMetrics:UIBarMetricsDefault];
}

@end

