//
//  HEBAplyDrawViewController.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBAplyDrawViewController.h"

#import "HEBAplyDrawView.h"

@interface HEBAplyDrawViewController ()

@end

@implementation HEBAplyDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请提现";
    self.view.backgroundColor = UIColorHex(#f1f1f1);
}
#pragma mark - UI
- (void)setUI
{
    /** 顶部视图 */
    HEBAplyDrawView *applyV = [[HEBAplyDrawView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT )];
    [self.baseView addSubview:applyV];
    
}
#pragma mark - 导航栏颜色
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = BASECOLOR;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@", NSStringFromClass([obj class]));
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}


@end
