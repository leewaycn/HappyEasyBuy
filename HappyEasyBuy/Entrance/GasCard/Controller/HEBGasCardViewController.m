//
//  HEBGasCardViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBGasCardViewController.h"
#import "HEBGasCardTopView.h"
@interface HEBGasCardViewController ()

@end

@implementation HEBGasCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"加油卡充值";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)setUI
{
    HEBGasCardTopView *gasView = [[HEBGasCardTopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.baseView addSubview:gasView];
    
}

@end
