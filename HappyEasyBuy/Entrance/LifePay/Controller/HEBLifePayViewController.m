//
//  HEBLifePayViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/17.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBLifePayViewController.h"

#import "HEBLifePayTabView.h"

@interface HEBLifePayViewController ()

@end

@implementation HEBLifePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - UI
- (void)setUI
{
    [self setTitle:@"生活缴费"];
    
    HEBLifePayTabView *tabV = [[HEBLifePayTabView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:tabV];
    
    /** 分组样式的顶部间距 */
    CGRect frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    tabV.tableHeaderView = [[UIView alloc]initWithFrame:frame];
}

@end
