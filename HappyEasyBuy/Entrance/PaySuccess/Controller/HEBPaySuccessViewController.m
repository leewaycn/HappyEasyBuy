//
//  HEBPaySuccessViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2018/1/3.
//  Copyright © 2018年 happyEsayBuy. All rights reserved.
//

#import "HEBPaySuccessViewController.h"
#import "HEBPaySuccessView.h"

@interface HEBPaySuccessViewController ()

@end

@implementation HEBPaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付结果";
    self.navigationItem.rightBarButtonItem = [QMUINavigationButton barButtonItemWithType:0 title:@"完成" tintColor:UIColorBlack position:0 target:self action:@selector(rightBarButtonItemDidClick)];
    self.navigationItem.leftBarButtonItem = [QMUINavigationButton barButtonItemWithType:0 title:@"" tintColor:UIColorBlack position:0 target:nil action:nil];
}

- (void)setUI {
    HEBPaySuccessView *paySuccess = [[HEBPaySuccessView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    paySuccess.headerView.money.text = self.money;
    paySuccess.headerView.successImg.image = UIImageMake(self.imgName);
    if (self.isHiddenimg) {
        paySuccess.headerView.successImg.alpha = 0;
        paySuccess.headerView.msg.text = @"买单成功";
        paySuccess.headerView.money.textColor = BASEBLACK;
        paySuccess.headerView.successMsg.text = self.successMsg;
        paySuccess.headerView.successMsg.textColor = BASECOLOR;
    }else {
        paySuccess.headerView.msg.hidden = YES;
    }
    paySuccess.headerView.successMsg.text = self.successMsg;
    paySuccess.cellModelArr = self.cellModelArr;
    [self.baseView addSubview:paySuccess];
    [paySuccess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)rightBarButtonItemDidClick {
    if (self.success) {
        self.success();
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
