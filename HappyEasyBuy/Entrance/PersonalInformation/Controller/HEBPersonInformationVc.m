//
//  HEBPersonInformationVc.m
//  HappyEasyBuy
//
//  Created by 孙程 on 2017/11/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBPersonInformationVc.h"

#import "HEBPersonalTabView.h"


@interface HEBPersonInformationVc ()

@end

@implementation HEBPersonInformationVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"个人信息"];
}

- (void)setUI {
    HEBPersonalTabView *personView = [[HEBPersonalTabView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.baseView addSubview:personView];
    [personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    __weak __typeof(self)weakSelf = self;
    personView.UserHeaderChange = ^(UIImage *header) {
        if (weakSelf.UserHeaderChange) {
            weakSelf.UserHeaderChange(header);
        }
    };
    personView.UserNickNameChange = ^(NSString *nickName) {
        if (weakSelf.UserNickNameChange) {
            weakSelf.UserNickNameChange(nickName);
        }
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
