//
//  HEBServiceViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBWKWebViewController.h"
#import "HEBWKWebView.h"

@interface HEBWKWebViewController ()<WKNavigationDelegate>

/** 协议视图 */
@property(nonatomic, strong) HEBWKWebView *wkWebView;

@end

@implementation HEBWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    HEBWKWebView *wkWebView = [[HEBWKWebView alloc] init];
    selfClass(wkWebView);
    wkWebView.webView.navigationDelegate = self;
    [self.baseView addSubview:wkWebView];
    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
     [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:self.url params:nil callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        if (mainModel.status) {
            [weakSelf.wkWebView.webView loadHTMLString:mainModel.data[@"content"] baseURL:[NSURL URLWithString:BASEURLHOST]];
        }
    }];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    [self.progressHUD showAnimated:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self dismissProgressHUD];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self dismissProgressHUD];
    [webView reload];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
