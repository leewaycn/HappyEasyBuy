//
//  HEBOrderHotelDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/21.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderHotelDetailViewController.h"
#import "HEBOrderHotelDetailView.h"

@interface HEBOrderHotelDetailViewController ()

@property(nonatomic, strong) HEBOrderHotelDetailView *detailView;

@end

@implementation HEBOrderHotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
}

- (void)setUI {
    HEBOrderHotelDetailView *detailView = [[HEBOrderHotelDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    [Networking postUrl:OrderHotelDetail params:@{@"orderid":self.orderid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        if (mainModel.status) {
            weakSelf.detailView.hotelModel = [HEBOrderHotelDetailModel yy_modelWithJSON:mainModel.data];
            weakSelf.detailView.headerView.msg.text = weakSelf.detailView.hotelModel.order_statusStr;
            weakSelf.detailView.headerView.backgroundColor = BASECOLOR;
            [weakSelf.detailView reloadData];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
