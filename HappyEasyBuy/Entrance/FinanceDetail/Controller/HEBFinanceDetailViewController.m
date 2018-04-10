//
//  HEBFinanceDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/30.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBFinanceDetailViewController.h"
#import "HEBFinanceDetailView.h"

@interface HEBFinanceDetailViewController ()

@property(nonatomic, strong) HEBFinanceDetailView *detailView;

@end

@implementation HEBFinanceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setUI {
    HEBFinanceDetailView *detailView = [[HEBFinanceDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(detailView);
    [self.baseView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self loadNetworking];
}

- (void)loadNetworking {
    [self.progressHUD showAnimated:YES];
    __weak __typeof(self)weakSelf = self;
    [Networking postUrl:GetEarningsDetail params:@{@"f_id":self.objid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        weakSelf.detailView.model = [HEBFinanceDetailMdoel yy_modelWithJSON:mainModel.data];
        [weakSelf.detailView reloadData];
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
