//
//  HEBIndentViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBIndentViewController.h"
#import "HEBIndentView.h"

@interface HEBIndentViewController ()

@end

@implementation HEBIndentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"金融订单";
}

- (void)setUI {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
