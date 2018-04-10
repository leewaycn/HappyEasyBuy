//
//  HEBLenJoyViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/25.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLenJoyViewController.h"
#import "HEBLenJoyCharge.h"

@interface HEBLenJoyViewController ()

@end

@implementation HEBLenJoyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"乐享币充值";
    
}
#pragma mark - UI
- (void)setUI
{
    /** 顶部视图 */
    HEBLenJoyCharge *accountV = [[HEBLenJoyCharge alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    [self.baseView addSubview:accountV];
}


@end
