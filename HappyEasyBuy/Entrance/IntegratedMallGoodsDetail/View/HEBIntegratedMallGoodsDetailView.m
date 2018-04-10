//
//  HEBIntegratedMallGoodsDetailView.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/16.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIntegratedMallGoodsDetailView.h"
#import <WebKit/WebKit.h>


@interface HEBIntegratedMallGoodsDetailView ()<QMUITableViewDelegate, QMUITableViewDataSource, WKNavigationDelegate>

@property(nonatomic, assign) CGFloat height;

@end

@implementation HEBIntegratedMallGoodsDetailView

- (void)loadView {
    self.dataSource = self;
    self.delegate = self;
    HEBIntegratedMallGoodsDetailHeaderView *headerView = [[HEBIntegratedMallGoodsDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.4)];
    selfClass(headerView);
    self.tableHeaderView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row==0?33:indexPath.row==1?33:indexPath.row==2?self.height:33;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    QMUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[QMUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while (cell.contentView.subviews.lastObject) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
    }
    cell.bottomLine = YES;
    cell.userInteractionEnabled = NO;
    cell.textLabel.text = nil;
    cell.textLabel.textColor = BASEBLACK;
    if (indexPath.row == 0) {
        YYTextSimpleEmoticonParser *integralDetailParser = [[YYTextSimpleEmoticonParser alloc] init];
        integralDetailParser.emoticonMapper = @{@"integralDetail":UIImageMake(@"积分商城_商品详情")};
        YYLabel *integralDetail = [[YYLabel alloc] init];
        integralDetail.font = UIFontMake(14);
        integralDetail.textColor = BASECOLOR;
        integralDetail.textParser = integralDetailParser;
        integralDetail.text = @"integralDetail 商品详情";
        [cell.contentView addSubview:integralDetail];
        [integralDetail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView.mas_centerY);
            make.left.equalTo(cell.contentView.mas_left).offset(15);
        }];
    }else if (indexPath.row == 1) {
        cell.textLabel.text = self.model.model?[NSString stringWithFormat:@"%@ %@", self.model.brand_name, self.model.name]:self.model.name;
    }else if (indexPath.row == 2) {
        WKWebView *webView = [[WKWebView alloc] init];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.content]]];
        webView.navigationDelegate = self;
        [cell.contentView addSubview:webView];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell);
        }];
    }else {
        if (self.model) {
            cell.textLabel.text = self.model.model?[NSString stringWithFormat:@"价值: %@", self.model.price_origin]:[NSString stringWithFormat:@"有效期: %@天", self.model.effective];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.viewControl.progressHUD showAnimated:YES];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (!self.height) {
        __weak __typeof(self)weakSelf = self;
        [webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id data, NSError * _Nullable error) {
            weakSelf.height = [data floatValue];
            [weakSelf reloadRow:2 inSection:0 withRowAnimation:UITableViewRowAnimationNone];
        }];
    }else {
        [self.viewControl dismissProgressHUD];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.viewControl dismissProgressHUD];
}

@end

