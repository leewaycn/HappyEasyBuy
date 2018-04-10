//
//  HEBServiceProtocolView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/7.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBWKWebView.h"

@implementation HEBWKWebView

- (void)loadView {
    WKWebView *webView = [[WKWebView alloc] init];
    webView.dividingLine = YES;
    selfClass(webView);
    [self addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
