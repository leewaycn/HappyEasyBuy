//
//  HEBMerchantViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBMerchantViewController.h"
#import "HEBMerChantView.h"

@interface HEBMerchantViewController ()

@end

@implementation HEBMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家入驻";
}

- (void)setUI {
    HEBMerChantView *merchantView = [[HEBMerChantView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.baseView addSubview:merchantView];
    [merchantView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}
    
@end
