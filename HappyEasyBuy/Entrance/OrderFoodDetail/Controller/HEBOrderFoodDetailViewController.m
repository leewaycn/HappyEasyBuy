//
//  HEBOrderFoodDetailViewController.m
//  HappyEasyBuy
//
//  Created by Dwang on 2017/12/20.
//  Copyright © 2017年 happyEsayBuy. All rights reserved.
//

#import "HEBOrderFoodDetailViewController.h"
#import "HEBOrderFoodDetailView.h"

@interface HEBOrderFoodDetailViewController ()

/** 主体视图 */
@property(nonatomic, strong) HEBOrderFoodDetailView *detailView;

@end

@implementation HEBOrderFoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
}

- (void)setUI {
    HEBOrderFoodDetailView *detailView = [[HEBOrderFoodDetailView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    selfClass(detailView);
    [self.baseView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self loadNetworking];
}

- (void)loadNetworking {
    __weak __typeof(self)weakSelf = self;
    [self.progressHUD showAnimated:YES];
    [Networking postUrl:self.url params:@{@"orderid":self.orderid} callBack:^(id response, MainModel *mainModel, NSError *errorData) {
        [weakSelf dismissProgressHUD];
        NSLog(@"%@", response);
        if (mainModel.status) {
            HEBOrderFoodDetailModel *model = [HEBOrderFoodDetailModel yy_modelWithJSON:mainModel.data];
            weakSelf.detailView.headerView.backgroundColor = UIColorWhite;
            [weakSelf.detailView.headerView.icon yy_setImageWithURL:[NSURL URLWithString:model.f_pic] options:YYWebImageOptionProgressive];
            weakSelf.detailView.headerView.name.text = model.mname?model.mname:model.f_name;
            weakSelf.detailView.headerView.des.text = model.f_name_account;
            weakSelf.detailView.headerView.des.textColor = model.mname?BASECOLOR:BASEBLACK;
            weakSelf.detailView.headerView.money.attributedText = [Tools toolsEditColorString:[NSString stringWithFormat:@"¥ %@    门市价 ¥ %@", model.f_price, model.f_oprice] searchString:[NSString stringWithFormat:@"门市价 ¥ %@", model.f_oprice] firstColor:BASECOLOR secondColor:UIColorGray];
            weakSelf.detailView.orderModel = model;
            [weakSelf.detailView reloadData];
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
