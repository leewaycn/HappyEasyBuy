//
//  HEBOrderViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/11/14.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderViewController.h"
#import "HEBOrderView.h"

@interface HEBOrderViewController ()

@end

@implementation HEBOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    HEBOrderView *orderView = [[HEBOrderView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.baseView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-getTabBarHeight);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
