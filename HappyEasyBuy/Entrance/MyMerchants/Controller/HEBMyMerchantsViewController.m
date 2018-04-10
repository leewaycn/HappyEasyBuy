//
//  HEBMyMerchantsViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/27.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMyMerchantsViewController.h"
#import <WebKit/WebKit.h>

@interface HEBMyMerchantsViewController ()<WKNavigationDelegate>

@property(nonatomic, copy) NSString *url;

@end

@implementation HEBMyMerchantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录-后台管理";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithImage:[UIImageMake(@"浏览器") imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] tintColor:BASECOLOR position:QMUINavigationButtonPositionNone target:self action:@selector(rightBarButtonItemDidClick)];
}

- (void)setUI {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:Server params:@{@"vip_id":getUser_id} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        NSLog(@"%@", response);
        weakSelf.url = mainModel.data[@"url"];
        WKWebView *webView = [[WKWebView alloc] init];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mainModel.data[@"url"]]]];
        webView.navigationDelegate = self;
        [self.baseView addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.baseView.mas_top);
            make.left.right.bottom.equalTo(self.view);
        }];
    }];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self dismissProgressHUD];
}

- (void)rightBarButtonItemDidClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.url]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
