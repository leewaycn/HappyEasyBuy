//
//  HEBOrderIntegratedDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderIntegratedDetailViewController.h"
#import "HEBOrderIntegratedDetailView.h"

@interface HEBOrderIntegratedDetailViewController ()

@property(nonatomic, strong) HEBOrderIntegratedDetailView *detailView;

@end

@implementation HEBOrderIntegratedDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
}

- (void)setUI {
    HEBOrderIntegratedDetailView *detailView = [[HEBOrderIntegratedDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    [Networking postUrl:OrderIntegralDetail params:@{@"user_id":getUser_id, @"order":self.orderid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.detailView.integratedModel = [HEBOrderIntegratedDetailModel yy_modelWithJSON:mainModel.data];
            [weakSelf.detailView.headerView.icon yy_setImageWithURL:[NSURL URLWithString:weakSelf.detailView.integratedModel.pic] options:YYWebImageOptionProgressive];
            weakSelf.detailView.headerView.status.text = weakSelf.detailView.integratedModel.status;
            weakSelf.detailView.headerView.time.text = [NSString stringWithFormat:@"时间: %@", weakSelf.detailView.integratedModel.shiptime];
            weakSelf.detailView.headerView.orderNum.text = [NSString stringWithFormat:@"订单号: %@", weakSelf.detailView.integratedModel.ex_odd];
            weakSelf.detailView.headerView.backgroundColor = BASECOLOR;
            [weakSelf.detailView reloadData];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
