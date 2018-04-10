//
//  HEBOrderTakOutDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/22.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderTakOutDetailViewController.h"
#import "HEBOrderTakOutDetailView.h"

@interface HEBOrderTakOutDetailViewController ()

@property(nonatomic, strong) HEBOrderTakOutDetailView *detailView;

@end

@implementation HEBOrderTakOutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"订单详情";
}

- (void)setUI {
    HEBOrderTakOutDetailView *detailView = [[HEBOrderTakOutDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    [Networking postUrl:OrderTakOutDetail params:@{@"orderid":self.orderid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.detailView.takeoutmodel = [HEBOrderTakOutDetailModel yy_modelWithJSON:mainModel.data];
            weakSelf.detailView.headerView.msg.text = weakSelf.detailView.takeoutmodel.order_statusStr;
            weakSelf.detailView.headerView.msg.textColor = BASECOLOR;
            weakSelf.detailView.headerView.backgroundColor = UIColorWhite;
            [weakSelf.detailView reloadData];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
